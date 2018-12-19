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
#import "BookmarkModel.h"
#import "Proto.h"

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
    [[[[markButton.layoutMaker rightParent:-5] topParent:5] sizeEq:48 h:48] install];
    
    
    titleLabel = [self addLabel];
    titleLabel.font = [Fonts semiBold:14];
    titleLabel.textColor=Colors.textMain;
    [[[[[titleLabel.layoutMaker toRightOf:imageView offset:15] topOf:imageView offset:10] toLeftOf:markButton offset:10] heightEq:18] install];

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
    if ([[item.categoryName uppercaseString] isEqualToString:@"VIDEOS"]) {
        [thumbImageView setImage:[UIImage imageNamed:@"Video"]];
    }else if([[item.categoryName uppercaseString] isEqualToString:@"PODCASTS"]) {
        [thumbImageView setImage:[UIImage imageNamed:@"Podcast"]];
    }else if([[item.categoryName uppercaseString] isEqualToString:@"INTERVIEWS"]) {
        [thumbImageView setImage:[UIImage imageNamed:@"Interview"]];
    }else if([[item.categoryName uppercaseString] isEqualToString:@"TECH GUIDES"]) {
        [thumbImageView setImage:[UIImage imageNamed:@"TechGuide"]];
    }else if([[item.categoryName uppercaseString] isEqualToString:@"ANIMATIONS"]) {
        [thumbImageView setImage:[UIImage imageNamed:@"Animation"]];
    }else if([[item.categoryName uppercaseString] isEqualToString:@"TIP SHEETS"]) {
        [thumbImageView setImage:[UIImage imageNamed:@"TipSheet"]];
    }else{
        [thumbImageView setImage:[UIImage imageNamed:@"Article"]];
    }
}

-(void)bindCMS:(BookmarkModel *)item
{
    _bookmarkmodel=item;
    titleLabel.text = (![NSString isBlankString:_bookmarkmodel.categoryName]?_bookmarkmodel.categoryName:@"");
    contentLabel.text = (![NSString isBlankString:_bookmarkmodel.title]?_bookmarkmodel.title:@"");//[item.title stringByAppendingString:@"\n\n\n\n "];
    NSString *urlstr;
    if ([NSString isBlankString:_bookmarkmodel.coverthumbnailUrl]) {
        urlstr=_bookmarkmodel.url;
    }else{
        urlstr=_bookmarkmodel.coverthumbnailUrl;
    }
    [imageView loadUrl:urlstr placeholderImage:@"art-img"];
    [imageView scaleFillAspect];
    imageView.clipsToBounds=YES;
    if ([[_bookmarkmodel.contentTypeName uppercaseString] isEqualToString:@"VIDEOS"]) {
        [thumbImageView setImage:[UIImage imageNamed:@"Video"]];
    }else if([[_bookmarkmodel.contentTypeName uppercaseString] isEqualToString:@"PODCASTS"]) {
        [thumbImageView setImage:[UIImage imageNamed:@"Podcast"]];
    }else if([[_bookmarkmodel.contentTypeName uppercaseString] isEqualToString:@"INTERVIEWS"]) {
        [thumbImageView setImage:[UIImage imageNamed:@"Interview"]];
    }else if([[_bookmarkmodel.contentTypeName uppercaseString] isEqualToString:@"TECH GUIDES"]) {
        [thumbImageView setImage:[UIImage imageNamed:@"TechGuide"]];
    }else if([[_bookmarkmodel.contentTypeName uppercaseString] isEqualToString:@"ANIMATIONS"]) {
        [thumbImageView setImage:[UIImage imageNamed:@"Animation"]];
    }else if([[_bookmarkmodel.contentTypeName uppercaseString] isEqualToString:@"TIP SHEETS"]) {
        [thumbImageView setImage:[UIImage imageNamed:@"TipSheet"]];
    }else{
        [thumbImageView setImage:[UIImage imageNamed:@"Article"]];
    }
}
-(void)markAction:(UIButton *)sender
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(BookMarkActionModel:)]){
        [self.delegate BookMarkActionModel:_bookmarkmodel];
    }
    
    
}

@end
