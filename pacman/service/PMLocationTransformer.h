//
//  PMLocationTransformer
//  pacman
//
//  Created by Denis Dorokhov on 10/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDSkin.h"
#import "PMMapLocation.h"
#import "PMMap.h"

/**
* Game world location transformer.
*/
@interface PMLocationTransformer : NSObject

/**
* Game map.
*/
@property (nonatomic, strong) PMMap *map;

/**
* Transforms map location to screen coordinates.
*/
- (CGPoint) mapLocationToScreenPosition:(PMMapLocation)aLocation;

/**
* Transforms game object position to screen coordinates.
*/
- (CGPoint) objectPositionToScreenPosition:(CGPoint)aPosition;

@end