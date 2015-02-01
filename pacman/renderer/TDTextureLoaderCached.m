//
//  TDTextureLoaderCached
//  pacman
//
//  Created by Denis Dorokhov on 09/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import "TDTextureLoaderCached.h"

@interface TDTextureLoaderCached ()
{
@private

	NSMutableDictionary *cache;
}

@end

@implementation TDTextureLoaderCached

+ (instancetype)textureLoaderWithTarget:(id <TDTextureLoader>)aTarget
{
	return [[self alloc] initWithTarget:aTarget];
}

- (instancetype)initWithTarget:(id <TDTextureLoader>)aTarget
{
	self = [self init];

	if (self != nil) {
		self.target = aTarget;
	}

	return self;
}

- (instancetype)init
{
	self = [super init];

	if (self != nil) {
		cache = [[NSMutableDictionary alloc] init];
	}

	return self;
}

#pragma mark -
#pragma mark Public

- (void)clearAll
{
	[cache removeAllObjects];
}

- (void)clearUnused
{
	NSArray *cacheKeys = [cache allKeys];

	for (NSString *key in cacheKeys) {

		TDTexture *texture = cache[key];

		if (CFGetRetainCount((__bridge CFTypeRef) texture) == 1) {
			[cache removeObjectForKey:key];
		}
	}
}

#pragma mark -
#pragma mark <TDTextureLoader>

- (TDTexture *)load:(NSString *)aFilePath
{
	TDTexture *texture = cache[aFilePath];

	if (texture == nil) {

		texture = [self.target load:aFilePath];

		if (texture != nil) {
			cache[aFilePath] = texture;
		}
	}

	return texture;
}

@end