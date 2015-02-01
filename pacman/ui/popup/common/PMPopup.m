//
//  PMPopup
//  pacman
//
//  Created by Denis Dorokhov on 12/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import "PMPopup.h"

@implementation PMPopup

+ (instancetype)popup
{
	return [[self alloc] init];
}

- (instancetype)init
{
	self = [super init];

	if (self != nil) {

		_isShown = NO;
		_isAnimating = NO;

		[self setup];
	}

	return self;
}

#pragma mark -
#pragma mark Protected

- (void) setup
{}

- (void) finishShowing
{
	if ([self.delegate respondsToSelector:@selector(popupDidShow:animated:)]) {
		[self.delegate popupDidShow:self animated:self.isAnimating];
	}

	_isAnimating = NO;
}

- (void) finishHiding
{
	if ([self.delegate respondsToSelector:@selector(popupDidHide:animated:)]) {
		[self.delegate popupDidHide:self animated:self.isAnimating];
	}

	_isAnimating = NO;
}

- (void) show:(BOOL)aAnimated
{
	[NSException raise:NSStringFromClass([self class]) format:@"show: must be overridden"];
}

- (void) hide:(BOOL)aAnimated
{
	[NSException raise:NSStringFromClass([self class]) format:@"hide: must be overridden"];
}

#pragma mark -
#pragma mark Public

- (void) setIsShown:(BOOL)aIsShown animated:(BOOL)aAnimated
{
	if (aIsShown != _isShown) {

		_isShown = aIsShown;

		if (_isShown) {

			if ([self.delegate respondsToSelector:@selector(popupWillShow:animated:)]) {
				[self.delegate popupWillShow:self animated:aAnimated];
			}

			_isAnimating = aAnimated;

			[self show:aAnimated];

		} else {

			if ([self.delegate respondsToSelector:@selector(popupWillHide:animated:)]) {
				[self.delegate popupWillHide:self animated:aAnimated];
			}

			_isAnimating = aAnimated;

			[self hide:aAnimated];
		}
	}
}

@end