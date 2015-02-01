//
//  PMEnemyEntity
//  pacman
//
//  Created by Denis Dorokhov on 11/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import "PMEnemyEntity.h"
#import "TDSprite.h"

@interface PMEnemyEntity ()
{
@private

	TDSpriteFrame *frame01;
	TDSpriteFrame *frame02;

	TDSprite *body;

	TDSprite *eyeLeft;
	TDSprite *eyeRight;

	float animationTime;
}

- (void)setup;

- (float)directionEyeToRotation:(PMMovementDirection)aDirection;

@end

@implementation PMEnemyEntity

static float const ANIMATION_INTERVAL = 0.1f;

+ (instancetype)entityWithEnemy:(PMEnemy *)aEnemy
{
	return [[self alloc] initWithEnemy:aEnemy];
}

- (instancetype)initWithEnemy:(PMEnemy *)aEnemy
{
	self = [self init];

	if (self != nil) {
		self.enemy = aEnemy;
	}

	return self;
}

- (instancetype)init
{
	self = [super init];

	if (self != nil) {
		[self setup];
	}

	return self;
}

#pragma mark -
#pragma mark Public

- (void)setEnemy:(PMEnemy *)aEnemy
{
	_enemy = aEnemy;

	[self updateFromObject];
}

#pragma mark -
#pragma mark Override

- (void)onUpdate:(float)aTime
{
	animationTime += aTime;

	if (animationTime >= ANIMATION_INTERVAL) {

		body.frame = (body.frame == frame01 ? frame02 : frame01);

		animationTime = 0;
	}

	[self updateFromObject];
}

#pragma mark -
#pragma mark Private

- (void)setup
{
	NSDictionary *frames = [frameLoader loadBatch:[skin file:@"textures.plist"]];

	frame01 = frames[@"enemy-01"];
	frame02 = frames[@"enemy-02"];

	body = [TDSprite spriteWithSpriteFrame:frame01];

	[self addChild:body];

	eyeLeft = [TDSprite spriteWithSpriteFrame:frames[@"enemy-eye"]];
	eyeLeft.position = [skin point:@"enemyEyeLeftPosition"];

	eyeRight = [TDSprite spriteWithSpriteFrame:frames[@"enemy-eye"]];
	eyeRight.position = [skin point:@"enemyEyeRightPosition"];

	[body addChild:eyeLeft];
	[body addChild:eyeRight];

	animationTime = 0;
}

- (void) updateFromObject
{
	body.position = [locationTransformer objectPositionToScreenPosition:self.enemy.position];

	PMMovementDirection direction = self.enemy.direction;

	eyeLeft.rotation = [self directionEyeToRotation:direction];
	eyeRight.rotation = [self directionEyeToRotation:direction];
}

- (float) directionEyeToRotation:(PMMovementDirection)aDirection
{
	float rotation = 0;

	switch (aDirection) {

		case PMMovementDirection_Up:
			rotation = 90;
			break;

		case PMMovementDirection_Down:
			rotation = -90;
			break;

		case PMMovementDirection_Right:
			rotation = 180;
			break;

		default:
			break;
	}

	return rotation;
}

@end