//
//  CompanyReviewHeaderTableViewCell.m
//  dentist
//
//  Created by Shirley on 2018/11/28.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "CompanyReviewHeaderTableViewCell.h"
#import "XHStarRateView.h"
#import "CompanyCommentModel.h"
#import "Common.h"
#import "CircleProgressView.h"

@implementation CompanyReviewHeaderTableViewCell{
    
    
    UILabel *starLabel;
    XHStarRateView *starRateView;
    UILabel *reviewCountLabel;
    UIImageView *downArrowImageView;
    
    CircleProgressView *recommendProgressView;
    CircleProgressView *approveProgressView;
    UIImageView *ceoHeadImageView;
    
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
    starLabel = self.addLabel;
    starLabel.font = [Fonts regular:16];
    starLabel.textColor = rgbHex(0x9c9c9c);
    [[[[starLabel.layoutMaker leftParent:edge]topParent:20] sizeEq:40 h:30]install];
    
    starRateView = [[XHStarRateView alloc] initWithFrame:CGRectMake(edge+40, 20, 140, 25)];
    starRateView.isAnimation = YES;
    starRateView.userInteractionEnabled = NO;
    starRateView.rateStyle = WholeStar;
    [self addSubview:starRateView];
    
    downArrowImageView = self.addImageView;
    downArrowImageView.imageName = @"icon_arrow_down_small";
    [[[[downArrowImageView.layoutMaker centerYOf:starRateView offset:0]rightParent:-edge]sizeEq:36 h:36]install];
    
    
    reviewCountLabel = self.addLabel;
    reviewCountLabel.font = [Fonts regular:16];
    reviewCountLabel.textColor = rgbHex(0x9c9c9c);
    reviewCountLabel.textAlignment = NSTextAlignmentCenter;
    [[[[[reviewCountLabel.layoutMaker toRightOf:starRateView offset:10] topParent:20] toLeftOf:downArrowImageView offset:-5] heightEq:30]install];
    
    
    
    int progressEdge = 25;
    int width = SCREENWIDTH / 3 - progressEdge * 2;
    
    recommendProgressView = [CircleProgressView new];
    [self addSubview:recommendProgressView];
    [[[[recommendProgressView.layoutMaker below:starLabel offset:10]leftParent:progressEdge]sizeEq:width h:width]install];
    
    approveProgressView = [CircleProgressView new];
    [self addSubview:approveProgressView];
    [[[[approveProgressView.layoutMaker below:starLabel offset:10]toRightOf:recommendProgressView offset:progressEdge * 2]sizeEq:width h:width]install];
    
    ceoHeadImageView = self.addImageView;
    ceoHeadImageView.layer.masksToBounds = YES;
    ceoHeadImageView.layer.cornerRadius = width / 2;
    [[[[ceoHeadImageView.layoutMaker below:starLabel offset:10]toRightOf:approveProgressView offset:progressEdge * 2]sizeEq:width h:width]install];
    
    
    UILabel *recommendLabel = self.addLabel;
    [self addSubview:recommendLabel];
    recommendLabel.textAlignment = NSTextAlignmentCenter;
    recommendLabel.font = [Fonts regular:12];
    recommendLabel.text = @"Recommend to a friend";
    [[[[recommendLabel.layoutMaker below:recommendProgressView offset:5]centerXOf:recommendProgressView offset:0] widthEq:width] install];
    
    
    UILabel *approveLabel = self.addLabel;
    [self addSubview:approveLabel];
    approveLabel.textAlignment = NSTextAlignmentCenter;
    approveLabel.font = [Fonts regular:12];
    approveLabel.text = @"Approve of CEO";
    [[[[approveLabel.layoutMaker below:approveProgressView offset:5]centerXOf:approveProgressView offset:0] widthEq:width] install];
    
    
    
    UILabel *nameLabel = self.addLabel;
    [self addSubview:nameLabel];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.font = [Fonts regular:12];
    [[[[nameLabel.layoutMaker below:ceoHeadImageView offset:5]centerXOf:ceoHeadImageView offset:0] widthEq:width + width ] install];
    nameLabel.text = @"Helen Morris\nCEO";

    
    UILabel *lineLabel = [self lineLabel];
    [[[[[[lineLabel.layoutMaker leftParent:edge] rightParent:-edge] below:nameLabel offset:15] heightEq:1]bottomParent:0] install];
    
    
    
}


- (void)setData:(CompanyCommentModel *)model{
    
    
    starLabel.text = @"4.0";
    starRateView.currentScore = 4.0f;
    ceoHeadImageView.imageName = @"Img-User-Dentist";
    recommendProgressView.percent = 0.74;
    approveProgressView.percent = 0.68;
    reviewCountLabel.text = @"1146 reviews";
}

@end
