//
//  PMMapLoaderImpl
//  pacman
//
//  Created by Denis Dorokhov on 10/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PMMapLoader.h"

/**
* Simple map loader. Uses text file named "map.dat" which is parsed line by line.
* Each line is game a map row. Each line symbol is a map cell. The following symbols are currently supported:
*
* <SPACE> - empty cell
* <O> - obstacle
* <P> - player
* <E> - enemy
* <F> - food
*/
@interface PMMapLoaderImpl : NSObject <PMMapLoader>

/**
* Builds a map loader.
*/
+ (instancetype)mapLoader;

@end