//
//  TDApplication(Protected)
//  pacman
//
//  Created by Denis Dorokhov on 09/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TDApplication.h"

/**
* 2D application protected methods.
*/
@interface TDApplication (Protected)

/**
* Adds rendering operation to run loop.
*/
- (void)addToRunLoop;

/**
* Removes rendering operation from run loop.
*/
- (void)removeFromRunLoop;

/**
* Sets up surface size.
*/
- (void)setupSurface;

/**
* Sets up projection.
*/
- (void)setupProjection;

/**
* Handles run loop step.
*/
- (void)handleDisplayLinkStep:(CADisplayLink *)aDisplayLink;

/**
* Updates scene.
*/
- (void)updateScene:(double)aTimestamp;

/**
* Renders scene.
*/
- (void)renderScene;

@end