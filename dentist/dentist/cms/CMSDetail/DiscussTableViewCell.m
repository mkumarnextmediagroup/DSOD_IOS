//
//  DiscussTableViewCell.m
//  dentist
//
//  Created by 孙兴国 on 2018/9/19.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "DiscussTableViewCell.h"
#import "XHStarRateView.h"
#import "Common.h"

#define edge 15

@implementation DiscussTableViewCell
{
    UIImageView *headerImg;
    UILabel *finLabel;
    UILabel *reviewLabel;
    UILabel *conLabel;
    XHStarRateView *star;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        headerImg = [UIImageView new];
        [self addSubview:headerImg];
        [[[[headerImg.layoutMaker sizeEq:50 h:50] leftParent:edge] topParent:edge] install];
        headerImg.layer.cornerRadius = 25;
        headerImg.layer.masksToBounds = YES;
        
        finLabel = [self addLabel];
        finLabel.font = [Fonts semiBold:12];
        [finLabel textColorMain];
        finLabel.text = @"Finished the content?";
        [[[[finLabel.layoutMaker toRightOf:headerImg offset:10] topParent:edge] sizeEq:70 h:20] install];
        
        star = [[XHStarRateView alloc] initWithFrame:CGRectMake(180, 15, 100, 16)];
        star.isAnimation = YES;
        star.rateStyle = WholeStar;
        star.tag = 4;
        [self addSubview:star];
        
        reviewLabel = [self addLabel];
        reviewLabel.font = [Fonts regular:12];
        [reviewLabel textColorAlternate];
        reviewLabel.text = @"Add your review";
        [[[[reviewLabel.layoutMaker toRightOf:headerImg offset:10] below:finLabel offset:0] sizeEq:SCREENWIDTH - 95 h:20] install];
        
        conLabel = [self addLabel];
        conLabel.numberOfLines = 0;
        conLabel.font = [Fonts semiBold:12];
        [conLabel textColorMain];
        conLabel.text = @"Finished the content?";
        [[[[conLabel.layoutMaker toRightOf:headerImg offset:10] below:reviewLabel offset:10] sizeEq:SCREENWIDTH - 95 h:40] install];
    }
    return self;
}


- (void)setDisInfo:(DiscussInfo *)disInfo
{
    [headerImg loadUrl:disInfo.disImg placeholderImage:@"user_img"];
    finLabel.text = disInfo.name;
    CGSize size = [finLabel sizeThatFits:CGSizeMake(1000, 20)];
    [[finLabel.layoutUpdate sizeEq:size.width h:20] install];
    star.frame = CGRectMake(size.width + 85, edge+2, 90, 16);
    reviewLabel.text = disInfo.disDate;
    conLabel.text = disInfo.content;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
