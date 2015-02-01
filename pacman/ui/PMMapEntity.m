//
//  PMMapEntity
//  pacman
//
//  Created by Denis Dorokhov on 12/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import "PMMapEntity.h"
#import "PMFoodEntity.h"
#import "PMPlayerEntity.h"
#import "PMEnemyEntity.h"
#import "PMObjectBatchEntity.h"

@interface PMMapEntity ()

- (void) updateMap;

@end

@implementation PMMapEntity

#pragma mark -
#pragma mark Public

- (void) setGame:(PMGame *)aGame
{
	_game = aGame;

	[self updateMap];
}

#pragma mark -
#pragma mark Private

- (void) updateMap
{
	[self removeAllChildren];

	NSDictionary *frames = [frameLoader loadBatch:[skin file:@"textures.plist"]];

	[self addChild:[PMObjectBatchEntity entityWithObjects:self.game.obstacles
	                                                frame:frames[@"stone"]]];

	[self addChild:[PMFoodEntity entityWithFood:self.game.food]];

	[self addChild:[PMPlayerEntity entityWithPlayer:self.game.player]];

	for (PMEnemy *enemy in self.game.enemies) {
		[self addChild:[PMEnemyEntity entityWithEnemy:enemy]];
	}
}

@end