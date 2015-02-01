//
//  PMMapCell
//  pacman
//
//  Created by Denis Dorokhov on 10/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import "PMMapCell.h"

@implementation PMMapCell

+ (instancetype)cell
{
	return [[self alloc] init];
}

- (instancetype)init
{
	self = [super init];

	if (self != nil) {
		self.type = PMMapCellType_Vacant;
	}

	return self;
}

@end