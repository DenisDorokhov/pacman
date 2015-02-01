//
//  PMGameController
//  pacman
//
//  Created by Denis Dorokhov on 10/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import "PMGameController.h"
#import "PMServiceLocator.h"
#import "PMMapLocation.h"
#import "PMGameStatusEvent.h"
#import "PMGameFoodEvent.h"
#import "DDRandomUtil.h"

@interface PMGameController ()
{
@private

	DDEventDispatcher *commonEventDispatcher;
}

- (void)doStep:(float)aTime game:(PMGame *)aGame;

- (void)updatePlayer:(PMGame *)aGame time:(float)aTime;
- (void)updateEnemy:(PMEnemy *)aEnemy game:(PMGame *)aGame time:(float)aTime;

- (void)updateEnemyRoute:(PMEnemy *)aEnemy game:(PMGame *)aGame;

- (BOOL)isLocationVacant:(PMMapLocation)aLocation game:(PMGame *)aGame;

- (void)checkDefeatByEnemy:(PMEnemy *)aEnemy game:(PMGame *)aGame;
- (void)checkVictory:(PMGame *)aGame;

@end

@implementation PMGameController

static float const PLAYER_VELOCITY = 5;
static float const ENEMY_VELOCITY = 5;

static float const MINIMAL_PLAYER_ENEMY_DISTANCE = 0.3f;

static uint const ENEMY_REACTION_RATE = 80; // 0 .. 100

static float const MAX_STEP_TIME = 0.05f;

- (instancetype)init
{
	self = [super init];

	if (self != nil) {
		commonEventDispatcher = [PMServiceLocator eventDispatcher];
	}

	return self;
}

#pragma mark -
#pragma mark Public

- (PMGame *)startGame
{
	PMMap *map = [[PMServiceLocator mapLoader] loadMap];

	return [PMGame gameWithMap:map];
}

- (PMGame *)resetGame:(PMGame *)aGame
{
	[aGame reset];

	return aGame;
}

- (void)updateWithStep:(float)aTime game:(PMGame *)aGame
{
	if (aGame.state == PMGameState_Play) {

		int stepsCount = (int) (aTime / MAX_STEP_TIME);

		if (stepsCount > 0) {

			for (int i = 1; i <= stepsCount; i++) {
				[self doStep:MAX_STEP_TIME game:aGame];
			}

			float timeLeft = aTime - stepsCount * MAX_STEP_TIME;

			if (timeLeft > 0) {
				[self doStep:timeLeft game:aGame];
			}

		} else {
			[self doStep:aTime game:aGame];
		}
	}
}

- (void)updatePlayerDirection:(PMMovementDirection)aDirection game:(PMGame *)aGame
{
	if (aGame.state == PMGameState_Play && aGame.player.targetDirection != aDirection) {

		ddlog(@"updating player target direction from [%@] to [%@]",PMMovementDirectionToString(aGame.player.targetDirection),PMMovementDirectionToString(aDirection));

		[aGame.player setTargetVelocity:PLAYER_VELOCITY inDirection:aDirection];

		if (CGPointIsZero(aGame.player.velocity)) {
			aGame.player.velocity = aGame.player.targetVelocity;
		}

		if (![self isLocationVacant:[aGame.player nextMapLocation] game:aGame]) {
			aGame.player.velocity = CGPointZero;
		}
	}
}

#pragma mark -
#pragma mark Private

- (void)doStep:(float)aTime game:(PMGame *)aGame
{
	[self updatePlayer:aGame time:aTime];

	for (PMEnemy *enemy in aGame.enemies) {
		[self updateEnemy:enemy game:aGame time:aTime];
	}
}

- (void)updatePlayer:(PMGame *)aGame time:(float)aTime
{
	PMMapLocation lastLocation = [aGame.player currentMapLocation];
	PMMapLocation currentLocation = lastLocation;

	if (!CGPointIsZero(aGame.player.velocity)) {

		aGame.player.position = CGPointAdd(aGame.player.position, CGPointMultiply(aGame.player.velocity, aTime));

		currentLocation = [aGame.player currentMapLocation];

		PMMapLocation nextLocation = [aGame.player nextMapLocation];

		if (![self isLocationVacant:nextLocation game:aGame]) {

			ddlog(@"next map location [%ld, %ld] is not vacant for player", (long) nextLocation.x, (long) nextLocation.y);

			aGame.player.position = PMMapLocationToPoint(currentLocation);
			aGame.player.velocity = CGPointZero;
		}
	}

	if (!PMMapLocationEqualToLocation(lastLocation, currentLocation)) {

		PMFood *consumedFood = [aGame consumeFoodAtLocation:currentLocation];

		if (consumedFood != nil) {
			PMGameFoodEvent *foodEvent = [PMGameFoodEvent eventWithType:[PMGameFoodEvent didConsumeFood]];
			foodEvent.food = consumedFood;
			[commonEventDispatcher dispatchEvent:foodEvent];
		}

		if (aGame.player.direction != aGame.player.targetDirection) {

			CGPoint lastVelocity = aGame.player.velocity;

			aGame.player.position = PMMapLocationToPoint(currentLocation);
			aGame.player.velocity = aGame.player.targetVelocity;

			PMMapLocation nextLocation = [aGame.player nextMapLocation];

			if ([self isLocationVacant:nextLocation game:aGame]) {
				ddlog(@"changing player direction from [%@] to [%@]", PMMovementDirectionToString(aGame.player.direction), PMMovementDirectionToString(aGame.player.targetDirection));
			} else {
				aGame.player.velocity = lastVelocity;
			}
		}

		[self checkVictory:aGame];
	}
}

