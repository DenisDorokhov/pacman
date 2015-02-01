//
//  TDFilledRectangle
//  pacman
//
//  Created by Denis Dorokhov on 12/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import "TDFilledRectangle.h"
#import "TDEntity+Protected.h"
#import <OpenGLES/ES1/gl.h>

@interface TDFilledRectangle ()
{
@private

	BOOL isVertexDataInvalid;
	BOOL isColorDataInvalid;

	float vertexData[12];
	GLubyte colorData[16];
}

- (void) invalidateVertexData;
- (void) invalidateColorData;

@end

@implementation TDFilledRectangle

@synthesize color = _color;
@synthesize opacity = _opacity;

+ (instancetype)rectangleWithRectangle:(CGRect)aRectangle
{
	return [[self alloc] initWithRectangle:aRectangle];
}

+ (instancetype)rectangleWithSize:(CGSize)aSize
{
	return [[self alloc] initWithSize:aSize];
}

- (instancetype)initWithRectangle:(CGRect)aRectangle
{
	self = [self initWithSize:aRectangle.size];

	if (self != nil) {
		self.position = aRectangle.origin;
	}

	return self;
}

- (instancetype)initWithSize:(CGSize)aSize
{
	self = [self init];

	if (self != nil) {
		self.size = aSize;
	}

	return self;
}

- (instancetype)init
{
	self = [super init];

	if (self != nil) {
		self.color = tdColorByteMake(0xFF, 0xFF, 0xFF, 0xFF);
	}

	return self;
}

#pragma mark -
#pragma mark Public

- (void)setSize:(CGSize)aSize
{
	[super setSize:aSize];

	[self invalidateVertexData];
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
		vertexData[4] = self.size.height;
		vertexData[5] = 0;

		// bottom-right
		vertexData[6] = self.size.width;
		vertexData[7] = 0;
		vertexData[8] = 0;

		// top-right
		vertexData[9] = self.size.width;
		vertexData[10] = self.size.height;
		vertexData[11] = 0;

		isVertexDataInvalid = NO;
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
	glEnable(GL_BLEND);

	glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

	glVertexPointer(3, GL_FLOAT, 0, vertexData);
	glColorPointer(4, GL_UNSIGNED_BYTE, 0, colorData);

	glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);

	glDisable(GL_BLEND);
}

#pragma mark -
#pragma mark Private

- (void)invalidateVertexData
{
	isVertexDataInvalid = YES;
}

- (void)invalidateColorData
{
	isColorDataInvalid = YES;
}

@end