//
//  DownloadsItemView.m
//  dentist
//
//  Created by cstLBY on 2018/9/19.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "DownloadsItemView.h"
#import "Common.h"
#import "Article.h"

@implementation DownloadsItemView{
    UILabel *titleLabel;
    UILabel *contentLabel;
    UIImageView *imageView;
    UIButton *statusButton;
    UILabel *statusLabel;
}

- (instancetype)init {
    self = [super init];
    
    NSInteger edge = 16;
    imageView = self.addImageView;
    [[[[imageView.layoutMaker leftParent:edge]topParent:25] sizeEq:110 h:110] install];
    
    _markButton = [self addButton];
    [_markButton setImage:[UIImage imageNamed:@"dot3"] forState:UIControlStateNormal];
    [[[[_markButton.layoutMaker rightParent:-edge] topParent:25] sizeEq:20 h:20] install];
    
    statusButton = [self addButton];
    [statusButton setImage:[UIImage imageNamed:@"select"] forState:UIControlStateNormal];
    [[[[statusButton.layoutMaker rightParent:-edge] bottomOf:imageView offset:0] sizeEq:20 h:20] install];
    
    titleLabel = [self addLabel];
    titleLabel.font = [Fonts regular:15];
    [titleLabel textColorMain];
    titleLabel.numberOfLines = 0;
    [[[[[titleLabel.layoutMaker toRightOf:imageView offset:15] topOf:imageView offset:5] toLeftOf:_markButton offset:-20] heightEq:20] install];
    
    statusLabel = [self addLabel];
    statusLabel.font = [Fonts regular:12];
    statusLabel.textColor=rgb255(155, 155, 155);
    statusLabel.numberOfLines = 0;
    [[[[[statusLabel.layoutMaker toRightOf:imageView offset:15] toLeftOf:_markButton offset:-20] bottomOf:imageView offset:0] heightEq:20] install];
    
    contentLabel = [self addLabel];
    contentLabel.font = [Fonts regular:15];
    [contentLabel textColorMain];
    contentLabel.numberOfLines = 0;
    
    [[[[[contentLabel.layoutMaker toRightOf:imageView offset:15] below:titleLabel offset:5] toLeftOf:_markButton offset:-20] above:statusLabel offset:-5] install];
    
    return self;
}

- (void)bind:(Article *)item {
    statusLabel.text=@"Download complete";
    titleLabel.text = item.title;
    contentLabel.text = item.content;
    [imageView loadUrl:item.resImage placeholderImage:@"art-img"];
    [imageView scaleFillAspect];
    imageView.clipsToBounds=YES;
}

@end
