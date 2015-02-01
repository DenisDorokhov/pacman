//
//  PMAppDelegate.m
//  pacman
//
//  Created by Denis Dorokhov on 09/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import "PMAppDelegate.h"
#import "PMServiceLocator.h"
#import "PMGameScene.h"
#import "TDEntity+Protected.h"
#import "TDApplication+Protected.h"

@interface PMAppDelegate ()
{
@private

	PMViewController *viewController;

	TDApplication *application;
}

@end

@implementation PMAppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)aApplication didFinishLaunchingWithOptions:(NSDictionary *)aLaunchOptions
{
	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

	application = [PMServiceLocator application];
	application.view = [TDGLView viewWithFrame:self.window.frame];

	viewController = [[PMViewController alloc] init];
	viewController.view = application.view;

	[self.window setRootViewController:viewController];
	[self.window makeKeyAndVisible];

	application.currentScene = [PMGameScene entity];

	return YES;
}

- (void)applicationWillResignActive:(UIApplication *)aApplication
{
	application.isPaused = YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)aApplication
{
	application.isPaused = NO;
}

@end
