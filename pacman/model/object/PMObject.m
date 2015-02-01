//
//  PMObject
//  pacman
//
//  Created by Denis Dorokhov on 10/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import "PMObject.h"

@implementation PMObject

+ (instancetype)objectWithPosition:(CGPoint)aPosition
{
	return [[self alloc] initWithPosition:aPosition];
}

- (instancetype)initWithPosition:(CGPoint)aPosition
{
	self = [self init];

	if (self != nil) {
		self.position = aPosition;
	}

	return self;
}

#pragma mark -
#pragma mark Public

- (PMMapLocation)currentMapLocation
{
	return PMMapLocationMake((NSInteger) self.position.x, (NSInteger) self.position.y);
}

@end