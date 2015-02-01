//
//  Created by Denis Dorokhov on 14/11/2013.
//  Copyright (c) 2013 Denis Dorokhov. All rights reserved.
//

#import "DDSkinLoaderPlist.h"

@interface DDSkinLoaderPlist ()
{

}

@end

@implementation DDSkinLoaderPlist

+ (instancetype)skinLoader
{
	return [[self alloc] init];
}

#pragma mark -
#pragma mark <DDSkinLoader>

- (NSDictionary *)loadFile:(NSString *)aFilePath
{
	return [NSDictionary dictionaryWithContentsOfFile:aFilePath];
}

- (NSDictionary *)loadData:(NSData *)aData
{
	NSPropertyListFormat format = NSPropertyListBinaryFormat_v1_0;

	return [NSPropertyListSerialization propertyListFromData:aData mutabilityOption:NSPropertyListImmutable
													  format:&format errorDescription:nil];
}

@end