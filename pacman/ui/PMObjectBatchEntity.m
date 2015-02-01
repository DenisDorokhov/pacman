//
//  PMObjectBatchEntity
//  pacman
//
//  Created by Denis Dorokhov on 13/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import "PMObjectBatchEntity.h"
#import "TDEntity+Protected.h"
#import "PMObjectBatchEntity+Protected.h"
#import <OpenGLES/ES1/gl.h>

@interface PMObjectBatchEntity ()
{
@private

	BOOL isDataInvalid;
}

@end

@implementation PMObjectBatchEntity

+ (instancetype)entityWithObjects:(NSArray *)aObjects frame:(TDSpriteFrame *)aFrame
{
	return [[self alloc] initWithObjects:aObjects frame:aFrame];
}

- (instancetype)initWithObjects:(NSArray *)aObjects frame:(TDSpriteFrame *)aFrame
{
	self = [self init];

	if (self != nil) {
		[self setObjects:aObjects frame:aFrame];
	}

	return self;
}

- (void)dealloc
{
	[self freeArrays];
}

#pragma mark -
#pragma mark Public

- (void)setObjects:(NSArray *)aObjects frame:(TDSpriteFrame *)aFrame
{
	_frame = aFrame;

	_objects = aObjects;

	[self freeArrays];

	vertexData = calloc([self objectVertexSize] * [_objects count], sizeof(GLfloat));
	uvData = calloc([self objectUVSize] * [_objects count], sizeof(GLfloat));
	colorData = calloc([self objectColorSize] * [_objects count], sizeof(GLubyte));
	indexData = calloc([self objectIndexSize] * [_objects count], sizeof(GLushort));

	isDataInvalid = YES;
}

- (void)invalidateObject:(PMObject *)aObject
{
	[self invalidateObjectAtIndex:[self.objects indexOfObject:aObject]];
}

- (void)invalidateObjectAtIndex:(NSUInteger)aIndex
{
	[self validateObjectAtIndex:aIndex];
}

#pragma mark -
#pragma mark Override

- (void)validate
{
	[super validate];

	if (isDataInvalid) {
		for (NSUInteger i = 0; i < [self.objects count]; i++) {
			[self validateObjectAtIndex:i];
		}
	}
}

- (void)draw
{
	if ([_objects count] > 0) {

		glEnable(GL_TEXTURE_2D);
		glEnable(GL_BLEND);

		glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

		glBindTexture(GL_TEXTURE_2D, self.frame.texture.glTexture);

		glVertexPointer(3, GL_FLOAT, 0, vertexData);
		glColorPointer(4, GL_UNSIGNED_BYTE, 0, colorData);
		glTexCoordPointer(2, GL_FLOAT, 0, uvData);

		glDrawElements(GL_TRIANGLES, (GLsizei) ([self objectIndexSize] * [_objects count]), GL_UNSIGNED_SHORT, indexData);

		glDisable(GL_BLEND);
		glDisable(GL_TEXTURE_2D);
	}
}

#pragma mark -
#pragma mark Protected

- (size_t)objectVertexSize
{
	return 12;
}

- (size_t)objectUVSize
{
	return 8;
}

- (size_t)objectColorSize
{
	return 16;
}

- (size_t)objectIndexSize
{
	return 6;
}

- (void)freeArrays
{
	if (vertexData != NULL) {

		free(vertexData);

		vertexData = NULL;
	}
	if (uvData != NULL) {

		free(uvData);

		uvData = NULL;
	}
	if (colorData != NULL) {

		free(colorData);

		colorData = NULL;
	}
	if (indexData != NULL) {

		free(indexData);

		indexData = NULL;
	}
}

- (void)validateObjectAtIndex:(NSUInteger)aIndex
{
	PMObject *object = self.objects[aIndex];

	size_t baseVertexIndex = [self objectVertexSize] * aIndex;
	size_t baseUVIndex = [self objectUVSize] * aIndex;
	size_t baseColorIndex = [self objectColorSize] * aIndex;
	size_t baseIndexIndex = [self objectIndexSize] * aIndex;

	CGPoint objectPosition = [locationTransformer objectPositionToScreenPosition:object.position];

	// bottom-left
	vertexData[baseVertexIndex + 0] = objectPosition.x - self.frame.size.width / 2;
	vertexData[baseVertexIndex + 1] = objectPosition.y - self.frame.size.height / 2;
	vertexData[baseVertexIndex + 2] = 0;

	// top-left
	vertexData[baseVertexIndex + 3] = vertexData[baseVertexIndex + 0];
	vertexData[baseVertexIndex + 4] = objectPosition.y + self.frame.size.height / 2;
	vertexData[baseVertexIndex + 5] = 0;

	// bottom-right
	vertexData[baseVertexIndex + 6] = objectPosition.x + self.frame.size.width / 2;
	vertexData[baseVertexIndex + 7] = vertexData[baseVertexIndex + 1];
	vertexData[baseVertexIndex + 8] = 0;

	// top-right
	vertexData[baseVertexIndex + 9] = vertexData[baseVertexIndex + 6];
	vertexData[baseVertexIndex + 10] = vertexData[baseVertexIndex + 4];
	vertexData[baseVertexIndex + 11] = 0;

	// bottom-left
	uvData[baseUVIndex + 0] = self.frame.position.x / self.frame.texture.size.width;
	uvData[baseUVIndex + 1] = (self.frame.position.y + self.frame.size.height) / self.frame.texture.size.height;

	// top-left
	uvData[baseUVIndex + 2] = uvData[baseUVIndex + 0];
	uvData[baseUVIndex + 3] = self.frame.position.y / self.frame.texture.size.height;

	// bottom-right
	uvData[baseUVIndex + 4] = (self.frame.position.x + self.frame.size.width) / self.frame.texture.size.width;
	uvData[baseUVIndex + 5] = uvData[baseUVIndex + 1];

	// top-right
	uvData[baseUVIndex + 6] = uvData[baseUVIndex + 4];
	uvData[baseUVIndex + 7] = uvData[baseUVIndex + 3];

	for (size_t j = 0; j < [self objectColorSize]; j++) {
		colorData[baseColorIndex + j] = 0xFF;
	}

	GLushort baseIndexValue = (GLushort)(4 * aIndex);

	indexData[baseIndexIndex + 0] = (GLushort) (baseIndexValue + 0);
	indexData[baseIndexIndex + 1] = (GLushort) (baseIndexValue + 1);
	indexData[baseIndexIndex + 2] = (GLushort) (baseIndexValue + 2);
	indexData[baseIndexIndex + 3] = (GLushort) (baseIndexValue + 1);
	indexData[baseIndexIndex + 4] = (GLushort) (baseIndexValue + 2);
	indexData[baseIndexIndex + 5] = (GLushort) (baseIndexValue + 3);
}

@end