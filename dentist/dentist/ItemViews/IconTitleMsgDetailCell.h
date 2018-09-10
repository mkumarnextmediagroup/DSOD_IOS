//
// Created by entaoyang on 2018/9/8.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseItemView.h"


@interface IconTitleMsgDetailCell : BaseItemView

@property(readonly) UIImageView *imageView;
@property(readonly) UILabel *titleLabel;
@property(readonly) UILabel *msgLabel;
@property(readonly) UILabel *detailLabel;
@property(readonly) UILabel *emptyLabel;

@property BOOL hasArrow;

-(void) showEmpty:(NSString*) text;
-(void) hideEmpty;

@end