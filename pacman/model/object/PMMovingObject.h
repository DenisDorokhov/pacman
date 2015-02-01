//
//  PMMovingObject
//  pacman
//
//  Created by Denis Dorokhov on 10/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PMObject.h"

/**
* Movement direction.
*/
typedef NS_ENUM(NSInteger, PMMovementDirection)
{
	/**
	* "Up" direction.
	*/
	PMMovementDirection_Up,
	/**
	* "Right" direction.
	*/
	PMMovementDirection_Right,
	/**
	* "Down" direction.
	*/
	PMMovementDirection_Down,
	/**
	* "Left" direction.
	*/
	PMMovementDirection_Left,
	/**
	* No direction.
	*/
	PMMovementDirection_None
};

/**
* Returns an opposite direction to a particular one.
*/
static inline PMMovementDirection PMMovementDirectionOpposite(PMMovementDirection aDirection)
{
	PMMovementDirection opposite = PMMovementDirection_None;

	switch (aDirection) {

		case PMMovementDirection_Up:
			opposite = PMMovementDirection_Down;
			break;

		case PMMovementDirection_Right:
			opposite = PMMovementDirection_Left;
			break;

		case PMMovementDirection_Down:
			opposite = PMMovementDirection_Up;
			break;

		case PMMovementDirection_Left:
			opposite = PMMovementDirection_Right;
			break;

		default:
			break;
	}

	return opposite;
}

/**
* Returns direction of velocity vector.
*/
static inline PMMovementDirection PMMovementDirectionFromVelocity(CGPoint aVelocity)
{
	PMMovementDirection direction = PMMovementDirection_None;

	if (aVelocity.x == 0 && aVelocity.y > 0) {
		direction = PMMovementDirection_Down;
	} else if (aVelocity.x == 0 && aVelocity.y < 0) {
		direction = PMMovementDirection_Up;
	} else if (aVelocity.y == 0 && aVelocity.x > 0) {
		direction = PMMovementDirection_Right;
	} else if (aVelocity.y == 0 && aVelocity.x < 0) {
		direction = PMMovementDirection_Left;
	}

	return direction;
}

/**
* Converts movement direction to normalized vector.
*/
static inline CGPoint PMMovementDirectionToNormalizedVector(PMMovementDirection aDirection)
{
	CGPoint vector = CGPointZero;

	switch (aDirection) {

		case PMMovementDirection_Up:
			vector = CGPointMake(0, -1);
			break;

		case PMMovementDirection_Right:
			vector = CGPointMake(1, 0);
			break;

		case PMMovementDirection_Down:
			vector = CGPointMake(0, 1);
			break;

		case PMMovementDirection_Left:
			vector = CGPointMake(-1, 0);
			break;

		default:
			break;
	}

	return vector;
}

/**
* Returns string representation of movement direction.
*/
static inline NSString *PMMovementDirectionToString(PMMovementDirection aDirection)
{
	NSString *result = @"none";

	switch (aDirection) {

		case PMMovementDirection_Up:
			result = @"up";
			break;

		case PMMovementDirection_Right:
			result = @"right";
			break;

		case PMMovementDirection_Down:
			result = @"down";
			break;

		case PMMovementDirection_Left:
			result = @"left";
			break;

		default:
			break;
	}

	return result;
}

/**
* Abstract moving object model.
*/
@interface PMMovingObject : PMObject

/**
* Velocity vector.
*/
@property (nonatomic) CGPoint velocity;

/**
* Velocity vector direction.
*/
@property (nonatomic, readonly) PMMovementDirection direction;

/**
* Set velocity vector of particular direction.
*/
- (void)setVelocity:(float)aVelocity inDirection:(PMMovementDirection)aDirection;

/**
* Map location in the direction of velocity vector.
*/
- (PMMapLocation)nextMapLocation;

/**
* Returns map location in some direction relative to the object location.
*/
- (PMMapLocation)mapLocationInDirection:(PMMovementDirection)aDirection;

@end