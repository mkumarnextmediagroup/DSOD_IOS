//
//  BookMarkItemView.m
//  dentist
//
//  Created by cstLBY on 2018/9/19.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "BookMarkItemView.h"
#import "Common.h"
#import "Article.h"

@implementation BookMarkItemView{
    UILabel *titleLabel;
    UILabel *contentLabel;
    UIImageView *imageView;
    UIButton *markButton;
    UIImageView *thumbImageView;
}

- (instancetype)init {
    self = [super init];
    
    NSInteger edge = 16;
    imageView = self.addImageView;
   [[[[[imageView.layoutMaker leftParent:edge]topParent:25] bottomParent:-edge] sizeEq:110 h:110] install];
    
    thumbImageView = [UIImageView new];
    [imageView addSubview:thumbImageView];
    [[[[thumbImageView.layoutMaker leftParent:10] bottomParent:-10] sizeEq:28 h:28] install];
    
    markButton = [self addButton];
    [markButton setImage:[UIImage imageNamed:@"book9-light"] forState:UIControlStateNormal];
    [markButton addTarget:self action:@selector(markAction:) forControlEvents:UIControlEventTouchUpInside];
    [[[[markButton.layoutMaker rightParent:-edge] topParent:20] sizeEq:20 h:20] install];
    
    titleLabel = [self addLabel];
    titleLabel.font = [Fonts semiBold:14];
    titleLabel.textColor=Colors.textMain;
    [[[[[titleLabel.layoutMaker toRightOf:imageView offset:15] topOf:imageView offset:10] toLeftOf:markButton offset:-10] heightEq:18] install];

    contentLabel = [self topShowLabel];
    contentLabel.font = [Fonts semiBold:15];
    contentLabel.textColor=Colors.textContent;
    contentLabel.numberOfLines = 3;
//    contentLabel.lineBreakMode=NSLineBreakByTruncatingTail;
    [[[[[contentLabel.layoutMaker toRightOf:imageView offset:15] below:titleLabel offset:5] rightParent:-edge] bottomOf:imageView offset:0] install];
    
    return self;
}

- (void)bind:(Article *)item {
    _model=item;
    titleLabel.text = item.type;
    contentLabel.text = item.title;//[item.title stringByAppendingString:@"\n\n\n\n "];
    [imageView loadUrl:item.resImage placeholderImage:@"art-img"];
    [imageView scaleFillAspect];
    imageView.clipsToBounds=YES;
    if ([item.categoryName isEqualToString:@"VIDEOS"]) {
        [thumbImageView setImage:[UIImage imageNamed:@"Video"]];
    }else if([item.categoryName isEqualToString:@"PODCASTS"]) {
        [thumbImageView setImage:[UIImage imageNamed:@"Podcast"]];
    }else if([item.categoryName isEqualToString:@"INTERVIEWS"]) {
        [thumbImageView setImage:[UIImage imageNamed:@"Interview"]];
    }else if([item.categoryName isEqualToString:@"TECH GUIDES"]) {
        [thumbImageView setImage:[UIImage imageNamed:@"TechGuide"]];
    }else if([item.categoryName isEqualToString:@"ANIMATIONS"]) {
        [thumbImageView setImage:[UIImage imageNamed:@"Animation"]];
    }else if([item.categoryName isEqualToString:@"TIP SHEETS"]) {
        [thumbImageView setImage:[UIImage imageNamed:@"TipSheet"]];
    }else{
        [thumbImageView setImage:[UIImage imageNamed:@"Article"]];
    }
}

-(void)markAction:(UIButton *)sender
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(BookMarkAction:)]){
        [self.delegate BookMarkAction:_model.id];
    }
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
