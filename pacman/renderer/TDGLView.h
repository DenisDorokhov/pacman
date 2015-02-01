//
//  TDGLView+Protected
//  pacman
//
//  Created by Denis Dorokhov on 09/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "TDTouchHandler.h"

/**
* OpenGL ES1 view implementation.
*/
@interface TDGLView : UIView

/**
* EAGLContext instance.
*/
@property (nonatomic, readonly) EAGLContext *context;

/**
* Render buffer.
*/
@property (nonatomic, readonly) GLuint renderBuffer;

/**
* Frame buffer.
*/
@property (nonatomic, readonly) GLuint frameBuffer;

/**
* Touch handler.
*/
@property (nonatomic, weak) id <TDTouchHandler> touchHandler;

/**
* Build view with some frame.
*/
+ (instancetype)viewWithFrame:(CGRect)aFrame;

/**
* Renders view.
*/
- (void)render;

@end