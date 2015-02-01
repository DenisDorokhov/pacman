//
//  TDSpriteFrameLoaderCached
//  pacman
//
//  Created by Denis Dorokhov on 09/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import "TDSpriteFrameLoaderCached.h"

@interface TDSpriteFrameLoaderCached ()
{
@private

	NSMutableDictionary *cacheSingle;
	NSMutableDictionary *cacheConfig;
}

- (void) clearCacheUnused:(NSMutableDictionary *)aCache;

@end

@implementation TDSpriteFrameLoaderCached

+ (instancetype)frameLoaderWithTarget:(id <TDSpriteFrameLoader>)aTarget
{
	return [[self alloc] initWithTarget:aTarget];
}

- (instancetype)initWithTarget:(id <TDSpriteFrameLoader>)aTarget
{
	self = [self init];

	if (self != nil) {

		self.target = aTarget;

		cacheSingle = [[NSMutableDictionary alloc] init];
		cacheConfig = [[NSMutableDictionary alloc] init];
	}

	return self;
}

#pragma mark -
#pragma mark <TDSpriteFrameLoader>

- (TDSpriteFrame *)load:(NSString *)aFilePath
{
	TDSpriteFrame *result = cacheSingle[aFilePath];

	if (result == nil) {
		result = [self.target load:aFilePath];
	}

	return result;
}

- (NSDictionary *)loadBatch:(NSString *)aFilePath
{
	NSDictionary *result = cacheConfig[aFilePath];

	if (result == nil) {
		result = [self.target loadBatch:aFilePath];
	}

	return result;
}

#pragma mark -
#pragma mark Public

- (void)clearAll
{
	[cacheSingle removeAllObjects];
	[cacheConfig removeAllObjects];
}

- (void)clearUnused
{
	[self clearCacheUnused:cacheSingle];
	[self clearCacheUnused:cacheConfig];
}

#pragma mark -
#pragma mark Private

- (void)clearCacheUnused:(NSMutableDictionary *)aCache
{
	NSArray *cacheKeys = [aCache allKeys];

	for (NSString *key in cacheKeys) {

		TDTexture *texture = aCache[key];

		if (CFGetRetainCount((__bridge CFTypeRef) texture) == 1) {
			[aCache removeObjectForKey:key];
		}
	}
}

@end