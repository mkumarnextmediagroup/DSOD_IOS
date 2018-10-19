//
//  TabCollectionViewCell.m
//  dentist
//
//  Created by fengzhenrong on 2018/10/19.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "TabCollectionViewCell.h"
#import "Common.h"

@implementation TabCollectionViewCell
-(instancetype)init
{
    self =[super init];
    if (self) {
        _backgroundImageView=[self addImageView];
        [[[[[_backgroundImageView.layoutMaker leftParent:0] rightParent:0] topParent:0] bottomParent:0] install];
        [_backgroundImageView setImage:[UIImage imageNamed:@"seg-bg"]];
        
        _titleLabel=[self addLabel];
        _titleLabel.font=[Fonts semiBold:12];
        _titleLabel.textColor=Colors.textMain;
        _titleLabel.textAlignment=NSTextAlignmentCenter;
        [[[[[_titleLabel.layoutMaker leftParent:0] rightParent:0] topParent:0] bottomParent:0] install];
        
    }
    
    return self;
}

@end
