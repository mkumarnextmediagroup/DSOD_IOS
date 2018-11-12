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
        _scrollView.contentSize=CGSizeMake(0, 10000);
        _backgroundImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _scrollView.frame.size.width, 1000*_scrollView.frame.size.width/747)];
        [_scrollView addSubview:_backgroundImageView];
        [_scrollView setContentOffset:CGPointMake(0, 0)];
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
