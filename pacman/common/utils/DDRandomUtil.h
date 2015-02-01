//
//  DDRandomUtil
//
//  Created by Denis Dorokhov on 15/02/2011.
//

#import <Foundation/Foundation.h>

/** @file */

/**
* Random data utilities.
*/
@interface DDRandomUtil : NSObject

/**
* Generate random integer in specified range.
*/
+ (int)randomIntFrom:(int)aFrom to:(int)aTo;
/**
* Generate random float in specified range.
*/
+ (float)randomFloatFrom:(float)aFrom to:(float)aTo;
/**
* Generate random boolean.
*/
+ (BOOL)randomBool;
/**
* Generate random decision with specified probability in range 0..100.
*/
+ (BOOL)boolWithProbability:(uint)aProbability;

/**
* Return random array element.
*/
+ (id)randomArrayElement:(NSArray *)aArray;
/**
* Shuffle array.
*/
+ (NSMutableArray *) shuffleArray:(NSArray *)aArray;

/**
* Generate random UUID.
*/
+ (NSString *)uuid;

@end