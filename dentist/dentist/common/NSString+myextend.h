//
// Created by yet on 2018/8/19.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (myextend)

@property(readonly) NSString *base64Encoded;
@property(readonly) NSString *base64Decoded;
@property(readonly) NSString *urlEncoded;
@property(readonly) NSString *textAddPhoneNor;

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
__attribute__((overloadable)) extern NSString *strBuild(NSString *value, NSString *v2);

__attribute__((overloadable)) extern NSString *strBuild(NSString *value, NSString *v2, NSString *v3);

__attribute__((overloadable)) extern NSString *strBuild(NSString *value, NSString *v2, NSString *v3, NSString *v4);

__attribute__((overloadable)) extern NSString *strBuild(NSString *value, NSString *v2, NSString *v3, NSString *v4, NSString *v5);

__attribute__((overloadable)) extern NSString *strBuild(NSString *value, NSString *v2, NSString *v3, NSString *v4, NSString *v5, NSString *v6);
__attribute__((overloadable)) extern NSString *strBuild(NSString *value, NSString *v2, NSString *v3, NSString *v4, NSString *v5, NSString *v6, NSString *v7);
__attribute__((overloadable)) extern NSString *strBuild(NSString *value, NSString *v2, NSString *v3, NSString *v4, NSString *v5, NSString *v6, NSString *v7, NSString *v8);
__attribute__((overloadable)) extern NSString *strBuild(NSString *value, NSString *v2, NSString *v3, NSString *v4, NSString *v5, NSString *v6, NSString *v7, NSString *v8, NSString *v9);
