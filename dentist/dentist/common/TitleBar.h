//
// Created by entaoyang@163.com on 2018/9/3.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TitleBar : UIView


- (void)setTitle:(NSString *)title;

- (void)leftTextAction:(NSString *)key title:(NSString *)title;

- (void)leftImageAction:(NSString *)key image:(NSString *)image;

- (void)rightTextAction:(NSString *)key title:(NSString *)title;

- (void)rightImageAction:(NSString *)key image:(NSString *)image;


- (void)removeAction:(NSString *)key;

- (void)commit;


@end