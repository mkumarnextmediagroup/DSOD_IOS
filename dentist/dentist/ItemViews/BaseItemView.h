//
// Created by entaoyang on 2018/9/9.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Padding;


@interface BaseItemView : UIView

@property NSObject *argObj;
@property NSString *argStr;
@property NSInteger argN;
@property CGFloat argF;

- (void)resetLayout;

- (UIImageView *)addArrowView;
-(void)addItemSubView:(UIView *)subview titleName:(NSString *)titleName imageName:(NSString *)imageName;
@end
