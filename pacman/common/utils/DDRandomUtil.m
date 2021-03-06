//
//  DDRandomUtil
//
//  Created by Denis Dorokhov on 15/02/2011.
//

#import "DDRandomUtil.h"

@implementation DDRandomUtil

+ (int) randomIntFrom:(int)aFrom to:(int)aTo
{
	return aFrom + arc4random() % (aTo - aFrom + 1);
}

+ (NSUInteger) randomUnsignedIntegerFrom:(NSUInteger)aFrom to:(NSUInteger)aTo
{
	return aFrom + arc4random() % (aTo - aFrom + 1);
}

+ (float) randomFloatFrom:(float)aFrom to:(float)aTo
{
	return ((aTo - aFrom) * ((float)rand() / (float)RAND_MAX)) + aFrom;
}

+ (BOOL) randomBool
{
	return [self randomIntFrom:0 to:99] > 49;
}

+ (id) randomArrayElement:(NSArray *)aArray
{
	if ([aArray count] == 0) {
		return nil;
	}

	return aArray[[self randomUnsignedIntegerFrom:0 to:([aArray count] - 1)]];
}

+ (BOOL) boolWithProbability:(uint)aProbability
{
	return [self randomIntFrom:1 to:100] <= MIN(aProbability, 100);
}

+ (NSMutableArray *) shuffleArray:(NSArray *)aArray
{
	NSMutableArray *array = [NSMutableArray arrayWithCapacity:[aArray count]];

	NSMutableArray *copy = [aArray mutableCopy];

	while ([copy count] > 0) {

		NSUInteger index = arc4random() % [copy count];

		[array addObject:copy[index]];

		[copy removeObjectAtIndex:index];
	}

	return array;
}

+ (NSString *)uuid
{
	CFUUIDRef uuidRef = CFUUIDCreate(NULL);
	CFStringRef uuidStringRef = CFUUIDCreateString(NULL, uuidRef);
	CFRelease(uuidRef);
	return (__bridge_transfer NSString *)uuidStringRef;
}

@end