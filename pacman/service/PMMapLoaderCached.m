//
//  PMMapLoaderCached
//  pacman
//
//  Created by Denis Dorokhov on 11/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import "PMMapLoaderCached.h"

@interface PMMapLoaderCached ()
{
@private

	PMMap *cachedMap;
}

@end

@implementation PMMapLoaderCached

+ (instancetype)mapLoaderWithTarget:(id <PMMapLoader>)aTarget
{
	return [[self alloc] initWithTarget:aTarget];
}

- (instancetype)initWithTarget:(id <PMMapLoader>)aTarget
{
	self = [self init];

	if (self != nil) {
		self.target = aTarget;
	}

	return self;
}

#pragma mark -
#pragma mark <PMMapLoader>

- (PMMap *)loadMap
{
	PMMap *map = cachedMap;

	if (map == nil) {
		map = cachedMap = [self.target loadMap];
	}

	return map;
}

@end