//
//  TDGLView+Protected(Protected)
//  pacman
//
//  Created by Denis Dorokhov on 09/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TDGLView.h"

/**
* OpenGL ES1 view protected methods.
*/
@interface TDGLView (Protected)

/**
* Sets up render buffer.
*/
- (void) setupRenderBuffer;

/**
* Sets up frame buffer.
*/
- (void) setupFrameBuffer;

@end