//
//  PMViewController
//  pacman
//
//  Created by Denis Dorokhov on 09/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import "PMViewController.h"

@implementation PMViewController

#pragma mark -
#pragma mark Override

- (BOOL)prefersStatusBarHidden {
	return YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)aInterfaceOrientation
{
	return UIInterfaceOrientationIsPortrait(aInterfaceOrientation);
}

- (BOOL)shouldAutorotate
{
	return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
	return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskPortraitUpsideDown;
}

@end