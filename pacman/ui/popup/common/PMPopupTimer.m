//
//  PMPopupTimer
//  pacman
//
//  Created by Denis Dorokhov on 13/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import "PMPopupTimer.h"
#import "TDEntity+Protected.h"
#import "PMPopup+Protected.h"

@interface PMPopupTimer ()
{
@private

	float currentShowTime;
}

@end

@implementation PMPopupTimer

#pragma mark -
#pragma mark Override

- (void) setup
{
	[super setup];

	self.showTime = 1;
}

- (void) finishShowing
{
	[super finishShowing];

	currentShowTime = 0;
}

- (void) onUpdate:(float)aTime
{
	[super onUpdate:aTime];

	if (self.isShown && !self.isAnimating) {

		currentShowTime += aTime;

		if (currentShowTime >= self.showTime) {
			[self setIsShown:NO animated:YES];
		}
	}
}

@end