//
//  PMMapLocation
//  pacman
//
//  Created by Denis Dorokhov on 09/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

/**
* Map location.
*/
typedef struct
{
	NSInteger x;
	NSInteger y;
} PMMapLocation;

/**
* Creates a map location.
*/
static inline PMMapLocation PMMapLocationMake(NSInteger aX, NSInteger aY)
{
	PMMapLocation location;

	location.x = aX;
	location.y = aY;

	return location;
}

/**
* Creates a map location from CGPoint.
*/
static inline PMMapLocation PMMapLocationFromPoint(CGPoint aPoint)
{
	return PMMapLocationMake((NSInteger) aPoint.x, (NSInteger) aPoint.y);
}

/**
* Creates CGPoint from a map location.
*/
static inline CGPoint PMMapLocationToPoint(PMMapLocation aLocation)
{
	return CGPointMake(aLocation.x, aLocation.y);
}

/**
* Check map locations equality.
*/
static inline BOOL PMMapLocationEqualToLocation(PMMapLocation aLocation1, PMMapLocation aLocation2)
{
	return (aLocation1.x == aLocation2.x && aLocation1.y == aLocation2.y);
}

/**
* Returns map location up to particular one.
*/
static inline PMMapLocation PMMapLocationUp(PMMapLocation aLocation)
{
	return PMMapLocationMake(aLocation.x, aLocation.y + 1);
}

/**
* Returns map location down to particular one.
*/
static inline PMMapLocation PMMapLocationDown(PMMapLocation aLocation)
{
	return PMMapLocationMake(aLocation.x, aLocation.y - 1);
}

/**
* Returns map location right to particular one.
*/
static inline PMMapLocation PMMapLocationRight(PMMapLocation aLocation)
{
	return PMMapLocationMake(aLocation.x + 1, aLocation.y);
}

/**
* Returns map location left to particular one.
*/
static inline PMMapLocation PMMapLocationLeft(PMMapLocation aLocation)
{
	return PMMapLocationMake(aLocation.x - 1, aLocation.y);
}
