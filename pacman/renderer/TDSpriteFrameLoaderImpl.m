//
//  TDSpriteFrameLoaderImpl
//  pacman
//
//  Created by Denis Dorokhov on 09/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import "TDSpriteFrameLoaderImpl.h"


@implementation TDSpriteFrameLoaderImpl

+ (instancetype)frameLoaderWithTextureLoader:(id <TDTextureLoader>)aTextureLoader
{
	return [[self alloc] initWithTextureLoader:aTextureLoader];
}

- (instancetype)initWithTextureLoader:(id <TDTextureLoader>)aTextureLoader
{
	self = [self init];

	if (self != nil) {
		self.textureLoader = aTextureLoader;
	}

	return self;
}

#pragma mark -
#pragma mark <TDSpriteFrameLoader>

- (TDSpriteFrame *) load:(NSString *)aFilePath
{
	TDTexture *texture = [self.textureLoader load:aFilePath];

	TDSpriteFrame *frame = nil;

	if (texture != nil) {

		frame = [TDSpriteFrame frame];

		frame.texture = texture;
		frame.position = CGPointMake(0, 0);
		frame.size = texture.size;
	}

	return frame;
}

- (NSDictionary *) loadBatch:(NSString *)aFilePath
{
	NSString *texturePath = [[aFilePath stringByDeletingPathExtension] stringByAppendingString:@".png"];

	TDTexture *texture = [self.textureLoader load:texturePath];

	NSMutableDictionary *result = [NSMutableDictionary dictionary];

	NSDictionary *plistFrames = [NSDictionary dictionaryWithContentsOfFile:aFilePath][@"frames"];

	for (NSString *name in plistFrames) {

		if (result[name] != nil) {
			[NSException raise:NSStringFromClass([self class]) format:@"duplicate key [%@] in config [%@]",name,aFilePath];
		}

		NSDictionary *plistItem = plistFrames[name];

		float x = [plistItem[@"x"] floatValue];
		float y = [plistItem[@"y"] floatValue];

		float width = [plistItem[@"width"] floatValue];
		float height = [plistItem[@"height"] floatValue];

		TDSpriteFrame *frame = [TDSpriteFrame frame];

		frame.name = name;
		frame.position = CGPointMake(x, y);
		frame.size = CGSizeMake(width, height);
		frame.texture = texture;

		result[name] = frame;
	}

	return result;
}

@end