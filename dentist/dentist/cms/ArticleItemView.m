//
// Created by entaoyang on 2018/9/18.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "ArticleItemView.h"
#import "Common.h"
#import "Article.h"
#import "DentistPickerView.h"
#import <CoreText/CoreText.h>
#import "CMSModel.h"
#import "Proto.h"

@implementation ArticleItemView {
	UILabel *typeLabel;
	UILabel *dateLabel;
	UILabel *titleLabel;
	UILabel *contentLabel;
	UIImageView *imageView;
    UIImageView *thumbImageView;
	UIButton *markButton;
}

- (instancetype)init {
    if (self = [super init]) {
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
        
        imageView = self.addImageView;
        //    [imageView scaleFillAspect];
        [[[[[imageView.layoutMaker leftParent:0] rightParent:0] below:topView offset:0] heightEq:187] install];
        
        thumbImageView = [UIImageView new];
        [imageView addSubview:thumbImageView];
        //    [imageView scaleFillAspect];
        [[[[thumbImageView.layoutMaker leftParent:edge] bottomParent:-edge] sizeEq:28 h:28] install];
        
        _moreButton = [self addButton];
        [_moreButton setImage:[UIImage imageNamed:@"dot3.png"] forState:UIControlStateNormal];
        [_moreButton addTarget:self action:@selector(moreAction:) forControlEvents:UIControlEventTouchUpInside];
        [[[[_moreButton.layoutMaker rightParent:-edge] below:imageView offset:edge] sizeEq:20 h:20] install];
        
        markButton = [self addButton];
        [markButton setImage:[UIImage imageNamed:@"book9"] forState:UIControlStateNormal];
        [markButton addTarget:self action:@selector(markAction:) forControlEvents:UIControlEventTouchUpInside];
        [[[[markButton.layoutMaker toLeftOf:_moreButton offset:-edge+5] below:imageView offset:edge] sizeEq:20 h:20] install];
        
        contentLabel = [self addLabel];
        contentLabel.font = [Fonts regular:15];
        [contentLabel textColorMain];
        //    contentLabel.lineBreakMode=NSLineBreakByWordWrapping;
        //    [[[[[contentLabel.layoutMaker leftParent:edge] rightParent:-edge-5] heightEq:80] bottomParent:-16] install];
        [[[[[contentLabel.layoutMaker leftParent:edge] rightParent:-edge-5] heightEq:80] bottomParent:-16] install];
        
        titleLabel = [self addLabel];
        titleLabel.font = [Fonts semiBold:20];
        [titleLabel textColorMain];
        titleLabel.numberOfLines = 0;
        //    [[[[[titleLabel.layoutMaker leftParent:edge] rightParent:-64] below:imageView offset:10] heightEq:24] install];
        //    [[[[[titleLabel.layoutMaker leftParent:edge] toLeftOf:markButton offset:-edge-10] below:imageView offset:edge-5] bottomParent:-103] install];
        [[[[[titleLabel.layoutMaker leftParent:edge] toLeftOf:markButton offset:-edge-10] below:imageView offset:edge-5] above:contentLabel offset:-23] install];
    }
    return self;
}

