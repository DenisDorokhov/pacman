//
// Created by Denis Dorokhov on 13/02/14.
// Copyright (c) 2014 COMYAN Internet & Intranet Solutions GmbH. All rights reserved.
//

/**
* Utility for working with NSArray of NSValue objects.
*/
@interface NSArray (NSValue)

/**
* Returns NSArray of non-retained objects.
*/
- (NSArray *)nonretainedObjects;

@end