//
//  Created by Denis Dorokhov on 01/02/15.
//  Copyright (c) 2015 Denis Dorokhov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDSkin.h"

/**
* Skin that automatically scales number values. Follows decorator design pattern - needs DDSkin implementation.
*/
@interface DDSkinScaled : NSObject <DDSkin>

/**
* Skin to scale.
*/
@property (nonatomic, strong) id <DDSkin> target;

/**
* Skin scale. Default is 1.0.
*/
@property (nonatomic) float scale;

/**
* Builds skin that scales some DDSkin implementation.
*/
+ (instancetype)skinWithTarget:(id <DDSkin>)aTarget;

/**
* Initializes skin that scales some DDSkin implementation.
*/
- (instancetype)initWithTarget:(id <DDSkin>)aTarget;

@end