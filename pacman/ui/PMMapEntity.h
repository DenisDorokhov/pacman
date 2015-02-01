//
//  PMMapEntity
//  pacman
//
//  Created by Denis Dorokhov on 12/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PMEntity.h"
#import "PMGame.h"

/**
* Game map renderer.
*/
@interface PMMapEntity : PMEntity

/**
* Game model.
*/
@property (nonatomic, strong) PMGame *game;

@end