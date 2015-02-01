//
//  DDFixedCountArray
//
//  Created by Denis Dorokhov on 10/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
* Array with fixed number of elements
*/
@interface DDFixedCountArray : NSObject

/**
* Number of elements.
*/
@property (nonatomic, readonly) NSUInteger count;

/**
* Builds an array with fixed number of elements.
*/
+ (instancetype)arrayWithCount:(NSUInteger)aCount;

/**
* Default init method is unavailable.
*/
- (instancetype)init __unavailable;

/**
* Initializes an array with fixed number of elements.
*/
- (instancetype)initWithCount:(NSUInteger)aCount;

/**
* Returns object at index. If object does not exist on this index, nil will be returned.
*/
- (id)objectAtIndex:(NSUInteger)aIndex;

/**
* Replaces object at index. Accepts nil value.
*/
- (void)replaceObjectAtIndex:(NSUInteger)aIndex withObject:(id)aObject;

@end