//
//  TDFPSCounter
//  pacman
//
//  Created by Denis Dorokhov on 12/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TDApplication.h"

/**
* Simple FPS counter. Must be added to 2D application as a delegate.
*/
@interface TDFPSCounter : NSObject <TDApplicationDelegate>

/**
* FPS update interval in seconds. It is 1 by default.
*/
@property (nonatomic) float fpsUpdateInterval;

/**
* Current FPS value.
*/
@property (nonatomic, readonly) float fps;

/**
* When YES, current FPS will be written to console.
*/
@property (nonatomic) BOOL consoleOutput;

@end