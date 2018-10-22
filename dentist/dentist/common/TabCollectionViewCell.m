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

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        _backgroundImageView=[self addImageView];
        [[[[[_backgroundImageView.layoutMaker leftParent:0] rightParent:0] topParent:0] bottomParent:0] install];
        [_backgroundImageView setImage:[UIImage imageNamed:@"seg-sel"]];
        _backgroundImageView.contentMode=UIViewContentModeScaleAspectFill;
        _backgroundImageView.clipsToBounds=YES;
        
        _titleLabel=[self addLabel];
        _titleLabel.font=[Fonts semiBold:12];
        _titleLabel.textColor=Colors.textMain;
        _titleLabel.textAlignment=NSTextAlignmentCenter;
        [[[[[_titleLabel.layoutMaker leftParent:0] rightParent:0] topParent:0] bottomParent:0] install];
        
        UILabel *line=[self addLabel];
        line.backgroundColor=rgba255(221, 221, 221, 100);
        [[[[[line.layoutMaker rightParent:-1] topParent:0] bottomParent:0] widthEq:1] install];
    }
    return self;
}

@end
