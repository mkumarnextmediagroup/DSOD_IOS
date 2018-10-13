//
//  GSKItemView.m
//  dentist
//
//  Created by 孙兴国 on 2018/10/13.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "GSKItemView.h"
#import "Common.h"
#import "Article.h"

@implementation GSKItemView{
    UILabel *typeLabel;
    UILabel *dateLabel;
    UILabel *titleLabel;
    UILabel *contentLabel;
    UIImageView *imageView;
    UIButton *markButton;
}

- (instancetype)init {
    self = [super init];
    
    NSInteger edge = 16;
    
    UIView *topView = self.addView;
    topView.backgroundColor = rgb255(250, 251, 253);
    [[[[[topView.layoutMaker topParent:0] leftParent:0] rightParent:0] heightEq:40] install];
    typeLabel = [topView addLabel];
    typeLabel.font = [Fonts semiBold:12];
    [typeLabel textColorMain];
    [[[[[typeLabel.layoutMaker centerYParent:0] leftParent:edge] heightEq:24] rightParent:-90] install];
    
    dateLabel = [topView addLabel];
    [dateLabel textAlignRight];
    dateLabel.font = [Fonts regular:12];
    [dateLabel textColorAlternate];
    [[[[[dateLabel.layoutMaker centerYParent:0] rightParent:-edge] heightEq:24] widthEq:74] install];
    
    UILabel *lineLabel = self.lineLabel;
    lineLabel.backgroundColor = Colors.cellLineColor;
    [[[lineLabel.layoutMaker sizeEq:SCREENWIDTH h:1] topParent:39] install];
    
    UIView *contentView = self.addView;
    contentView.backgroundColor = rgb255(255, 255, 255);
    [[[contentView.layoutMaker below:topView offset:0] heightEq:105] install];
    
    imageView = [contentView addImageView];
    [imageView scaleFillAspect];
    [[[[[imageView.layoutMaker leftParent:edge] topParent:edge] below:topView offset:0] sizeEq:70 h:70] install];
    
    _moreButton = [contentView addButton];
    [_moreButton setImage:[UIImage imageNamed:@"dot3.png"] forState:UIControlStateNormal];
    [[[[_moreButton.layoutMaker rightParent:-edge] below:imageView offset:edge] sizeEq:20 h:20] install];
    
    markButton = [contentView addButton];
    [markButton setImage:[UIImage imageNamed:@"book9"] forState:UIControlStateNormal];
    [[[[markButton.layoutMaker toLeftOf:_moreButton offset:-8] below:imageView offset:edge] sizeEq:20 h:20] install];
    
    titleLabel = [contentView addLabel];
    titleLabel.font = [Fonts semiBold:20];
    [titleLabel textColorMain];
    titleLabel.numberOfLines = 0;
    //    [[[[[titleLabel.layoutMaker leftParent:edge] rightParent:-64] below:imageView offset:10] heightEq:24] install];
    [[[[[titleLabel.layoutMaker leftParent:edge] rightParent:-64] below:imageView offset:10] bottomParent:-103] install];
    
    contentLabel = [contentView addLabel];
    contentLabel.font = [Fonts regular:15];
    [contentLabel textColorMain];
    [[[[[contentLabel.layoutMaker leftParent:edge] rightParent:-edge] heightEq:80] bottomParent:-16] install];
    
    return self;
}

- (void)bind:(Article *)item {
    typeLabel.text = [item.type uppercaseString];
    dateLabel.text = item.publishDate;
    titleLabel.text = item.title;
    contentLabel.text = item.content;
    [imageView loadUrl:item.resImage placeholderImage:@"art-img"];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
