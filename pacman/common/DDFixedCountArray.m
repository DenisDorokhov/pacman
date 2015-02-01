//
//  DDFixedCountArray
//
//  Created by Denis Dorokhov on 10/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import "DDFixedCountArray.h"

@interface DDFixedCountArray ()
{
@private

	NSMutableArray *array;
}

@end

@implementation DDFixedCountArray

+ (instancetype)arrayWithCount:(NSUInteger)aCount
{
	return [[self alloc] initWithCount:aCount];
}

- (instancetype)initWithCount:(NSUInteger)aCount
{
	self = [super init];

	if (self != nil) {

		_count = aCount;

		array = [[NSMutableArray alloc] init];

		for (NSUInteger i = 0; i < self.count; i++) {
			[array addObject:[NSNull null]];
		}
	}

	return self;
}

#pragma mark -
#pragma mark Public

- (id)objectAtIndex:(NSUInteger)aIndex
{
	id object = array[aIndex];

	return object != [NSNull null] ? object : nil;
}

- (void)replaceObjectAtIndex:(NSUInteger)aIndex withObject:(id)aObject
{
	id object = (aObject != nil ? aObject : [NSNull null]);

	array[aIndex] = object;
}

@end