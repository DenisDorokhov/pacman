//
//  PMMap
//  pacman
//
//  Created by Denis Dorokhov on 10/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PMMapCell.h"
#import "PMMapLocation.h"
#import "DDFixedSizeMatrix.h"

/**
* Game map.
*
* Contains matrix of PMMapCell instances.
* Map is completely static - it's not changed during game play.
*/
@interface PMMap : NSObject

/**
* Map width.
*/
@property (nonatomic, readonly) NSUInteger width;

/**
* Map height.
*/
@property (nonatomic, readonly) NSUInteger height;

/**
* Builds a map.
*/
+ (instancetype)mapWithWidth:(NSUInteger)aWidth height:(NSUInteger)aHeight;

/**
* Default init method is unavailable.
*/
- (instancetype)init __unavailable;

/**
* Initializes a map.
*/
- (instancetype)initWithWidth:(NSUInteger)aWidth height:(NSUInteger)aHeight NS_DESIGNATED_INITIALIZER;

/**
* Returns cell at particular location.
*/
- (PMMapCell *)cellAt:(PMMapLocation)aLocation;

/**
* Puts a cell to the map.
*/
- (void)putCell:(PMMapCell *)aCell;

/**
* Returns array of cells of particular type.
*/
- (NSArray *)cellsOfType:(PMMapCellType)aType;

/**
* Returns true if location is valid for the map.
*/
- (BOOL)doesContainLocation:(PMMapLocation)aLocation;

@end