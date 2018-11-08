//
//  PicDetailView.h
//  dentist
//
//  Created by Jacksun on 2018/10/17.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"
#import "DetailModel.h"

@class Article;

NS_ASSUME_NONNULL_BEGIN

@interface PicDetailView : UIView

@property (nonatomic,strong)UIView *topView;
@property (nonatomic,strong)UIButton *bgBtn;
@property (nonatomic,strong)UIButton *moreButton;
@property (nonatomic,strong)UIButton *markButton;
@property (nonatomic,weak) UIViewController *vc;

-(void)bind:(DetailModel *)bindInfo ;
- (void)resetLayout;

@end

NS_ASSUME_NONNULL_END
