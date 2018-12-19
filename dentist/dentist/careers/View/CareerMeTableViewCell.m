//
//  CareerMeTableViewCell.m
//  dentist
//
//  Created by feng zhenrong on 2018/12/18.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "CareerMeTableViewCell.h"
#import "Common.h"

@interface CareerMeTableViewCell(){
    
}
@end

@implementation CareerMeTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSInteger edge = 28;
        self.headerView = self.contentView.addImageView;
        [self.headerView scaleFillAspect];
        self.headerView.clipsToBounds=YES;
        [[[[self.headerView.layoutMaker leftParent:edge] centerYParent:0 ] sizeEq:23 h:23] install];
        
        UIImageView *iconView = self.contentView.addImageView;
        iconView.imageName = @"arrow_small";
        [[[[iconView.layoutMaker sizeEq:16 h:16] rightParent:-30] centerYParent:0 ] install];
        self.titleLabel = self.contentView.addLabel;
        self.titleLabel.font = [Fonts semiBold:16];
        [self.titleLabel textColorMain];
        [[[[[self.titleLabel.layoutMaker toRightOf:self.headerView offset:14] bottomOf:self.headerView offset:-(27.0/2)] toLeftOf:iconView offset:-10] heightEq:20] install];
        self.desLabel = self.contentView.addLabel;
        self.desLabel.font = [Fonts semiBold:13];
        self.desLabel.textColor = Colors.textAlternate;
        [[[[[self.desLabel.layoutMaker toRightOf:self.headerView offset:14] topOf:self.headerView offset:(27.0/2)] toLeftOf:iconView offset:-10] heightEq:20] install];
        
        UILabel *lineLabel=self.contentView.lineLabel;
        [[[[[lineLabel.layoutMaker leftParent:edge] rightParent:0] bottomParent:0] heightEq:1] install];
        
    }
    return self;
}

-(void)layoutSubviews
{
    NSLog(@"====layoutSubviews");
    if (self.headerView.image) {
        CGFloat headerimgh=(self.headerView.image.size.height/self.headerView.image.size.width)*23;
        [[self.headerView.layoutUpdate heightEq:headerimgh] install];
    }
    
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