- (void)bind:(Article *)item {
    _model=item;
    typeLabel.text = [item.type uppercaseString];
    dateLabel.text = item.publishDate;
    titleLabel.text = item.title;
//    contentLabel.text = item.content;
    [imageView loadUrl:item.resImage placeholderImage:@"art-img"];
    imageView.contentMode=UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds=YES;
    //@"LATEST", @"VIDEOS", @"ARTICLES", @"PODCASTS", @"INTERVIEWS", @"TECH GUIDES", @"ANIMATIONS", @"TIP SHEETS"
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
    if (item.isBookmark) {
        [markButton setImage:[UIImage imageNamed:@"book9-light"] forState:UIControlStateNormal];
    }else{
        [markButton setImage:[UIImage imageNamed:@"book9"] forState:UIControlStateNormal];
    }
    [self layoutIfNeeded];
//    NSLog(@"contentLabelFRAME=%@",NSStringFromCGRect(contentLabel.frame));
    NSArray *labelarry=[self getSeparatedLinesFromLabel:contentLabel text:item.content];
//    NSLog(@"contentlabel:%@",labelarry);
    if (labelarry.count>4 && item.content) {
        NSString *line4String = labelarry[3];
        NSString *showText = [NSString stringWithFormat:@"%@%@%@%@...more", labelarry[0], labelarry[1], labelarry[2], [line4String substringToIndex:line4String.length-6]];
        
        //设置label的attributedText
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:showText attributes:@{NSFontAttributeName:[Fonts regular:15], NSForegroundColorAttributeName:Colors.textMain}];
        [attStr addAttributes:@{NSFontAttributeName:[Fonts regular:15], NSForegroundColorAttributeName:Colors.textDisabled} range:NSMakeRange(showText.length-4, 4)];
        contentLabel.attributedText = attStr;
    }else{
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:item.content attributes:@{NSFontAttributeName:[Fonts regular:15], NSForegroundColorAttributeName:Colors.textMain}];
        contentLabel.attributedText = attStr;;
    }
}

-(void)bindCMS:(CMSModel *)item
{
    _cmsmodel=item;
    typeLabel.text = [_cmsmodel.categoryName uppercaseString];
    dateLabel.text = [NSString timeWithTimeIntervalString:item.publishDate];//item.publishDate;
    titleLabel.text = _cmsmodel.title;
    //    contentLabel.text = item.content;
    NSString *urlstr;
    if (_cmsmodel.featuredMediaId) {
        urlstr=[Proto getFileUrlByObjectId:_cmsmodel.featuredMediaId];
    }
    
    [imageView loadUrl:urlstr placeholderImage:@"art-img"];
    imageView.contentMode=UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds=YES;
    //@"LATEST", @"VIDEOS", @"ARTICLES", @"PODCASTS", @"INTERVIEWS", @"TECH GUIDES", @"ANIMATIONS", @"TIP SHEETS"
    if ([[_cmsmodel.contentTypeName uppercaseString] isEqualToString:@"VIDEOS"]) {
        [thumbImageView setImage:[UIImage imageNamed:@"Video"]];
    }else if([[_cmsmodel.contentTypeName uppercaseString] isEqualToString:@"PODCASTS"]) {
        [thumbImageView setImage:[UIImage imageNamed:@"Podcast"]];
    }else if([[_cmsmodel.contentTypeName uppercaseString] isEqualToString:@"INTERVIEWS"]) {
        [thumbImageView setImage:[UIImage imageNamed:@"Interview"]];
    }else if([[_cmsmodel.contentTypeName uppercaseString] isEqualToString:@"TECH GUIDES"]) {
        [thumbImageView setImage:[UIImage imageNamed:@"TechGuide"]];
    }else if([[_cmsmodel.contentTypeName uppercaseString] isEqualToString:@"ANIMATIONS"]) {
        [thumbImageView setImage:[UIImage imageNamed:@"Animation"]];
    }else if([[_cmsmodel.contentTypeName uppercaseString] isEqualToString:@"TIP SHEETS"]) {
        [thumbImageView setImage:[UIImage imageNamed:@"TipSheet"]];
    }else{
        [thumbImageView setImage:[UIImage imageNamed:@"Article"]];
    }
    if (_cmsmodel.isBookmark) {
        [markButton setImage:[UIImage imageNamed:@"book9-light"] forState:UIControlStateNormal];
    }else{
        [markButton setImage:[UIImage imageNamed:@"book9"] forState:UIControlStateNormal];
    }
    [self layoutIfNeeded];
    //    NSLog(@"contentLabelFRAME=%@",NSStringFromCGRect(contentLabel.frame));
    NSString *contentstr=[NSString stringWithFormat:@"%@",_cmsmodel.content];
//    contentstr = [contentstr stringByReplacingOccurrencesOfString:@"\r" withString:@""];
//    contentstr = [contentstr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    contentstr=[NSString getWithoutHtmlString:contentstr];
    NSArray *labelarry=[self getSeparatedLinesFromLabel:contentLabel text:contentstr];
    //    NSLog(@"contentlabel:%@",labelarry);
    if (labelarry.count>4 && ![NSString isBlankString:contentstr]) {
        NSString *line4String = labelarry[3];
        if (line4String.length>=6) {
            line4String= [line4String substringToIndex:line4String.length-6];
        }
        NSString *showText = [NSString stringWithFormat:@"%@%@%@%@...more", labelarry[0], labelarry[1], labelarry[2], line4String];
        
        //设置label的attributedText
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:showText attributes:@{NSFontAttributeName:[Fonts regular:15], NSForegroundColorAttributeName:Colors.textMain}];
        [attStr addAttributes:@{NSFontAttributeName:[Fonts regular:15], NSForegroundColorAttributeName:Colors.textDisabled} range:NSMakeRange(showText.length-4, 4)];
        contentLabel.attributedText = attStr;
    }else{
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:contentstr attributes:@{NSFontAttributeName:[Fonts regular:15], NSForegroundColorAttributeName:Colors.textMain}];
        contentLabel.attributedText = attStr;;
