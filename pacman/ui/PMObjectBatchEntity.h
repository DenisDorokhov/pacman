//
//  PMObjectBatchEntity
//  pacman
//
//  Created by Denis Dorokhov on 13/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PMEntity.h"
#import "PMObject.h"
#import "TDSpriteFrame.h"

/**
* Game object batch renderer. Renders many objects in one OpenGL draw call.
*/
@interface PMObjectBatchEntity : PMEntity
{
@protected

	GLfloat *vertexData;
	GLfloat *uvData;
	GLubyte *colorData;
	GLushort *indexData;
}

/**
* Objects to render (NSArray of PMObject).
*/
@property (nonatomic, readonly) NSArray *objects;

/**
* Sprite frame to use for rendering.
*/
@property (nonatomic, readonly) TDSpriteFrame *frame;

/**
* Builds batch entity with some objects and sprite frame.
*/
+ (instancetype)entityWithObjects:(NSArray *)aObjects frame:(TDSpriteFrame *)aFrame;

/**
* Initializes batch entity with some objects and sprite frame.
*/
- (instancetype)initWithObjects:(NSArray *)aObjects frame:(TDSpriteFrame *)aFrame;

/**
* Sets objects and sprite frame.
*/
- (void)setObjects:(NSArray *)aObjects frame:(TDSpriteFrame *)aFrame;

/**
* Invalidates an object.
*/
- (void)invalidateObject:(PMObject *)aObject;

/**
* Invalidates object at some index.
*/
- (void)invalidateObjectAtIndex:(NSUInteger)aIndex;

@end