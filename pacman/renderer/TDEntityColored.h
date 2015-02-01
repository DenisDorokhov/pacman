//
//  TDEntityColored
//  pacman
//
//  Created by Denis Dorokhov on 12/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import "TDUtil.h"

/**
* Colored entity.
*/
@protocol TDEntityColored <NSObject>

/**
* Entity color.
*/
@property (nonatomic) tdColorByte color;

@end