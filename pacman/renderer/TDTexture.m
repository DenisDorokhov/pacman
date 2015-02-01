//
//  TDTexture
//  pacman
//
//  Created by Denis Dorokhov on 09/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import "TDTexture.h"
#import <OpenGLES/ES1/gl.h>

@interface TDTexture ()

- (void)deleteTexture;

@end

@implementation TDTexture

+ (instancetype)textureWithData:(void *)aData size:(CGSize)aSize
{
	return [[self alloc] initWithData:aData size:aSize];
}

+ (instancetype)textureWithImage:(UIImage *)aImage
{
	return [[self alloc] initWithImage:aImage];
}

- (instancetype)init
{
	self = [super init];

	if (self != nil) {
		_glTexture = 0;
	}

	return self;
}

- (instancetype)initWithData:(void *)aData size:(CGSize)aSize
{
	self = [self init];

	if (self != nil) {
		[self loadData:aData size:aSize];
	}

	return self;
}

- (instancetype)initWithImage:(UIImage *)aImage
{
	self = [self init];

	if (self != nil) {
		[self loadImage:aImage];
	}

	return self;
}

- (void)dealloc
{
	[self deleteTexture];
}

#pragma mark -
#pragma mark Public

- (void)loadData:(void *)aData size:(CGSize)aSize
{
	[self deleteTexture];

	glGenTextures(1, &_glTexture);

	_size = aSize;

	glBindTexture(GL_TEXTURE_2D, _glTexture);

	glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, (GLsizei)self.size.width, (GLsizei)self.size.height, 0, GL_RGBA, GL_UNSIGNED_BYTE, aData);

	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);

	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
}

- (void)loadImage:(UIImage *)aImage
{
	CGImageRef cgImage = aImage.CGImage;

	CGContextRef cgContext;
	CGColorSpaceRef cgColorSpace;

	CGSize imageSize = CGSizeMake(CGImageGetWidth(cgImage), CGImageGetHeight(cgImage));

	void *data = malloc((size_t)(imageSize.width * imageSize.height * 4));

	cgColorSpace = CGColorSpaceCreateDeviceRGB();
	cgContext = CGBitmapContextCreate(data,
			(size_t)imageSize.width, (size_t)imageSize.height,
			8, 4 * (size_t)imageSize.width,
			cgColorSpace, (CGBitmapInfo)kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
	CGColorSpaceRelease(cgColorSpace);
	CGContextClearRect(cgContext, CGRectMake(0, 0, imageSize.width, imageSize.height));
	CGContextDrawImage(cgContext, CGRectMake(0, 0, imageSize.width, imageSize.height), cgImage);

	[self loadData:data size:imageSize];

	CGContextRelease(cgContext);
	free(data);
}

#pragma mark -
#pragma mark Private

- (void)deleteTexture
{
	if (_glTexture != 0) {
		glDeleteTextures(1, &_glTexture);
	}

	_glTexture = 0;
}

@end