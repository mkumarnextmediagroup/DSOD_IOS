//
// Created by yet on 2018/8/19.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (myextend)

@property(readonly) NSString *urlEncoded;

@property(readonly) NSString *trimed;
@property(readonly) unichar lastChar;

- (NSString *)add:(NSString *)s;

- (BOOL)match:(NSString *)reg;

- (BOOL)matchEmail;

- (BOOL)matchPassword;

- (NSData *)dataUTF8;

- (BOOL)containsChar:(unichar)ch;


@end

//遇到nil就回终止
extern NSString *addStr(NSString *value, ...);
