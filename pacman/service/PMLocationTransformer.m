//
//  PMLocationTransformer
//  pacman
//
//  Created by Denis Dorokhov on 10/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import "PMLocationTransformer.h"
#import "PMServiceLocator.h"

@interface PMLocationTransformer ()
{
@private

	CGSize tileSize;
	CGSize tileHalfSize;
}

@end

@implementation PMLocationTransformer

- (instancetype)init
{
	self = [super init];

	if (self != nil) {

		tileSize = [[PMServiceLocator skin] size:@"tileSize"];

		tileHalfSize = tileSize;
		tileHalfSize.width /= 2;
		tileHalfSize.height /= 2;
	}

	return self;
}

#pragma mark -
#pragma mark Public

- (CGPoint)mapLocationToScreenPosition:(PMMapLocation)aLocation
{
	return [self objectPositionToScreenPosition:PMMapLocationToPoint(aLocation)];
}

- (CGPoint)objectPositionToScreenPosition:(CGPoint)aPosition
{
	return CGPointMake(aPosition.x * tileSize.width + tileHalfSize.width, -(aPosition.y * tileSize.height + tileHalfSize.height));
}

@end