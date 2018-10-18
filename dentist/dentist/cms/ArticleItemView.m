//
// Created by entaoyang on 2018/9/18.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "ArticleItemView.h"
#import "Common.h"
#import "Article.h"
#import "DentistPickerView.h"
#import <CoreText/CoreText.h>

@implementation ArticleItemView {
	UILabel *typeLabel;
	UILabel *dateLabel;
	UILabel *titleLabel;
	UILabel *contentLabel;
	UIImageView *imageView;
	UIButton *markButton;
}

- (instancetype)init {
	self = [super init];

	NSInteger edge = 18;

    CGFloat topheight=40;
    if(IS_IPHONE_P_X){
        topheight=50;
        edge=25;
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
	[[[[[dateLabel.layoutMaker centerYParent:0] rightParent:-edge] heightEq:topheight] widthEq:74] install];

	imageView = self.addImageView;
//    [imageView scaleFillAspect];
	[[[[[imageView.layoutMaker leftParent:0] rightParent:0] below:topView offset:0] heightEq:187] install];

	_moreButton = [self addButton];
	[_moreButton setImage:[UIImage imageNamed:@"dot3.png"] forState:UIControlStateNormal];
    [_moreButton addTarget:self action:@selector(moreAction:) forControlEvents:UIControlEventTouchUpInside];
	[[[[_moreButton.layoutMaker rightParent:-edge] below:imageView offset:edge] sizeEq:20 h:20] install];

	markButton = [self addButton];
	[markButton setImage:[UIImage imageNamed:@"book9"] forState:UIControlStateNormal];
    [markButton addTarget:self action:@selector(markAction:) forControlEvents:UIControlEventTouchUpInside];
	[[[[markButton.layoutMaker toLeftOf:_moreButton offset:-10] below:imageView offset:edge] sizeEq:20 h:20] install];

	titleLabel = [self addLabel];
	titleLabel.font = [Fonts semiBold:20];
	[titleLabel textColorMain];
	titleLabel.numberOfLines = 0;
//	[[[[[titleLabel.layoutMaker leftParent:edge] rightParent:-64] below:imageView offset:10] heightEq:24] install];
	[[[[[titleLabel.layoutMaker leftParent:edge] toLeftOf:markButton offset:-edge-10] below:imageView offset:10] bottomParent:-103] install];

	contentLabel = [self addLabel];
	contentLabel.font = [Fonts regular:15];
	[contentLabel textColorMain];
	[[[[[contentLabel.layoutMaker leftParent:edge] rightParent:-edge-5] heightEq:80] bottomParent:-16] install];

	return self;
}


- (void)bind:(Article *)item {
    _model=item;
	typeLabel.text = [item.type uppercaseString];
	dateLabel.text = item.publishDate;
	titleLabel.text = item.title;
	contentLabel.text = item.content;
	[imageView loadUrl:item.resImage placeholderImage:@"art-img"];
    imageView.contentMode=UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds=YES;
    if (item.isBookmark) {
        [markButton setImage:[UIImage imageNamed:@"book9-light"] forState:UIControlStateNormal];
    }else{
        [markButton setImage:[UIImage imageNamed:@"book9"] forState:UIControlStateNormal];
    }
//    [self layoutIfNeeded];
//    [contentLabel sizeToFit];
//    NSArray *labelarry=[self getSeparatedLinesFromLabel:contentLabel];
//    NSLog(@"contentlabel:%@",labelarry);
    
}

- (NSArray *)getSeparatedLinesFromLabel:(UILabel *)label
{
    NSString *text = [label text];
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



-(void)moreAction:(UIButton *)sender
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(ArticleMoreAction:)]){
        [self.delegate ArticleMoreAction:_model.id];
    }
}

-(void)markAction:(UIButton *)sender
{
    if (_model.isBookmark) {
//        _model.isBookmark=NO;
        [markButton setImage:[UIImage imageNamed:@"book9"] forState:UIControlStateNormal];
    }else{
//        _model.isBookmark=YES;
        [markButton setImage:[UIImage imageNamed:@"book9-light"] forState:UIControlStateNormal];
    }
    if(self.delegate && [self.delegate respondsToSelector:@selector(ArticleMarkAction:)]){
        [self.delegate ArticleMarkAction:_model.id];
    }
    
    
}

-(void)showFilter
{
    DentistPickerView *picker = [[DentistPickerView alloc]init];
    picker.array = @[@"Orthodontics",@"Practice Management",@"DSOs",@"General Dentistry",@"Implant Dentistry",@"Pediatric Dentistry"];
    picker.leftTitle=localStr(@"Category");
    picker.righTtitle=localStr(@"Cancel");
    [picker show:^(NSString *result) {
        
    } rightAction:^(NSString *result) {
        
    } selectAction:^(NSString *result) {
        if(self.delegate && [self.delegate respondsToSelector:@selector(CategoryPickerSelectAction:)]){
            [self.delegate CategoryPickerSelectAction:result];
        }
    }];
}


@end
