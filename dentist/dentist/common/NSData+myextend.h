//
// Created by entaoyang on 2018/8/29.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSData (myextend)

@property NSString *stringUTF8;


@end

@interface NSMutableData (myextend2)

- (void)appendUTF8:(NSString *)s;


@end