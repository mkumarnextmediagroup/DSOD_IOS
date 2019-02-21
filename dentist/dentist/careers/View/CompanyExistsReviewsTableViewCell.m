//
//  CompanyExistsReviewsTableViewCell.m
//  dentist
//
//  Created by Shirley on 2018/12/16.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "CompanyExistsReviewsTableViewCell.h"
#import "Common.h"
#import "XHStarRateView.h"
#import "JobDSOModel.h"

@implementation CompanyExistsReviewsTableViewCell{
    
    
    int edge;
    UILabel *nameLabel;
    XHStarRateView *starRateView;
    UILabel *scoreLabel;
    UILabel *reviewsLabel;
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        edge = 18;
        [self buildViews];
    }
    return self;
}

-(void)buildViews{
    
    nameLabel = [self addLabel];
    nameLabel.font = [Fonts semiBold:13];
    [nameLabel textColorMain];
    [[[[nameLabel.layoutMaker leftParent:edge] topParent:edge-3] rightParent:-30] install];
    
    UIView *starRateViewBg = self.addView;
    [[[starRateViewBg.layoutMaker below:nameLabel offset:5]leftParent:edge] install];
    
    starRateView = [[XHStarRateView alloc] initWithFrame:CGRectMake(0, 0, 83, 15)];
    starRateView.isAnimation = YES;
    starRateView.userInteractionEnabled = NO;
    starRateView.rateStyle = HalfStar;
    [starRateViewBg addSubview:starRateView];
    
    
    
    scoreLabel = [self addLabel];
    scoreLabel.font = [Fonts regular:11];
    scoreLabel.textColor = Colors.textDisabled;
    [[[[scoreLabel.layoutMaker leftParent:edge + 95] below:nameLabel offset:5 ]heightEq:16] install];
    
    reviewsLabel = [self addLabel];
    reviewsLabel.font = [Fonts regular:11];
    reviewsLabel.textColor = Colors.textDisabled;
    [[[[reviewsLabel.layoutMaker rightParent:-50] below:nameLabel offset:5 ]heightEq:16] install];
    
    UILabel *lineLabel = [self lineLabel];
    [[[[[[lineLabel.layoutMaker leftParent:0] rightParent:0] below:scoreLabel offset:edge-3] heightEq:1] bottomParent:0] install];
}

- (void)setData:(JobDSOModel *)model{
    
    nameLabel.text = model.name;
    starRateView.currentScore = model.rating;
    scoreLabel.text = [NSString stringWithFormat:@"%0.1f",model.rating];
    reviewsLabel.text = [NSString stringWithFormat:@"%ld Reviews",model.reviewNum];
    
    
}

@end
