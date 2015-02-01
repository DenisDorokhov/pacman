//
//  PMGameController
//  pacman
//
//  Created by Denis Dorokhov on 10/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PMGame.h"
#import "DDEventDispatcher.h"

/**
* Game controller. All model modification is done here.
*/
@interface PMGameController : NSObject

/**
* Starts new game.
*/
- (PMGame *)startGame;

/**
* Resets the game.
*/
- (PMGame *)resetGame:(PMGame *)aGame;

/**
* Make game world step.
*/
- (void)updateWithStep:(float)aTime game:(PMGame *)aGame;

/**
* Update player target direction. Player's real direction will be updated to this one as soon as possible.
*/
- (void)updatePlayerDirection:(PMMovementDirection)aDirection game:(PMGame *)aGame;

@end