- (void)updateEnemy:(PMEnemy *)aEnemy game:(PMGame *)aGame time:(float)aTime
{
	PMMapLocation lastLocation = [aEnemy currentMapLocation];
	PMMapLocation currentLocation = lastLocation;

	BOOL isDeadEnd = NO;

	if (CGPointIsZero(aEnemy.velocity)) {
		[self updateEnemyRoute:aEnemy game:aGame];
	}

	if (!CGPointIsZero(aEnemy.velocity)) {

		aEnemy.position = CGPointAdd(aEnemy.position, CGPointMultiply(aEnemy.velocity, aTime));

		currentLocation = [aEnemy currentMapLocation];

		PMMapLocation nextLocation = [aEnemy nextMapLocation];

		if (![self isLocationVacant:nextLocation game:aGame]) {

			aEnemy.position = PMMapLocationToPoint(currentLocation);

			isDeadEnd = YES;
		}
	}

	if (!PMMapLocationEqualToLocation(lastLocation, currentLocation)) {
		if (isDeadEnd || [DDRandomUtil boolWithProbability:ENEMY_REACTION_RATE]) {
			[self updateEnemyRoute:aEnemy game:aGame];
		}
	}

	[self checkDefeatByEnemy:aEnemy game:aGame];
}

- (void)updateEnemyRoute:(PMEnemy *)aEnemy game:(PMGame *)aGame
{
	PMMapLocation enemyLocation = [aEnemy currentMapLocation];
	PMMapLocation playerLocation = [aGame.player currentMapLocation];

	CGPoint playerLocationPoint = PMMapLocationToPoint(playerLocation);

	PMMapLocation locationUp = [aEnemy mapLocationInDirection:PMMovementDirection_Up];
	PMMapLocation locationDown = [aEnemy mapLocationInDirection:PMMovementDirection_Down];
	PMMapLocation locationRight = [aEnemy mapLocationInDirection:PMMovementDirection_Right];
	PMMapLocation locationLeft = [aEnemy mapLocationInDirection:PMMovementDirection_Left];

	PMMovementDirection direction = aEnemy.direction;
	PMMovementDirection directionOpposite = PMMovementDirectionOpposite(direction);

	PMMovementDirection directionUpdated = PMMovementDirection_None;

	float distanceMin = -1;

#define CHECK_ENEMY_DIRECTION(mapLocation, movementDirection) 										\
if (movementDirection != directionOpposite && [self isLocationVacant:mapLocation game:aGame]) {		\
	float distance = CGPointDistance(playerLocationPoint, PMMapLocationToPoint(mapLocation));		\
	if (distanceMin < 0 || distance < distanceMin) {												\
		distanceMin = distance;																		\
		directionUpdated = movementDirection;														\
	}																								\
}																									\

	CHECK_ENEMY_DIRECTION(locationUp, PMMovementDirection_Up);
	CHECK_ENEMY_DIRECTION(locationDown, PMMovementDirection_Down);
	CHECK_ENEMY_DIRECTION(locationRight, PMMovementDirection_Right);
	CHECK_ENEMY_DIRECTION(locationLeft, PMMovementDirection_Left);

	if (directionUpdated != PMMovementDirection_None && directionUpdated != direction) {

		ddlog(@"updated enemy [%@] direction [%@] in [%ld, %ld]", aEnemy, PMMovementDirectionToString(directionUpdated), (long) enemyLocation.x, (long) enemyLocation.y);

		[aEnemy setVelocity:ENEMY_VELOCITY inDirection:directionUpdated];

		aEnemy.position = PMMapLocationToPoint(enemyLocation);
	}
}

- (BOOL)isLocationVacant:(PMMapLocation)aLocation game:(PMGame *)aGame
{
	return [aGame.map doesContainLocation:aLocation] && [aGame obstacleAtLocation:aLocation] == nil;
}

- (void)checkDefeatByEnemy:(PMEnemy *)aEnemy game:(PMGame *)aGame
{
	float distance = CGPointDistance(aEnemy.position, aGame.player.position);

	if (distance < MINIMAL_PLAYER_ENEMY_DISTANCE) {

		aGame.state = PMGameState_Defeat;

		[commonEventDispatcher dispatchEvent:[PMGameStatusEvent eventWithType:[PMGameStatusEvent didCommitDefeat]]];

		ddlog(@"defeat");
	}
}

- (void)checkVictory:(PMGame *)aGame
{
	if (aGame.notConsumedFoodCount == 0) {

		aGame.state = PMGameState_Victory;

		[commonEventDispatcher dispatchEvent:[PMGameStatusEvent eventWithType:[PMGameStatusEvent didCommitVictory]]];

		ddlog(@"victory");
	}
}

@end