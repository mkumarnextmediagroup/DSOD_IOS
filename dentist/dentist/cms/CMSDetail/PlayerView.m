//
//  PlayerView.m
//  dentist
//
//  Created by 孙兴国 on 2018/9/19.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "PlayerView.h"
#import "Common.h"
#import "Article.h"

@implementation PlayerView
{
    UILabel *typeLabel;
    UILabel *dateLabel;
    UIImageView *imageView;
    UIButton *greeBtn;
    UIButton *moreButton;
    UIButton *markButton;
    UIImageView *headerImg;
    UILabel *titleLabel;
    UILabel *nameLabel;
    UILabel *addressLabel;
    UILabel *contentLabel;
    UIView *view;
}

- (instancetype)init {
    self = [super init];
    
    NSInteger edge = 16;
    
    UIView *topView = [UIView new];
    topView.backgroundColor = rgb255(250, 251, 253);
    [self addSubview:topView];
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
    
    imageView = self.addImageView;
    [imageView scaleFillAspect];
    [[[[[imageView.layoutMaker leftParent:0] rightParent:0] below:topView offset:0] heightEq:250] install];

    greeBtn = [self addButton];
    [greeBtn.titleLabel setFont:[Fonts regular:12]];
    greeBtn.titleLabel.textColor = [UIColor whiteColor];
    greeBtn.backgroundColor = rgb255(111, 201, 211);
    [[[[[greeBtn.layoutMaker leftParent:0] rightParent:0] below:imageView offset:0] heightEq:62] install];
    
    moreButton = [self addButton];
    [moreButton setImage:[UIImage imageNamed:@"dot3.png"] forState:UIControlStateNormal];
    [[[[moreButton.layoutMaker rightParent:-edge] below:greeBtn offset:edge] sizeEq:20 h:20] install];
    
    markButton = [self addButton];
    [markButton setImage:[UIImage imageNamed:@"book9"] forState:UIControlStateNormal];
    [[[[markButton.layoutMaker toLeftOf:moreButton offset:-8] below:greeBtn offset:edge] sizeEq:20 h:20] install];
    
    titleLabel = [self addLabel];
    titleLabel.font = [Fonts semiBold:20];
    [titleLabel textColorMain];
    titleLabel.numberOfLines = 0;
    [[[[titleLabel.layoutMaker leftParent:edge] rightParent:-64] below:greeBtn offset:10] install];
    
    UILabel *lineLabel = [self lineLabel];
    [[[[[lineLabel.layoutMaker leftParent:edge] rightParent:0] below:titleLabel offset:15] heightEq:1] install];
    
    view = [UIView new];
    [self addSubview:view];
    [[[[[view.layoutMaker leftParent:0] rightParent:0] below:lineLabel offset:0] heightEq:58] install];
    headerImg = [UIImageView new];
    [view addSubview:headerImg];
    [[[[headerImg.layoutMaker sizeEq:32 h:32] leftParent:edge] centerYParent:0] install];

    headerImg.layer.cornerRadius = 16;
    headerImg.layer.masksToBounds = YES;
    
    nameLabel = [view addLabel];
    nameLabel.font = [Fonts semiBold:12];
    [nameLabel textColorMain];
    [[[[[nameLabel.layoutMaker topParent:edge/2 + 2] toRightOf:headerImg offset:8] rightParent:-edge] heightEq:16] install];
    
    addressLabel = [view addLabel];
    [addressLabel textAlignLeft];
    addressLabel.font = [Fonts regular:12];
    [addressLabel textColorAlternate];
    [[[[[addressLabel.layoutMaker topParent:edge/2 + 18] toRightOf:headerImg offset:8] rightParent:-edge] heightEq:16] install];
    
    UILabel *lineLabel2 = [view lineLabel];
    [[[[[lineLabel2.layoutMaker leftParent:edge] rightParent:0] topParent:57] heightEq:1] install];
    
    contentLabel = [self addLabel];
    contentLabel.font = [Fonts regular:15];
    [contentLabel textColorMain];
    contentLabel.numberOfLines = 0;
    [[[[[contentLabel.layoutMaker leftParent:EDGE] rightParent:-EDGE] heightEq:30] below:view offset:5] install];
    
    UIImageView *imgCon = [UIImageView new];
    imgCon.backgroundColor = [UIColor redColor];
    [self addSubview:imgCon];
    [[[[[imgCon.layoutMaker sizeEq:SCREENWIDTH h:298] leftParent:0] rightParent:0] below:contentLabel offset:5] install];

    return self;
}

-(void)bind:(Article *)bindInfo {
    typeLabel.text = [bindInfo.type uppercaseString];
    dateLabel.text = bindInfo.publishDate;
    [imageView loadUrl:bindInfo.resImage placeholderImage:@"art-img"];
    [headerImg loadUrl:@"http://app800.cn/i/p.png" placeholderImage:@"user_img"];
    titleLabel.text = bindInfo.title;
    [greeBtn setTitle:bindInfo.gskString forState:UIControlStateNormal];
    nameLabel.text = bindInfo.authName;
    addressLabel.text = bindInfo.authAdd;
    contentLabel.text = bindInfo.content;
    
}

- (void)resetLayout {
    CGSize size = [contentLabel sizeThatFits:CGSizeMake(290, 1000)];
    [[contentLabel.layoutUpdate heightEq:size.height] install];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
