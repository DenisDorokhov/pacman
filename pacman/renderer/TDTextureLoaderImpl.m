//
//  TDTextureLoaderImpl
//  pacman
//
//  Created by Denis Dorokhov on 09/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import "TDTextureLoaderImpl.h"
#import "DDLogging.h"

@implementation TDTextureLoaderImpl

+ (instancetype)textureLoader
{
	return [[self alloc] init];
}

#pragma mark -
#pragma mark <TDTextureLoader>

- (TDTexture *)load:(NSString *)aFilePath
{
	TDTexture *texture = nil;

	UIImage *image = [[UIImage alloc] initWithContentsOfFile:aFilePath];

	texture = [TDTexture textureWithImage:image];

	if (texture == nil) {
		ddlog(@"could not load texture %@", aFilePath);
	}

	return texture;
}

@end