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
#import "DentistPickerView.h"
#import <CoreText/CoreText.h>
#import "CMSModel.h"
#import "Proto.h"

@implementation GSKItemView{
    UILabel *typeLabel;
    UILabel *dateLabel;
    UILabel *titleLabel;
    UIImageView *imageView;
    UIButton *markButton;
}

- (instancetype)init {
    self = [super init];
    
    NSInteger edge = 18;
    
    CGFloat topheight=40;
    if(IS_IPHONE_P_X){
        topheight=50;
        edge=24;
    }
    
    UIView *topView = self.addView;
    topView.backgroundColor = rgb255(250, 251, 253);
    [[[[[topView.layoutMaker topParent:0] leftParent:0] rightParent:0] heightEq:topheight] install];
    typeLabel = [topView addLabel];
    typeLabel.font = [Fonts semiBold:12];
    [typeLabel textColorMain];
    [[[[[typeLabel.layoutMaker centerYParent:0] leftParent:edge] heightEq:topheight] rightParent:-90] install];
    UIButton *typebutton=[topView addButton];
    [[[[[typebutton.layoutMaker centerYParent:0] leftParent:edge] heightEq:topheight] rightParent:-90] install];
    [typebutton addTarget:self action:@selector(showFilter) forControlEvents:UIControlEventTouchUpInside];
    
    dateLabel = [topView addLabel];
    [dateLabel textAlignRight];
    dateLabel.font = [Fonts regular:12];
    [dateLabel textColorAlternate];
    [[[[[dateLabel.layoutMaker centerYParent:0] rightParent:-edge] heightEq:topheight] widthEq:80] install];
    
//    UILabel *lineLabel = [topView lineLabel];//
//    lineLabel.backgroundColor = Colors.cellLineColor;
//    [[[lineLabel.layoutMaker sizeEq:SCREENWIDTH h:1] topParent:topheight-1] install];
    
    UIView *contentView = self.addView;
    contentView.backgroundColor = rgb255(255, 255, 255);
    [[[contentView.layoutMaker below:topView offset:0] heightEq:105] install];
    
    imageView = [contentView addImageView];
    [imageView scaleFillAspect];
    [[[[[imageView.layoutMaker leftParent:edge] topParent:edge] below:topView offset:edge] sizeEq:70 h:70] install];
    
    _moreButton = [contentView addButton];
    [_moreButton setImage:[UIImage imageNamed:@"dot3.png"] forState:UIControlStateNormal];
    [[[[[_moreButton.layoutMaker rightParent:-edge+5] below:topView offset:edge] sizeEq:20 h:20] leftParent:SCREENWIDTH-40] install];
     [_moreButton addTarget:self action:@selector(moreAction:) forControlEvents:UIControlEventTouchUpInside];
    
    markButton = [contentView addButton];
    [markButton setImage:[UIImage imageNamed:@"book9"] forState:UIControlStateNormal];
    [[[[markButton.layoutMaker toLeftOf:_moreButton offset:-8] below:topView offset:edge] sizeEq:20 h:20] install];
    [markButton addTarget:self action:@selector(markAction:) forControlEvents:UIControlEventTouchUpInside];

    titleLabel = [contentView addLabel];
    titleLabel.font = [Fonts regular:14];
    [titleLabel textColorMain];
    titleLabel.numberOfLines = 3;
    //    [[[[[titleLabel.layoutMaker leftParent:edge] rightParent:-64] below:imageView offset:10] heightEq:24] install];
    [[[[titleLabel.layoutMaker toRightOf:imageView offset:edge] toLeftOf:markButton offset:-edge] below:topView offset:edge+4] install];
    
    return self;
}

- (void)bind:(Article *)item {
    _model=item;
    typeLabel.text = [item.type uppercaseString];
    dateLabel.text = item.publishDate;
    titleLabel.text = item.title;
    [imageView loadUrl:item.resImage placeholderImage:@"art-img"];
    imageView.contentMode=UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds=YES;
    
    if (item.isBookmark) {
        [markButton setImage:[UIImage imageNamed:@"book9-light"] forState:UIControlStateNormal];
    }else{
        [markButton setImage:[UIImage imageNamed:@"book9"] forState:UIControlStateNormal];
    }
}

-(void) bindCMS:(CMSModel*)item
{
    _cmsmodel=item;
    typeLabel.text = [_cmsmodel.categoryName uppercaseString];
    dateLabel.text = [NSString timeWithTimeIntervalString:item.publishDate];
    titleLabel.text = _cmsmodel.title;
    NSString *urlstr;
    if (_cmsmodel.featuredMediaId) {
        urlstr=[Proto getFileUrlByObjectId:_cmsmodel.featuredMediaId];
    }
    [imageView loadUrl:urlstr placeholderImage:@"art-img"];
    imageView.contentMode=UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds=YES;
    
    if (item.isBookmark) {
        [markButton setImage:[UIImage imageNamed:@"book9-light"] forState:UIControlStateNormal];
    }else{
        [markButton setImage:[UIImage imageNamed:@"book9"] forState:UIControlStateNormal];
    }
}

-(void) updateBookmarkStatus:(BOOL)ismark
{
    if (ismark) {
        [markButton setImage:[UIImage imageNamed:@"book9-light"] forState:UIControlStateNormal];
    }else{
        [markButton setImage:[UIImage imageNamed:@"book9"] forState:UIControlStateNormal];
    }
}

-(void)moreAction:(UIButton *)sender
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(articleMoreAction:)]){
        [self.delegate articleMoreAction:_model.id];
    }
}

-(void)markAction:(UIButton *)sender
{
//    if (_model.isBookmark) {
//        [markButton setImage:[UIImage imageNamed:@"book9"] forState:UIControlStateNormal];
//    }else{
//        [markButton setImage:[UIImage imageNamed:@"book9-light"] forState:UIControlStateNormal];
//    }
    if(self.delegate && [self.delegate respondsToSelector:@selector(articleMarkAction:)]){
        [self.delegate articleMarkAction:_model.id];
    }
    if(self.delegate && [self.delegate respondsToSelector:@selector(articleMarkActionView:view:)]){
        [self.delegate articleMarkActionView:_cmsmodel view:self];
    }
    
}

-(void)showFilter
{
    DentistPickerView *picker = [[DentistPickerView alloc]init];
    
    picker.leftTitle=localStr(@"Category");
    picker.righTtitle=localStr(@"Cancel");
    [picker show:^(NSString *result,NSString *resultname) {
        
    } rightAction:^(NSString *result,NSString *resultname) {
        
    } selectAction:^(NSString *result,NSString *resultname) {
        if(self.delegate && [self.delegate respondsToSelector:@selector(GSKCategoryPickerSelectAction:)]){
            [self.delegate GSKCategoryPickerSelectAction:result];
        }
    }];
    [Proto queryCategoryTypes:^(NSArray<IdName *> *array) {
        foreTask(^() {
            picker.arrayDic=array;
        });
    }];
}


@end
