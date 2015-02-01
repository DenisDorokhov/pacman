//
//  TDEntity(Protected)
//  pacman
//
//  Created by Denis Dorokhov on 09/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TDEntity.h"

/**
* 2D application entity protected methods.
*/
@interface TDEntity (Protected)

/**
* Activation hook. It is called before children are activated.
*/
- (void)onActivated;

/**
* Passivation hook. It is called before children are passivated.
*/
- (void)onPassivated;

/**
* Validates object properties. This method is called before transformation.
*/
- (void)validate;

/**
* Transforms entity applying anchor, position, rotation and scale.
*/
- (void)transform;

/**
* Update hook. It is called before children are updated.
*/
- (void)onUpdate:(float)aTime;

/**
* Draws the entity.
*/
- (void)draw;

@end