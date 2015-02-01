//
//  DDFixedSizeMatrix
//
//  Created by Denis Dorokhov on 10/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDFixedCountArray.h"

/**
* Matrix with fixed size.
*/
@interface DDFixedSizeMatrix : NSObject

/**
* Number of columns.
*/
@property (nonatomic, readonly) NSUInteger columns;

/**
* Number of rows.
*/
@property (nonatomic, readonly) NSUInteger rows;

/**
* Builds a matrix.
*/
+ (instancetype)matrixWithColumns:(NSUInteger)aColumns rows:(NSUInteger)aRows;

/**
* Default init method is unavailable.
*/
- (instancetype)init __unavailable;

/**
* Initializes a matrix.
*/
- (instancetype)initWithColumns:(NSUInteger)aColumns rows:(NSUInteger)aRows;

/**
* Returns object at location. If object does not exist on this location, nil will be returned.
*/
- (id)objectAtColumn:(NSUInteger)aColumn row:(NSUInteger)aRow;

/**
* Replaces object at location. Accepts nil value.
*/
- (void)replaceObject:(id)aObject atColumn:(NSUInteger)aColumn row:(NSUInteger)aRow;

@end