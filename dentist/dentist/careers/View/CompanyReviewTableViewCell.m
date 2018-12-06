//
//  CompanyReviewTableViewCell.m
//  dentist
//
//  Created by Shirley on 2018/11/28.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "CompanyReviewTableViewCell.h"
#import "CompanyCommentReviewsModel.h"
#import "Common.h"
#import "XHStarRateView.h"
#import "NSDate+customed.h"

@implementation CompanyReviewTableViewCell{
    
    UIView *contentView;
    XHStarRateView *starRateView;
    UILabel *reviewTitleLabel;
    UILabel *reviewDateLabel;
    UILabel *currentEmployeeLabel;
    UILabel *prosValueLabel;
    UILabel *consValueLabel;
    UILabel *adviceValueLabel;
    
    
    int edge;
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        edge = 18;
        [self buildView];
    }
    return self;
}


-(void)buildView{
    
    contentView = self.addView;
    contentView.backgroundColor = rgbHex(0xfafbfc);
    [[[[[contentView.layoutMaker leftParent:edge]topParent:edge]rightParent:-edge]bottomParent:-edge] install];
    
    reviewTitleLabel = contentView.addLabel;
    reviewTitleLabel.textColor = rgbHex(0x1b1b1b);
    reviewTitleLabel.font = [Fonts regular:16];
    [[[[reviewTitleLabel.layoutMaker leftParent:edge] topParent:edge] rightParent:-edge]install];

    reviewDateLabel = contentView.addLabel;
    reviewDateLabel.textColor = rgbHex(0xbababa);
    reviewDateLabel.font = [Fonts regular:14];
    [[[reviewDateLabel.layoutMaker leftParent:edge] below:reviewTitleLabel offset:10] install];
    
    starRateView = [[XHStarRateView alloc] initWithFrame:CGRectMake(0 , 0, 110, 20)];
    starRateView.isAnimation = NO;
    starRateView.userInteractionEnabled = NO;
    starRateView.rateStyle = WholeStar;
    [contentView addSubview:starRateView];
    [[[starRateView.layoutUpdate below:reviewTitleLabel offset:10]rightParent:-110 - edge] install];
    

    currentEmployeeLabel = contentView.addLabel;
    currentEmployeeLabel.textColor = rgbHex(0x787878);
    currentEmployeeLabel.font = [Fonts regular:12];
    [[[[currentEmployeeLabel.layoutMaker leftParent:edge] below:reviewDateLabel offset:10] rightParent:-edge] install];
    
    
    UILabel *prosLabel = contentView.addLabel;
    prosLabel.text = @"Pros";
    prosLabel.textColor = rgbHex(0xbababa);
    prosLabel.font = [Fonts regular:14];
    [[[[prosLabel.layoutMaker leftParent:edge] below:currentEmployeeLabel offset:25] rightParent:-edge]install];
    
    prosValueLabel = contentView.addLabel;
    prosValueLabel.textColor = rgbHex(0x1b1b1b);
    prosValueLabel.font = [Fonts regular:14];
    [[[[prosValueLabel.layoutMaker leftParent:edge] below:prosLabel offset:15] rightParent:-edge]install];
    
    UILabel *consLabel = contentView.addLabel;
    consLabel.text = @"Cons";
    consLabel.textColor = rgbHex(0xbababa);
    consLabel.font = [Fonts regular:14];
    [[[[consLabel.layoutMaker leftParent:edge] below:prosValueLabel offset:25] rightParent:-edge]install];
    
    consValueLabel = contentView.addLabel;
    consValueLabel.textColor = rgbHex(0x1b1b1b);
    consValueLabel.font = [Fonts regular:14];
    [[[[consValueLabel.layoutMaker leftParent:edge] below:consLabel offset:15] rightParent:-edge]install];
 
    
    UILabel *adviceLabel = contentView.addLabel;
    adviceLabel.text = @"Advice to Management";
    adviceLabel.textColor = rgbHex(0xbababa);
    adviceLabel.font = [Fonts regular:14];
    [[[[adviceLabel.layoutMaker leftParent:edge] below:consValueLabel offset:25] rightParent:-edge]install];
    
    adviceValueLabel = contentView.addLabel;
    adviceValueLabel.textColor = rgbHex(0x1b1b1b);
    adviceValueLabel.font = [Fonts regular:14];
    [[[[adviceValueLabel.layoutMaker leftParent:edge] below:adviceLabel offset:15] rightParent:-edge]install];
    
    UILabel *lineLabel = [contentView lineLabel];
    [[[[lineLabel.layoutMaker leftParent:edge] below:adviceValueLabel offset:10] rightParent:-edge]install];
    

    
    
    
    [[lineLabel.layoutUpdate bottomParent:-edge]install];
//
//    UIButton *recommendsbtn = contentView.addButton;
//    [recommendsbtn setTitle:@"Recommends" forState:UIControlStateNormal];
//    [recommendsbtn setImage:@"icon_check_mark_small" forState:UIControlStateNormal];
//    recommendsbtn.imageEdgeInsets = UIEdgeInsetsMake(0.0,10.0, 0.0, 0.0);
//    recommendsbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;

    
    
//    Approve of CEO
//    [focusBtn setTitleEdgeInsets:UIEdgeInsetsMake(focusBtn.imageView.frame.size.height ,-focusBtn.imageView.frame.size.width, 0.0,0.0)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
//    [focusBtn setImageEdgeInsets:UIEdgeInsetsMake(-focusBtn.imageView.frame.size.height, 0.0,0.0, -focusBtn.titleLabel.bounds.size.width)];
//
//    Recommends
    
    
    
    
}



-(void)setData:(CompanyCommentReviewsModel*)model{
    reviewTitleLabel.text = [NSString stringWithFormat:@"\"%@\"",model.reviewTitle];
    reviewDateLabel.text = [NSDate USDateShortFormatWithTimestamp:model.reviewDate];
    starRateView.currentScore = 4.0;
    
    if(model.isCurrentEmployee){
        currentEmployeeLabel.text = @"Current Employee";
    }else if(model.isFormerEmployee){
        currentEmployeeLabel.text = @"Former Employee";
    }
    prosValueLabel.text = model.pros;
    consValueLabel.text = model.cons;
    adviceValueLabel.text = model.advice;
    
    
}


@end
