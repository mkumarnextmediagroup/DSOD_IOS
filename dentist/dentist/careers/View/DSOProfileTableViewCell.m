//
//  DSOProfileTableViewCell.m
//  dentist
//
//  Created by Jacksun on 2018/11/27.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "DSOProfileTableViewCell.h"
#import "Common.h"
#import "XHStarRateView.h"

#define edge 15
@implementation DSOProfileTableViewCell
{
    UIImageView *headerImg;
    UILabel *finLabel;
    UILabel *reviewLabel;
    UILabel *conLabel;
    XHStarRateView *_star;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        headerImg = [UIImageView new];
        [self addSubview:headerImg];
        headerImg.image = [UIImage imageNamed:@"user_img"];
        [[[[headerImg.layoutMaker sizeEq:50 h:50] leftParent:edge] topParent:edge] install];
        
        finLabel = [self addLabel];
        finLabel.font = [Fonts semiBold:14];
        [finLabel textColorMain];
//        finLabel.text = @"Finished the content?";
        [[[[finLabel.layoutMaker toRightOf:headerImg offset:15] topParent:8] sizeEq:200 h:20] install];
        
        _star = [[XHStarRateView alloc] initWithFrame:CGRectMake(80, 35, 90, 16)];
        _star.isAnimation = YES;
        _star.userInteractionEnabled = NO;
        _star.rateStyle = WholeStar;
        [self addSubview:_star];
        
        reviewLabel = [self addLabel];
        reviewLabel.font = [Fonts regular:10];
        reviewLabel.textColor = Colors.textDisabled;
//        reviewLabel.text = @"1234 Reviews";
        [[[[reviewLabel.layoutMaker toRightOf:_star offset:10] below:finLabel offset:4] sizeEq:100 h:20] install];
        
        conLabel = [self addLabel];
        conLabel.numberOfLines = 0;
        conLabel.font = [Fonts semiBold:12];
        conLabel.textColor = Colors.textAlternate;
        //        [conLabel textColorMain];
//        conLabel.text = @"Finished the content?";
        [[[[conLabel.layoutMaker toRightOf:headerImg offset:15] below:reviewLabel offset:0] sizeEq:SCREENWIDTH - 95 h:30] install];
    }
    return self;
}

- (void)bindInfo:(JobDSOModel *)modelInfo
{
    _star.currentScore = modelInfo.rating;
    [headerImg sd_setImageWithURL:[NSURL URLWithString:modelInfo.logoURL] placeholderImage:[UIImage imageNamed:@"user_img"]];
    finLabel.text = modelInfo.name;
    reviewLabel.text = [NSString stringWithFormat:@"%ld Reviews",(long)modelInfo.reviewNum];
    conLabel.text = modelInfo.address1;
}

@end
