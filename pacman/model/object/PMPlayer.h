//
//  PMPlayer
//  pacman
//
//  Created by Denis Dorokhov on 10/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PMMovingObject.h"

/**
* Game player model.
*/
@interface PMPlayer : PMMovingObject

/**
* Target velocity vector. Main velocity will be replaced by this one as soon as possible.
*/
@property (nonatomic) CGPoint targetVelocity;

/**
* Target velocity direction.
*/
@property (nonatomic, readonly) PMMovementDirection targetDirection;

/**
* Set target velocity vector of particular direction.
*/
- (void)setTargetVelocity:(float)aVelocity inDirection:(PMMovementDirection)aDirection;

@end