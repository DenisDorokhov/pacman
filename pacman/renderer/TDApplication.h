//
//  TDApplication
//  pacman
//
//  Created by Denis Dorokhov on 09/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TDGLView.h"
#import "TDUtil.h"
#import "TDEntity.h"

@class TDApplication;

/**
* 2D application delegate.
*/
@protocol TDApplicationDelegate <NSObject>

/**
* This method is called before scene update.
*/
- (void) application:(TDApplication *)aApplication willUpdate:(float)aTime;

/**
* This method is called after scene update.
*/
- (void) application:(TDApplication *)aApplication didUpdate:(float)aTime;

/**
* This method is called before scene rendering.
*/
- (void)applicationWillRender:(TDApplication *)aApplication;

/**
* This method is called after scene rendering.
*/
- (void)applicationDidRender:(TDApplication *)aApplication;

@end

/**
* 2D application.
*/
@interface TDApplication : NSObject <TDTouchHandler>

/**
* OpenGL view.
*/
@property (nonatomic, strong) TDGLView *view;

/**
* Surface size in pixels.
*/
@property (nonatomic, readonly) CGSize surfaceSize;

/**
* Surface color.
*/
@property (nonatomic) tdColorByte surfaceColor;

/**
* Current scene.
*/
@property (nonatomic, strong) TDEntity *currentScene;

/**
* Is application paused? When application is paused, it does not update.
*/
@property (nonatomic) BOOL isPaused;

/**
* Application delegate.
*/
@property (nonatomic, weak) id <TDApplicationDelegate> delegate;

/**
* Adds touch handler to the application.
*/
- (void)addTouchHandler:(id <TDTouchHandler>)aTouchHandler;

/**
* Removes touch handler from the application.
*/
- (void)removeTouchHandler:(id <TDTouchHandler>)aTouchHandler;

/**
* Returns touch position in 2D application coordinates.
*/
- (CGPoint)touchPosition:(UITouch *)aTouch;

@end