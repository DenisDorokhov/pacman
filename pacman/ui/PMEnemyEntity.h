//
//  PMEnemyEntity
//  pacman
//
//  Created by Denis Dorokhov on 11/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PMEntity.h"
#import "TDSprite.h"
#import "PMEnemy.h"

/**
* Enemy renderer.
*/
@interface PMEnemyEntity : PMEntity

/**
* Enemy model.
*/
@property (nonatomic, strong) PMEnemy *enemy;

/**
* Builds enemy entity with some model.
*/
+ (instancetype)entityWithEnemy:(PMEnemy *)aEnemy;

/**
* Initializes enemy entity with some model.
*/
- (instancetype)initWithEnemy:(PMEnemy *)aEnemy;

@end