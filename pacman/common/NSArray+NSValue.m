//
// Created by Denis Dorokhov on 13/02/14.
// Copyright (c) 2014 COMYAN Internet & Intranet Solutions GmbH. All rights reserved.
//

#import "NSArray+NSValue.h"

@implementation NSArray (NSValue)

- (NSArray *)nonretainedObjects
{
	NSMutableArray *result = [NSMutableArray array];

	for (NSValue *value in self) {
		[result addObject:[value nonretainedObjectValue]];
	}

	return result;
}

@end