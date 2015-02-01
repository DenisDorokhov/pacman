//
//  PMFoodEntity
//  pacman
//
//  Created by Denis Dorokhov on 11/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PMObjectBatchEntity.h"
#import "PMFood.h"

/**
* Food renderer.
*/
@interface PMFoodEntity : PMObjectBatchEntity

/**
* Builds food entity with some models.
*/
+ (instancetype)entityWithFood:(NSArray *)aFood;

/**
* Initializes food entity with some models.
*/
- (instancetype)initWithFood:(NSArray *)aFood;

@end