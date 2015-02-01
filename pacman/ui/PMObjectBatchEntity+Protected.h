//
//  PMObjectBatchEntity(Protected)
//  pacman
//
//  Created by Denis Dorokhov on 13/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PMObjectBatchEntity.h"

/**
* Batch entity protected methods.
*/
@interface PMObjectBatchEntity (Protected)

/**
* Returns batch entity vertex size.
*/
- (size_t)objectVertexSize;

/**
* Returns batch entity UV size.
*/
- (size_t)objectUVSize;

/**
* Returns batch entity color size.
*/
- (size_t)objectColorSize;

/**
* Returns batch entity index size.
*/
- (size_t)objectIndexSize;

/**
* Frees data arrays.
*/
- (void)freeArrays;

/**
* Validates object at some index.
*/
- (void)validateObjectAtIndex:(NSUInteger)aIndex;

@end