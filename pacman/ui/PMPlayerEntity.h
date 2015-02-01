//
//  PMPlayerEntity
//  pacman
//
//  Created by Denis Dorokhov on 10/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PMPlayer.h"
#import "DDSkin.h"
#import "PMEntity.h"
#import "TDSprite.h"

/**
* Player renderer.
*/
@interface PMPlayerEntity : PMEntity

/**
* Player model.
*/
@property (nonatomic, strong) PMPlayer *player;

/**
* Builds player entity with some model.
*/
+ (instancetype)entityWithPlayer:(PMPlayer *)aPlayer;

/**
* Initializes player entity with some model.
*/
- (instancetype)initWithPlayer:(PMPlayer *)aPlayer;

@end