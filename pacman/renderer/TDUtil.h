//
//  TDUtil
//  pacman
//
//  Created by Denis Dorokhov on 09/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import "DDLogging.h"
#import <OpenGLES/ES1/gl.h>

/**
* Byte color representation.
*/
typedef struct
{
	unsigned char red;
	unsigned char green;
	unsigned char blue;
	unsigned char alpha;
} tdColorByte;

/**
* Float color representation.
*/
typedef struct
{
	float red;
	float green;
	float blue;
	float alpha;
} tdColorFloat;

/**
* Builds byte color.
*/
static inline tdColorByte tdColorByteMake(unsigned char aRed, unsigned char aGreen, unsigned char aBlue, unsigned char aAlpha)
{
	tdColorByte color;

	color.red = aRed;
	color.green = aGreen;
	color.blue = aBlue;
	color.alpha = aAlpha;

	return color;
}

/**
* Builds float color.
*/
static inline tdColorFloat tdColorFloatMake(float aRed, float aGreen, float aBlue, float aAlpha)
{
	tdColorFloat color;

	color.red = aRed;
	color.green = aGreen;
	color.blue = aBlue;
	color.alpha = aAlpha;

	return color;
}

/**
* Converts byte color to float color.
*/
static inline tdColorFloat tdColorByteToFloat(tdColorByte aColorByte)
{
	tdColorFloat colorFloat;

	colorFloat.red = aColorByte.red / (float)0xFF;
	colorFloat.green = aColorByte.green / (float)0xFF;
	colorFloat.blue = aColorByte.blue / (float)0xFF;
	colorFloat.alpha = aColorByte.alpha / (float)0xFF;

	return colorFloat;
}

/**
* Converts float color to byte color.
*/
static inline tdColorByte tdColorFloatToByte(tdColorFloat aColorFloat)
{
	tdColorByte colorByte;

	colorByte.red = (unsigned char)(aColorFloat.red * 0xFF);
	colorByte.green = (unsigned char)(aColorFloat.green * 0xFF);
	colorByte.blue = (unsigned char)(aColorFloat.blue * 0xFF);
	colorByte.alpha = (unsigned char)(aColorFloat.alpha * 0xFF);

	return colorByte;
}

/**
* Checks is CGPoint is zero.
*/
#define CGPointIsZero(point) CGPointEqualToPoint(point, CGPointZero)

/**
* Creates CGPoint from CGSize.
*/
static inline CGPoint CGPointFromCGSize(CGSize aSize)
{
	return CGPointMake(aSize.width, aSize.height);
}

/**
* Creates CGSize from CGPoint.
*/
static inline CGSize CGSizeFromCGPoint(CGPoint aPoint)
{
	return CGSizeMake(aPoint.x, aPoint.y);
}

/**
* Adds one vector to another.
*/
static inline CGPoint CGPointAdd(CGPoint aPoint1, CGPoint aPoint2)
{
	return CGPointMake(aPoint1.x + aPoint2.x, aPoint1.y + aPoint2.y);
}

/**
* Subtracts one vector from another.
*/
static inline CGPoint CGPointSubtract(CGPoint aPoint1, CGPoint aPoint2)
{
	return CGPointMake(aPoint1.x - aPoint2.x, aPoint1.y - aPoint2.y);
}

/**
* Multiplies vector by a scalar.
*/
static inline CGPoint CGPointMultiply(CGPoint aPoint, float aValue)
{
	return CGPointMake(aPoint.x * aValue, aPoint.y * aValue);
}

/**
* Multiplies corresponding coordinates of two CGPoints.
*/
static inline CGPoint CGPointScale(CGPoint aPoint1, CGPoint aPoint2)
{
	return CGPointMake(aPoint1.x * aPoint2.x, aPoint1.y * aPoint2.y);
}

/**
* Calculates vector dot product.
*/
static inline float CGPointDot(CGPoint aPoint1, CGPoint aPoint2)
{
	return aPoint1.x * aPoint2.x + aPoint1.y * aPoint2.y;
}

/**
* Calculates squared vector length.
*/
static inline float CGPointLengthSquared(CGPoint aPoint)
{
	return CGPointDot(aPoint, aPoint);
}

/**
* Calculates vector length.
*/
static inline float CGPointLength(CGPoint aPoint)
{
	return sqrtf(CGPointLengthSquared(aPoint));
}

/**
* Normalizes vector.
*/
static inline CGPoint CGPointNormalize(CGPoint aPoint)
{
	return CGPointMultiply(aPoint, 1.0f / CGPointLength(aPoint));
}

/**
* Calculates distance between two CGPoints.
*/
static inline float CGPointDistance(CGPoint aPoint1, CGPoint aPoint2)
{
	return CGPointLength(CGPointSubtract(aPoint1, aPoint2));
}
