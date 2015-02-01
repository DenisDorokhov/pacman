//
//  TDSprite
//  pacman
//
//  Created by Denis Dorokhov on 09/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import "TDSprite.h"
#import "TDEntity+Protected.h"
#import <OpenGLES/ES1/gl.h>

#define SWAP(x, y) do { typeof(x) tmp = x; x = y; y = tmp; } while (0)

@interface TDSprite ()
{
@private

	BOOL isVertexDataInvalid;
	BOOL isUVDataInvalid;
	BOOL isColorDataInvalid;

	float vertexData[12];
	float uvData[8];
	GLubyte colorData[16];
}

- (void) invalidateVertexData;
- (void) invalidateUVData;
- (void) invalidateColorData;

@end

@implementation TDSprite

@synthesize color = _color;

+ (instancetype)spriteWithSpriteFrame:(TDSpriteFrame *)aFrame
{
	return [[self alloc] initWithSpriteFrame:aFrame];
}

- (instancetype)init
{
	self = [super init];

	if (self != nil) {

		self.color = tdColorByteMake(0xFF, 0xFF, 0xFF, 0xFF);

		self.flipX = NO;
		self.flipY = NO;
	}

	return self;
}

- (instancetype)initWithSpriteFrame:(TDSpriteFrame *)aFrame
{
	self = [self init];

	if (self != nil) {
		self.frame = aFrame;
	}

	return self;
}

#pragma mark -
#pragma mark Public

- (void)setFrame:(TDSpriteFrame *)aFrame
{
	_frame = aFrame;

	self.size = _frame.size;

	[self invalidateVertexData];
	[self invalidateUVData];
}

- (void)setColor:(tdColorByte)aColor
{
	_color = aColor;

	[self invalidateColorData];
}

- (unsigned char)opacity
{
	return self.color.alpha;
}

- (void)setOpacity:(unsigned char)aOpacity
{
	tdColorByte oldColor = self.color;

	self.color = tdColorByteMake(oldColor.red, oldColor.green, oldColor.blue, aOpacity);
}

- (void)setFlipX:(BOOL)aFlipX
{
	_flipX = aFlipX;

	[self invalidateUVData];
}

- (void)setFlipY:(BOOL)aFlipY
{
	_flipY = aFlipY;

	[self invalidateUVData];
}

#pragma mark -
#pragma mark Override

- (void)validate
{
	[super validate];

	if (isVertexDataInvalid) {

		// bottom-left
		vertexData[0] = 0;
		vertexData[1] = 0;
		vertexData[2] = 0;

		// top-left
		vertexData[3] = 0;
		vertexData[4] = self.frame.size.height;
		vertexData[5] = 0;

		// bottom-right
		vertexData[6] = self.frame.size.width;
		vertexData[7] = 0;
		vertexData[8] = 0;

		// top-right
		vertexData[9] = self.frame.size.width;
		vertexData[10] = self.frame.size.height;
		vertexData[11] = 0;

		isVertexDataInvalid = NO;
	}

	if (isUVDataInvalid) {

		// bottom-left
		uvData[0] = self.frame.position.x / self.frame.texture.size.width;
		uvData[1] = (self.frame.position.y + self.frame.size.height) / self.frame.texture.size.height;

		// top-left
		uvData[2] = uvData[0];
		uvData[3] = self.frame.position.y / self.frame.texture.size.height;

		// bottom-right
		uvData[4] = (self.frame.position.x + self.frame.size.width) / self.frame.texture.size.width;
		uvData[5] = uvData[1];

		// top-right
		uvData[6] = uvData[4];
		uvData[7] = uvData[3];

		if (self.flipX) {
			SWAP(uvData[0], uvData[4]);
			SWAP(uvData[2], uvData[6]);
		}

		if (self.flipY) {
			SWAP(uvData[1], uvData[3]);
			SWAP(uvData[5], uvData[7]);
		}

		isUVDataInvalid = NO;
	}

	if (isColorDataInvalid) {

		colorData[0] = self.color.red;
		colorData[1] = self.color.green;
		colorData[2] = self.color.blue;
		colorData[3] = self.color.alpha;

		colorData[4] = self.color.red;
		colorData[5] = self.color.green;
		colorData[6] = self.color.blue;
		colorData[7] = self.color.alpha;

		colorData[8] = self.color.red;
		colorData[9] = self.color.green;
		colorData[10] = self.color.blue;
		colorData[11] = self.color.alpha;

		colorData[12] = self.color.red;
		colorData[13] = self.color.green;
		colorData[14] = self.color.blue;
		colorData[15] = self.color.alpha;

		isColorDataInvalid = NO;
	}
}

- (void)draw
{
	glEnable(GL_TEXTURE_2D);
	glEnable(GL_BLEND);

	glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

	glBindTexture(GL_TEXTURE_2D, self.frame.texture.glTexture);

	glVertexPointer(3, GL_FLOAT, 0, vertexData);
	glColorPointer(4, GL_UNSIGNED_BYTE, 0, colorData);
	glTexCoordPointer(2, GL_FLOAT, 0, uvData);

	glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);

	glDisable(GL_BLEND);
	glDisable(GL_TEXTURE_2D);
}

#pragma mark -
#pragma mark Private

- (void)invalidateVertexData
{
	isVertexDataInvalid = YES;
}

- (void)invalidateUVData
{
	isUVDataInvalid = YES;
}

- (void)invalidateColorData
{
	isColorDataInvalid = YES;
}

@end