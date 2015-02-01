//
//  TDGLView+Protected
//  pacman
//
//  Created by Denis Dorokhov on 09/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import "TDGLView.h"
#import "TDGLView+Protected.h"
#import "DDDeviceUtil.h"
#import <OpenGLES/ES1/glext.h>

@implementation TDGLView

+ (instancetype)viewWithFrame:(CGRect)aFrame
{
	return [[self alloc] initWithFrame:aFrame];
}

- (instancetype)initWithFrame:(CGRect)aFrame
{
	self = [super initWithFrame:aFrame];

	if (self != nil) {

		self.contentScaleFactor = [DDDeviceUtil screenScale];

		CAEAGLLayer *eaglLayer = (CAEAGLLayer *)super.layer;

		eaglLayer.opaque = YES;

		_context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1];

		if (_context == nil) {
			[NSException raise:NSStringFromClass([self class]) format:@"could not create EAGLContext"];
		}
		if (![EAGLContext setCurrentContext:_context]) {
			[NSException raise:NSStringFromClass([self class]) format:@"could not set EAGLContext"];
		}

		[self setupRenderBuffer];

		[_context renderbufferStorage:GL_RENDERBUFFER_OES fromDrawable:eaglLayer];

		[self setupFrameBuffer];
	}

	return self;
}

- (void) dealloc
{
	if ([EAGLContext currentContext] == _context) {
		[EAGLContext setCurrentContext:nil];
	}
}

#pragma mark -
#pragma mark Public

- (void) render
{
	[_context presentRenderbuffer:GL_RENDERBUFFER_OES];
}

#pragma mark -
#pragma mark Override

+ (Class)layerClass
{
	return [CAEAGLLayer class];
}

- (void)touchesBegan:(NSSet *)aTouches withEvent:(UIEvent *)aEvent
{
	if ([self.touchHandler respondsToSelector:@selector(touchesBegan:withEvent:)]) {
		[self.touchHandler touchesBegan:aTouches withEvent:aEvent];
	}
}

- (void)touchesMoved:(NSSet *)aTouches withEvent:(UIEvent *)aEvent
{
	if ([self.touchHandler respondsToSelector:@selector(touchesMoved:withEvent:)]) {
		[self.touchHandler touchesMoved:aTouches withEvent:aEvent];
	}
}

- (void)touchesEnded:(NSSet *)aTouches withEvent:(UIEvent *)aEvent
{
	if ([self.touchHandler respondsToSelector:@selector(touchesEnded:withEvent:)]) {
		[self.touchHandler touchesEnded:aTouches withEvent:aEvent];
	}
}

- (void)touchesCancelled:(NSSet *)aTouches withEvent:(UIEvent *)aEvent
{
	if ([self.touchHandler respondsToSelector:@selector(touchesCancelled:withEvent:)]) {
		[self.touchHandler touchesCancelled:aTouches withEvent:aEvent];
	}
}

#pragma mark -
#pragma mark Protected

- (void)setupRenderBuffer
{
	glGenRenderbuffersOES(1, &_renderBuffer);
	glBindRenderbufferOES(GL_RENDERBUFFER_OES, _renderBuffer);
}

- (void)setupFrameBuffer
{
	glGenFramebuffersOES(1, &_frameBuffer);
	glBindFramebufferOES(GL_FRAMEBUFFER_OES, _frameBuffer);
	glFramebufferRenderbufferOES(GL_FRAMEBUFFER_OES, GL_COLOR_ATTACHMENT0_OES, GL_RENDERBUFFER_OES, _renderBuffer);
}

@end