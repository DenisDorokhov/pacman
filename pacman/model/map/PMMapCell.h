//
//  PMMapCell
//  pacman
//
//  Created by Denis Dorokhov on 10/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PMObject.h"
#import "PMMapLocation.h"

/**
* Map cell type.
*/
typedef NS_ENUM(NSInteger, PMMapCellType)
{
	/**
	* Cell is vacant.
	*/
	PMMapCellType_Vacant,
	/**
	* Cell contains the player.
	*/
			PMMapCellType_Player,
	/**
	* Cell contains an enemy.
	*/
	PMMapCellType_Enemy,
	/**
	* Cell contains a food.
	*/
	PMMapCellType_Food,
	/**
	* Cell contains an obstacle.
	*/
	PMMapCellType_Obstacle,
};

/**
* Map cell.
*/
@interface PMMapCell : NSObject

/**
* Cell location.
*/
@property (nonatomic) PMMapLocation location;

/**
* Cell type.
*/
@property (nonatomic) PMMapCellType type;

/**
* Builds a cell.
*/
+ (instancetype)cell;

@end