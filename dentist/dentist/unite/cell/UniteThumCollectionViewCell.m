//
//  UniteThumCollectionViewCell.m
//  dentist
//
//  Created by feng zhenrong on 2018/11/6.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "UniteThumCollectionViewCell.h"
#import "Common.h"
@interface UniteThumCollectionViewCell()<UIScrollViewDelegate
>
@end
@implementation UniteThumCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        [self layoutIfNeeded];
        _scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _scrollView.delegate=self;
        [self addSubview:_scrollView];
        _backgroundImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _scrollView.frame.size.width, 1000*_scrollView.frame.size.width/747)];
        [_scrollView addSubview:_backgroundImageView];
//        [[[[[_scrollView.layoutMaker leftParent:0] rightParent:0] topParent:0] bottomParent:0] install];
//        [_scrollView layoutIfNeeded];
//        _backgroundImageView=[_scrollView addImageView];
//
//        [[[[[_backgroundImageView.layoutMaker leftParent:0] rightParent:0] topParent:0] bottomParent:0] install];
//        _backgroundImageView=[self addImageView];
//        [[[[[_backgroundImageView.layoutMaker leftParent:0] rightParent:0] topParent:0] bottomParent:0] install];
//        [[[[[_backgroundImageView.layoutMaker leftOf:_scrollView] rightOf:_scrollView] topOf:_scrollView offset:0] bottomOf:_scrollView offset:0] install];
        [_backgroundImageView setImage:[UIImage imageNamed:@"unitedetail1"]];
    }
    return self;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(UniteThumCollectionViewCellScroview:)]){
        [self.delegate UniteThumCollectionViewCellScroview:scrollView.contentOffset.y];
    }
}

@end
