//
//  PMGame
//  pacman
//
//  Created by Denis Dorokhov on 10/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import "PMGame.h"

@interface PMGame ()
{
@private

	DDFixedSizeMatrix *obstacleMatrix;
	DDFixedSizeMatrix *foodMatrix;
}

- (void)setupPlayer;

- (void) setupObstacles;
- (void) setupFood;
- (void) setupEnemies;

@end


@implementation PMGame

+ (instancetype)game
{
	return [[self alloc] init];
}

+ (instancetype)gameWithMap:(PMMap *)aMap
{
	return [[self alloc] initWithMap:aMap];
}

- (instancetype)initWithMap:(PMMap *)aMap
{
	self = [self init];

	if (self != nil) {
		self.map = aMap;
	}

	return self;
}

- (instancetype)init
{
	self = [super init];

	if (self != nil) {
		self.state = PMGameState_Play;
	}

	return self;
}

#pragma mark -
#pragma mark Public

- (void)setMap:(PMMap *)aMap
{
	_map = aMap;

	[self reset];
}

- (void)reset
{
	self.state = PMGameState_Play;

	[self setupPlayer];

	[self setupObstacles];
	[self setupFood];
	[self setupEnemies];
}

- (PMObstacle *)obstacleAtLocation:(PMMapLocation)aLocation
{
	PMObstacle *obstacle = nil;

	if ([self.map doesContainLocation:aLocation]) {
		obstacle = [obstacleMatrix objectAtColumn:(NSUInteger) aLocation.x row:(NSUInteger) aLocation.y];
	}

	return obstacle;
}

- (PMFood *)foodAtLocation:(PMMapLocation)aLocation
{
	PMFood *food = nil;

	if ([self.map doesContainLocation:aLocation]) {
		food = [foodMatrix objectAtColumn:(NSUInteger)aLocation.x row:(NSUInteger)aLocation.y];
	}

	return food;
}

- (PMFood *)consumeFoodAtLocation:(PMMapLocation)aLocation
{
	PMFood *food = [self foodAtLocation:aLocation];

	if (food != nil && !food.isConsumed) {

		food.isConsumed = YES;

		_notConsumedFoodCount--;

		return food;
	}

	return nil;
}

#pragma mark -
#pragma mark Private

- (void)setupPlayer
{
	NSArray *cells = [_map cellsOfType:PMMapCellType_Player];

	if ([cells count] == 0) {
		[NSException raise:NSStringFromClass([self class]) format:@"no player defined in map"];
	}
	if ([cells count] > 1) {
		[NSException raise:NSStringFromClass([self class]) format:@"more than one player defined in map"];
	}

	PMMapCell *cell = cells[0];

	_player = [PMPlayer objectWithPosition:PMMapLocationToPoint(cell.location)];
}

- (void) setupObstacles
{
	obstacleMatrix = [[DDFixedSizeMatrix alloc] initWithColumns:self.map.width rows:self.map.height];

	_obstacles = [[NSMutableArray alloc] init];

	for (PMMapCell *cell in [_map cellsOfType:PMMapCellType_Obstacle]) {

		PMObstacle *obstacleItem = [PMObstacle objectWithPosition:PMMapLocationToPoint(cell.location)];

		[(NSMutableArray *) _obstacles addObject:obstacleItem];

		[obstacleMatrix replaceObject:obstacleItem
							 atColumn:(NSUInteger)cell.location.x row:(NSUInteger)cell.location.y];
	}
}

- (void) setupFood
{
	foodMatrix = [[DDFixedSizeMatrix alloc] initWithColumns:self.map.width rows:self.map.height];

	_food = [[NSMutableArray alloc] init];

	for (PMMapCell *cell in [_map cellsOfType:PMMapCellType_Food]) {

		PMFood *foodItem = [PMFood objectWithPosition:PMMapLocationToPoint(cell.location)];

		[(NSMutableArray *) _food addObject:foodItem];

		[foodMatrix replaceObject:foodItem
						 atColumn:(NSUInteger)cell.location.x row:(NSUInteger)cell.location.y];
	}

	_notConsumedFoodCount = [_food count];
}

- (void) setupEnemies
{
	_enemies = [[NSMutableArray alloc] init];

	for (PMMapCell *cell in [_map cellsOfType:PMMapCellType_Enemy]) {
		[(NSMutableArray *) _enemies addObject:[PMEnemy objectWithPosition:PMMapLocationToPoint(cell.location)]];
	}
}

@end