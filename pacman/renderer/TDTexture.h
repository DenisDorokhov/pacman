//
//  TDTexture
//  pacman
//
//  Created by Denis Dorokhov on 09/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
* 2D texture. Support only RGBA format. Can be loaded from UIImage or plain data.
*/
@interface TDTexture : NSObject

/**
* Texture size.
*/
@property (nonatomic, readonly) CGSize size;

/**
* OpenGL texture pointer.
*/
@property (nonatomic, readonly) GLuint glTexture;

/**
* Builds a texture from binary data and size.
*/
+ (instancetype)textureWithData:(void *)aData size:(CGSize)aSize;

/**
* Builds a texture from UIImage instance.
*/
+ (instancetype)textureWithImage:(UIImage *)aImage;

/**
* Initializes a texture from binary data and size.
*/
- (instancetype)initWithData:(void *)aData size:(CGSize)aSize;

/**
* Initializes a texture from UIImage instance.
*/
- (instancetype)initWithImage:(UIImage *)aImage;

/**
* Loads binary data into a texture.
*/
- (void)loadData:(void *)aData size:(CGSize)aSize;

/**
* Loads UIImage into a texture.
*/
- (void)loadImage:(UIImage *)aImage;

@end