//        contentLabel.text=contentstr;
    }
}

- (NSArray *)getSeparatedLinesFromLabel:(UILabel *)label text:(NSString *)text
{
    UIFont   *font = [label font];
    CGRect    rect = [label frame];
    CTFontRef myFont = CTFontCreateWithName((__bridge CFStringRef)([font fontName]), [font pointSize], NULL);
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text];
    [attStr addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)myFont range:NSMakeRange(0, attStr.length)];
    
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attStr);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0,0,rect.size.width,100000));
    
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
    
    NSArray *lines = (__bridge NSArray *)CTFrameGetLines(frame);
    NSMutableArray *linesArray = [[NSMutableArray alloc]init];
    
    for (id line in lines)
    {
        CTLineRef lineRef = (__bridge CTLineRef )line;
        CFRange lineRange = CTLineGetStringRange(lineRef);
        NSRange range = NSMakeRange(lineRange.location, lineRange.length);
        
        NSString *lineString = [text substringWithRange:range];
        [linesArray addObject:lineString];
    }
    return linesArray;
    
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
    if(self.delegate && [self.delegate respondsToSelector:@selector(ArticleMoreAction:)]){
        [self.delegate ArticleMoreAction:_cmsmodel.id];
    }
    if(self.delegate && [self.delegate respondsToSelector:@selector(ArticleMoreActionModel:)]){
        [self.delegate ArticleMoreActionModel:_cmsmodel];
    }
}

-(void)markAction:(UIButton *)sender
{
//    if (_model.isBookmark) {
//        [markButton setImage:[UIImage imageNamed:@"book9"] forState:UIControlStateNormal];
//    }else{
//        [markButton setImage:[UIImage imageNamed:@"book9-light"] forState:UIControlStateNormal];
//    }
    if(self.delegate && [self.delegate respondsToSelector:@selector(ArticleMarkActionModel:)]){
        [self.delegate ArticleMarkActionModel:_cmsmodel];
    }
    if(self.delegate && [self.delegate respondsToSelector:@selector(ArticleMarkActionView:view:)]){
        [self.delegate ArticleMarkActionView:_cmsmodel view:self];
    }
    
    
}

-(void)showFilter
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(CategoryPickerSelectAction:categoryName:)]){
        [self.delegate CategoryPickerSelectAction:_cmsmodel.categoryId categoryName:_cmsmodel.categoryName];
    }
}


@end
