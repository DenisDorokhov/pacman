//
//  PMMovingObject
//  pacman
//
//  Created by Denis Dorokhov on 10/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import "PMMovingObject.h"
#import "TDUtil.h"

@implementation PMMovingObject

- (instancetype)init
{
	self = [super init];

	if (self != nil) {
		self.velocity = CGPointZero;
	}

	return self;
}

#pragma mark -
#pragma mark Public

- (PMMovementDirection)direction
{
	return PMMovementDirectionFromVelocity(self.velocity);
}

- (void)setVelocity:(float)aVelocity inDirection:(PMMovementDirection)aDirection
{
	self.velocity = CGPointMultiply(PMMovementDirectionToNormalizedVector(aDirection), aVelocity);
}

- (PMMapLocation)currentMapLocation
{
	PMMapLocation location;

	switch (self.direction) {

		case PMMovementDirection_Left:
		case PMMovementDirection_Up:
			location = PMMapLocationMake((int)ceilf(self.position.x), (int)ceilf(self.position.y));
			break;

		default:
			location = PMMapLocationMake((int)floorf(self.position.x), (int)floorf(self.position.y));
			break;
	}

	return location;
}

- (PMMapLocation)nextMapLocation
{
	if (CGPointIsZero(self.velocity)) {
		[self currentMapLocation];
	}

	CGPoint normalizedVelocity = CGPointNormalize(self.velocity);
	CGPoint nextPosition = CGPointAdd(self.position, normalizedVelocity);

	PMMapLocation location;

	switch (self.direction) {

		case PMMovementDirection_Left:
		case PMMovementDirection_Up:
			location = PMMapLocationMake((int)ceilf(nextPosition.x), (int)ceilf(nextPosition.y));
			break;

		default:
			location = PMMapLocationMake((int)floorf(nextPosition.x), (int)floorf(nextPosition.y));
			break;
	}

	return location;
}

- (PMMapLocation)mapLocationInDirection:(PMMovementDirection)aDirection
{
	CGPoint currentLocationPoint = PMMapLocationToPoint([self currentMapLocation]);

	return PMMapLocationFromPoint(CGPointAdd(currentLocationPoint, PMMovementDirectionToNormalizedVector(aDirection)));
}

@end