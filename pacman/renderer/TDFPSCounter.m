//
//  TDFPSCounter
//  pacman
//
//  Created by Denis Dorokhov on 12/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import "TDFPSCounter.h"

@interface TDFPSCounter ()
{
@private

	NSUInteger fpsFramesCount;
	float fpsTime;
}

@end

@implementation TDFPSCounter

- (instancetype)init
{
	self = [super init];

	if (self != nil) {

		self.fpsUpdateInterval = 1;

		self.consoleOutput = NO;

		fpsTime = 0;
		fpsFramesCount = 0;
	}

	return self;
}

#pragma mark -
#pragma mark <TDApplicationDelegate>

- (void)application:(TDApplication *)aApplication willUpdate:(float)aTime
{
	fpsTime += aTime;
	fpsFramesCount++;

	if (fpsTime >= self.fpsUpdateInterval) {

		_fps = fpsFramesCount / fpsTime;

		fpsTime = 0;
		fpsFramesCount = 0;

		if (self.consoleOutput) {
			ddlog(@"fps: %f", self.fps);
		}
	}
}

- (void)application:(TDApplication *)aApplication didUpdate:(float)aTime
{}

- (void)applicationWillRender:(TDApplication *)aApplication
{}

- (void)applicationDidRender:(TDApplication *)aApplication
{}

@end