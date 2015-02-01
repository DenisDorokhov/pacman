//
//  PMPlayer
//  pacman
//
//  Created by Denis Dorokhov on 10/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import "PMPlayer.h"
#import "TDUtil.h"

@implementation PMPlayer

- (instancetype)init
{
	self = [super init];

	if (self != nil) {
		self.targetVelocity = CGPointZero;
	}

	return self;
}

#pragma mark -
#pragma mark Public

- (PMMovementDirection)targetDirection
{
	return PMMovementDirectionFromVelocity(self.targetVelocity);
}

- (void)setTargetVelocity:(float)aVelocity inDirection:(PMMovementDirection)aDirection
{
	self.targetVelocity = CGPointMultiply(PMMovementDirectionToNormalizedVector(aDirection), aVelocity);
}

@end