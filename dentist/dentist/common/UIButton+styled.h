//
// Created by yet on 2018/8/17.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (styled)

@property(class, nonatomic, readonly) CGFloat heightPrefer;
@property(class, nonatomic, readonly) CGFloat widthLarge;

- (UIButton *)stylePrimary;
- (UIButton *)styleSecondary;
- (UIButton *)styleWhite;

-(UIButton* )title:(NSString*) text ;

@end