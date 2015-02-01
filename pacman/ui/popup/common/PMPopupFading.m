//
//  PMPopupFading
//  pacman
//
//  Created by Denis Dorokhov on 12/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import "PMPopupFading.h"
#import "PMPopup+Protected.h"
#import "PMPopupFading+Protected.h"

@interface PMPopupFading ()
{
@private

	float animationTime;

	BOOL hasFinishedAnimation;
}

@end

@implementation PMPopupFading

#pragma mark -
#pragma mark Override

- (void)setup
{
	[super setup];

	self.fadingDuration = 0.5;
}

- (void)show:(BOOL)aAnimated
{
	animationTime = 0;

	if (aAnimated) {
		[self onShowingAnimationStarted];
	} else {
		[self showWithoutAnimation];
		[self finishShowing];
	}
}

- (void)hide:(BOOL)aAnimated
{
	animationTime = 0;

	if (aAnimated) {
		[self onHidingAnimationStarted];
	} else {
		[self hideWithoutAnimation];
		[self finishHiding];
	}
}

- (void)onUpdate:(float)aTime
{
	if (hasFinishedAnimation) {

		if (self.isShown) {
			[self onShowingAnimationFinished];
		} else {
			[self onHidingAnimationFinished];
		}

		animationTime = 0;

		hasFinishedAnimation = NO;
	}

	if (self.isAnimating) {

		animationTime += aTime;

		float opacity;

		if (self.isShown) {
			opacity = MIN(1, animationTime / self.fadingDuration);
		} else {
			opacity = 1 - MIN(1, animationTime / self.fadingDuration);
		}

		[self setOpacity:(unsigned char)(opacity * 0xFF)];

		if (animationTime >= self.fadingDuration) {
			hasFinishedAnimation = YES;
		}
	}
}

#pragma mark -
#pragma mark Protected

- (void)onShowingAnimationStarted
{
	[self setOpacity:0];
}

- (void)onShowingAnimationFinished
{
	[self finishShowing];
}

- (void)onHidingAnimationStarted
{
	[self setOpacity:0xFF];
}

- (void)onHidingAnimationFinished
{
	[self finishHiding];
}

- (void)setOpacity:(unsigned char)aOpacity
{
	[NSException raise:NSStringFromClass([self class]) format:@"setOpacity: must be overridden"];
}

- (void)showWithoutAnimation
{
	[NSException raise:NSStringFromClass([self class]) format:@"show: must be overridden"];
}

- (void)hideWithoutAnimation
{
	[NSException raise:NSStringFromClass([self class]) format:@"hide: must be overridden"];
}

@end