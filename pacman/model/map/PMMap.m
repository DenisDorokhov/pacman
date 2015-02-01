//
//  PMMap
//  pacman
//
//  Created by Denis Dorokhov on 10/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import "PMMap.h"

@interface PMMap ()
{
@private

	DDFixedSizeMatrix *matrix;
}

- (void)validateLocation:(PMMapLocation)aLocation;

@end

@implementation PMMap

+ (instancetype)mapWithWidth:(NSUInteger)aWidth height:(NSUInteger)aHeight
{
	return [[self alloc] initWithWidth:aWidth height:aHeight];
}

- (instancetype)initWithWidth:(NSUInteger)aWidth height:(NSUInteger)aHeight
{
	self = [super init];

	if (self != nil) {

		_width = aWidth;
		_height = aHeight;

		matrix = [[DDFixedSizeMatrix alloc] initWithColumns:aWidth rows:aHeight];
	}

	return self;
}

#pragma mark -
#pragma mark Public

- (PMMapCell *)cellAt:(PMMapLocation)aLocation
{
	[self validateLocation:aLocation];

	return [matrix objectAtColumn:(NSUInteger)aLocation.x row:(NSUInteger)aLocation.y];
}

- (void)putCell:(PMMapCell *)aCell
{
	[self validateLocation:aCell.location];

	[matrix replaceObject:aCell atColumn:(NSUInteger)aCell.location.x row:(NSUInteger)aCell.location.y];
}

- (NSArray *)cellsOfType:(PMMapCellType)aType
{
	NSMutableArray *cellsOfType = [NSMutableArray array];

	for (NSUInteger i = 0; i < matrix.columns; i++) {
		for (NSUInteger j = 0; j < matrix.rows; j++) {

			PMMapCell *cell = [matrix objectAtColumn:i row:j];

			if (cell.type == aType) {
				[cellsOfType addObject:cell];
			}
		}
	}

	return cellsOfType;
}

- (BOOL)doesContainLocation:(PMMapLocation)aLocation
{
	return (aLocation.x >= 0 && aLocation.x < self.width && aLocation.y >= 0 && aLocation.y < self.height);
}

#pragma mark -
#pragma mark Private

- (void)validateLocation:(PMMapLocation)aLocation
{
	if (![self doesContainLocation:aLocation]) {
		[NSException raise:NSStringFromClass([self class]) format:@"location [%ld, %ld] invalid", (long) aLocation.x, (long) aLocation.y];
	}
}

@end