//
// Created by yet on 2018/8/19.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (myextend)

- (NSString *)trimed;

- (BOOL)match:(NSString *)reg;

- (BOOL)matchEmail;

- (BOOL)matchPassword;
@end
