//
//  PMPopupColored
//  pacman
//
//  Created by Denis Dorokhov on 12/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import "PMPopupColored.h"
#import "PMPopup+Protected.h"
#import "PMPopupFading+Protected.h"

@implementation PMPopupColored

+ (instancetype)popupWithRectangleColor:(tdColorByte)aColor
{
	return [[self alloc] initWithRectangleColor:aColor];
}

- (instancetype)initWithRectangleColor:(tdColorByte)aColor
{
	self = [self init];

	if (self != nil) {
		self.rectangle.color = aColor;
	}

	return self;
}

#pragma mark -
#pragma mark Override

- (void)setup
{
	[super setup];

	_rectangle = [TDFilledRectangle rectangleWithSize:application.surfaceSize];
	_rectangle.color = application.surfaceColor;
	_rectangle.size = [skin size:@"screenSize"];
	_rectangle.anchor = CGPointZero;
	_rectangle.isVisible = NO;

	_colorProxy = [[TDEntityColorProxy alloc] init];
	_colorProxy.isVisible = NO;

	[self addChild:_rectangle];
	[self addChild:_colorProxy];
}

- (void)onShowingAnimationStarted
{
	[super onShowingAnimationStarted];

	self.rectangle.isVisible = YES;
	self.colorProxy.isVisible = YES;
}

- (void)onHidingAnimationFinished
{
	[super onHidingAnimationFinished];

	self.rectangle.isVisible = NO;
	self.colorProxy.isVisible = NO;
}

- (void)showWithoutAnimation
{
	self.rectangle.isVisible = YES;
	self.colorProxy.isVisible = YES;
}

- (void)hideWithoutAnimation
{
	self.rectangle.isVisible = NO;
	self.colorProxy.isVisible = YES;
}

- (void)setOpacity:(unsigned char)aOpacity
{
	self.rectangle.opacity = aOpacity;
	self.colorProxy.opacity = aOpacity;
}

@end