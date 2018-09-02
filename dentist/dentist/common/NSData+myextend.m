//
// Created by entaoyang on 2018/8/29.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "NSData+myextend.h"
#import "Common.h"


@implementation NSData (myextend)

- (NSString *)stringUTF8 {
	return [[NSString alloc] initWithData:self encoding:NSUTF8StringEncoding];
}


@end


@implementation NSMutableData (myextend2)

- (void)appendUTF8:(NSString *)s {
	[self appendData:s.dataUTF8];
}

@end