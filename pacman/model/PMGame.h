//
//  PMGame
//  pacman
//
//  Created by Denis Dorokhov on 10/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PMMap.h"
#import "PMPlayer.h"
#import "PMObstacle.h"
#import "PMEnemy.h"
#import "PMFood.h"

/**
* Game state.
*/
typedef NS_ENUM(NSInteger, PMGameState)
{
	/**
	* Game is playing.
	*/
	PMGameState_Play,
	/**
	* Game victory.
	*/
	PMGameState_Victory,
	/**
	* Game defeat.
	*/
	PMGameState_Defeat
};

/**
* Game model. All model objects are created on initialization and resetting.
*/
@interface PMGame : NSObject

/**
* Game state.
*/
@property (nonatomic) PMGameState state;

/**
* Game map.
*/
@property (nonatomic, strong) PMMap *map;

/**
* Game player.
*/
@property (nonatomic, readonly) PMPlayer *player;

/**
* Game obstacles (NSArray of PMObstacle objects).
*/
@property (nonatomic, readonly) NSArray *obstacles;

/**
* Game food (NSArray of PMFood objects).
*/
@property (nonatomic, readonly) NSArray *food;

/**
* Game enemies (NSArray of PMEnemy objects).
*/
@property (nonatomic, readonly) NSArray *enemies;

/**
* Number of not consumed food objects.
*/
@property (nonatomic, readonly) NSUInteger notConsumedFoodCount;

/**
* Builds a game.
*/
+ (instancetype)game;

/**
* Builds a game with some map.
*/
+ (instancetype)gameWithMap:(PMMap *)aMap;

/**
* Initializes a game with some map.
*/
- (instancetype)initWithMap:(PMMap *)aMap;

/**
* Reset all game data to initial map state.
*/
- (void)reset;

/**
* Returns obstacle at some location or nil if map location is invalid or there is no obstacle at this location.
*/
- (PMObstacle *)obstacleAtLocation:(PMMapLocation)aLocation;

/**
* Returns food at some location or nil if map location is invalid or there is no food at this location.
*/
- (PMFood *)foodAtLocation:(PMMapLocation)aLocation;

/**
* Returns food model instance if it's consumed on location. Otherwise nil will be returned.
*/
- (PMFood *)consumeFoodAtLocation:(PMMapLocation)aLocation;

@end