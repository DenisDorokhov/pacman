//
//  TDEntityColorProxy
//  pacman
//
//  Created by Denis Dorokhov on 13/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TDEntity.h"
#import "TDEntityColored.h"
#import "TDEntityTransparent.h"

/**
* Entity that distributes color and opacity over its children.
*/
@interface TDEntityColorProxy : TDEntity <TDEntityColored, TDEntityTransparent>

@end