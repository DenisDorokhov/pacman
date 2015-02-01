//
//  TDApplication
//  pacman
//
//  Created by Denis Dorokhov on 09/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import "TDApplication.h"
#import "DDDeviceUtil.h"
#import "TDEntity+Protected.h"
#import "DDLogging.h"
#import "NSArray+NSValue.h"
#import <OpenGLES/ES1/gl.h>

@interface TDApplication ()
{
@private

	CADisplayLink *displayLink;

	NSMutableArray *touchHandlers;

	double lastTimestamp;

	tdColorFloat surfaceColorFloat;
}

@end

@implementation TDApplication

- (instancetype)init
{
	self = [super init];

	if (self != nil) {

		self.surfaceColor = tdColorByteMake(0x00, 0x00, 0x00, 0xFF);

		self.isPaused = NO;

		displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(handleDisplayLinkStep:)];

		touchHandlers = [[NSMutableArray alloc] init];
	}

	return self;
}

- (void)dealloc
{
	_view.touchHandler = nil;
}

#pragma mark -
#pragma mark Public

- (void)setView:(TDGLView *)aView
{
	_view.touchHandler = nil;

	_view = aView;
	_view.touchHandler = self;

	[self setupSurface];
	[self setupProjection];

	if (_view != nil) {
		[self addToRunLoop];
	} else {
		[self removeFromRunLoop];
	}
}

- (void)setSurfaceColor:(tdColorByte)aSurfaceColor
{
	_surfaceColor = aSurfaceColor;

	surfaceColorFloat = tdColorByteToFloat(_surfaceColor);
}

- (void)setCurrentScene:(TDEntity *)aCurrentScene
{
	[_currentScene passivate];

	_currentScene = aCurrentScene;

	[_currentScene activate];

	[self renderScene];
}

- (void)setIsPaused:(BOOL)aIsPaused
{
	_isPaused = aIsPaused;

	if (_isPaused) {
		ddlog(@"did stop updating");
	} else {

		ddlog(@"did start updating");

		lastTimestamp = CACurrentMediaTime();
	}
}

- (void)addTouchHandler:(id <TDTouchHandler>)aTouchHandler
{
	[touchHandlers addObject:[NSValue valueWithNonretainedObject:aTouchHandler]];
}

- (void)removeTouchHandler:(id <TDTouchHandler>)aTouchHandler
{
	[touchHandlers removeObject:[NSValue valueWithNonretainedObject:aTouchHandler]];
}

- (CGPoint)touchPosition:(UITouch *)aTouch
{
	CGPoint viewLocation = [aTouch locationInView:self.view];

	CGPoint localPosition = viewLocation;

	localPosition.y = self.view.frame.size.height - localPosition.y;

	return localPosition;
}

#pragma mark -
#pragma mark <DDGLViewDelegate>

- (void)touchesBegan:(NSSet *)aTouches withEvent:(UIEvent *)aEvent
{
	for (id <TDTouchHandler> touchHandler in [touchHandlers nonretainedObjects]) {
		if ([touchHandler respondsToSelector:@selector(touchesBegan:withEvent:)]) {
			[touchHandler touchesBegan:aTouches withEvent:aEvent];
		}
	}
}

- (void)touchesMoved:(NSSet *)aTouches withEvent:(UIEvent *)aEvent
{
	for (id <TDTouchHandler> touchHandler in [touchHandlers nonretainedObjects]) {
		if ([touchHandler respondsToSelector:@selector(touchesMoved:withEvent:)]) {
			[touchHandler touchesMoved:aTouches withEvent:aEvent];
		}
	}
}

- (void)touchesEnded:(NSSet *)aTouches withEvent:(UIEvent *)aEvent
{
	for (id <TDTouchHandler> touchHandler in [touchHandlers nonretainedObjects]) {
		if ([touchHandler respondsToSelector:@selector(touchesEnded:withEvent:)]) {
			[touchHandler touchesEnded:aTouches withEvent:aEvent];
		}
	}
}

- (void)touchesCancelled:(NSSet *)aTouches withEvent:(UIEvent *)aEvent
{
	for (id <TDTouchHandler> touchHandler in [touchHandlers nonretainedObjects]) {
		if ([touchHandler respondsToSelector:@selector(touchesCancelled:withEvent:)]) {
			[touchHandler touchesCancelled:aTouches withEvent:aEvent];
		}
	}
}

#pragma mark -
#pragma mark Protected

- (void)setupSurface
{
	float screenScale = [DDDeviceUtil screenScale];

	_surfaceSize.width = self.view.frame.size.width * screenScale;
	_surfaceSize.height = self.view.frame.size.height * screenScale;
}

- (void)setupProjection
{
	glViewport(0, 0, (GLsizei)self.surfaceSize.width, (GLsizei)self.surfaceSize.height);

	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	glOrthof(0, self.surfaceSize.width, 0, self.surfaceSize.height, -1, 1);

	glMatrixMode(GL_MODELVIEW);
	glLoadIdentity();
}

- (void)addToRunLoop
{
	[displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)removeFromRunLoop
{
	[displayLink removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)handleDisplayLinkStep:(CADisplayLink *)aDisplayLink
{
	[self updateScene:aDisplayLink.timestamp];
	[self renderScene];
}

- (void)updateScene:(double)aTimestamp
{
	if (self.isPaused) {
		return;
	}

	float frameTime = (float)MAX(0, aTimestamp - lastTimestamp);

	lastTimestamp = aTimestamp;

	[self.delegate application:self willUpdate:frameTime];

	[self.currentScene update:frameTime];

	[self.delegate application:self didUpdate:frameTime];
}

- (void)renderScene
{
	[self.delegate applicationWillRender:self];

	glClearColor(surfaceColorFloat.red, surfaceColorFloat.green, surfaceColorFloat.blue, surfaceColorFloat.alpha);
	glClear(GL_COLOR_BUFFER_BIT);

	glEnableClientState(GL_VERTEX_ARRAY);
	glEnableClientState(GL_COLOR_ARRAY);
	glEnableClientState(GL_TEXTURE_COORD_ARRAY);

	[self.currentScene visit];

	glDisableClientState(GL_COLOR_ARRAY);
	glDisableClientState(GL_TEXTURE_COORD_ARRAY);
	glDisableClientState(GL_VERTEX_ARRAY);

	[self.view render];

	[self.delegate applicationDidRender:self];
}

@end