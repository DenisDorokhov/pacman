//
//  PMEntity
//  pacman
//
//  Created by Denis Dorokhov on 10/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import "PMEntity.h"
#import "PMServiceLocator.h"

@implementation PMEntity

- (instancetype)init
{
	self = [super init];

	if (self != nil) {
		skin = [PMServiceLocator skin];
		application = [PMServiceLocator application];
		frameLoader = [PMServiceLocator spriteFrameLoader];
		locationTransformer = [PMServiceLocator locationTransformer];
		eventDispatcher = [PMServiceLocator eventDispatcher];
	}

	return self;
}

@end