//
//  PlayerView.h
//  dentist
//
//  Created by 孙兴国 on 2018/9/19.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"
#import "DetailModel.h"

@interface PlayerView : UIView

@property (nonatomic,strong)SBPlayer *sbPlayer;
@property (nonatomic,strong)UIView *topView;
@property (nonatomic,strong)UIButton *gskBtn;
@property (nonatomic,strong)UIButton *bgBtn;
@property (nonatomic,strong)UIButton *greeBtn;
@property (nonatomic,strong)UIButton *moreButton;
@property (nonatomic,strong)UIButton *markButton;


-(void)bind:(DetailModel *)bindInfo ;
- (void)resetLayout;

@end
