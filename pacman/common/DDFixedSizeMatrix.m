//
//  DDFixedSizeMatrix
//
//  Created by Denis Dorokhov on 10/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import "DDFixedSizeMatrix.h"


@interface DDFixedSizeMatrix ()
{
@private

	DDFixedCountArray *array;
}

- (void) validateColumn:(NSUInteger)aColumn row:(NSUInteger)aRow;

- (NSUInteger) indexForColumn:(NSUInteger)aColumn row:(NSUInteger)aRow;

@end


@implementation DDFixedSizeMatrix

+ (instancetype)matrixWithColumns:(NSUInteger)aColumns rows:(NSUInteger)aRows
{
	return [[self alloc] initWithColumns:aColumns rows:aRows];
}

- (instancetype)initWithColumns:(NSUInteger)aColumns rows:(NSUInteger)aRows
{
	self = [super init];

	if (self != nil) {

		_columns = aColumns;
		_rows = aRows;

		array = [[DDFixedCountArray alloc] initWithCount:(self.columns * self.rows)];
	}

	return self;
}

#pragma mark -
#pragma mark Public

- (id)objectAtColumn:(NSUInteger)aColumn row:(NSUInteger)aRow
{
	[self validateColumn:aColumn row:aRow];

	return [array objectAtIndex:[self indexForColumn:aColumn row:aRow]];
}

- (void)replaceObject:(id)aObject atColumn:(NSUInteger)aColumn row:(NSUInteger)aRow
{
	[self validateColumn:aColumn row:aRow];

	[array replaceObjectAtIndex:[self indexForColumn:aColumn row:aRow] withObject:aObject];
}

#pragma mark -
#pragma mark Private

- (void)validateColumn:(NSUInteger)aColumn row:(NSUInteger)aRow
{
	if (aColumn >= self.columns || aRow >= self.rows) {
		[NSException raise:NSStringFromClass([self class]) format:@"range error [%lu, %lu]", (unsigned long) aColumn, (unsigned long) aRow];
	}
}

- (NSUInteger)indexForColumn:(NSUInteger)aColumn row:(NSUInteger)aRow
{
	return (aRow * self.columns + aColumn);
}

@end