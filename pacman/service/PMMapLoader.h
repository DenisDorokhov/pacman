//
//  PMMapLoader
//  pacman
//
//  Created by Denis Dorokhov on 10/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import "PMMap.h"

/**
* Abstract map loader.
*/
@protocol PMMapLoader <NSObject>

/**
* Loads map model.
*/
- (PMMap *)loadMap;

@end