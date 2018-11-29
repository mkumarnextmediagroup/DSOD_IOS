//
//  FindJobsTableViewCell.m
//  dentist
//
//  Created by feng zhenrong on 2018/11/29.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "FindJobsTableViewCell.h"
#import "Common.h"
#define edge 15

@implementation FindJobsTableViewCell{
    UIView *largeView;
    UIView *normalView;
    UILabel *titleLabel;
    UILabel *statusLabel;
    UILabel *timeLabel;
    UILabel *contentLabel;
    UILabel *desLabel;
    UILabel *salaryLabel;
    UIImageView *imageView;
    UIButton *followButton;
    UILabel *lineLabel;
    UIImageView *newimageView;
    UIImageView *bankImageView;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        imageView = self.addImageView;
        [[[[imageView.layoutMaker leftParent:edge] centerYParent:0] sizeEq:55 h:55] install];
        contentLabel=self.addLabel;
        contentLabel.font = [Fonts semiBold:11];
        contentLabel.textColor = Colors.textAlternate;
        [[[[[contentLabel.layoutMaker toRightOf:imageView offset:10] heightEq:15.0] rightParent:-46] centerYParent:0] install];
        
        timeLabel = self.addLabel;
        timeLabel.textAlignment=NSTextAlignmentRight;
        timeLabel.font = [Fonts regular:12];
        timeLabel.textColor = Colors.textDisabled;
        [[[[timeLabel.layoutMaker rightParent:-edge] above:contentLabel offset:-5] sizeEq:28 h:15.0] install];
        
        statusLabel = self.addLabel;
        statusLabel.font = [Fonts semiBold:8];
        statusLabel.textColor = Colors.textAlternate;
        [[[[statusLabel.layoutMaker toLeftOf:timeLabel offset:3] above:contentLabel offset:-5] sizeEq:80 h:15.0] install];
        
        titleLabel = self.addLabel;
        titleLabel.font = [Fonts semiBold:13];
        [titleLabel textColorMain];
        [[[[[titleLabel.layoutMaker toRightOf:imageView offset:10] toLeftOf:statusLabel offset:3] above:contentLabel offset:-5] heightEq:15.0] install];
        
        bankImageView=self.addImageView;
        bankImageView.image=[UIImage imageNamed:@"icons8-banknotes"];
        [bankImageView scaleFillAspect];
        bankImageView.clipsToBounds=YES;
        [[[[bankImageView.layoutMaker toRightOf:imageView offset:10] below:contentLabel offset:7] sizeEq:11 h:11] install];
        
        salaryLabel = self.addLabel;
        salaryLabel.font = [Fonts regular:12];
        salaryLabel.textColor = Colors.textDisabled;
        [[[[salaryLabel.layoutMaker toRightOf:bankImageView offset:7] below:contentLabel offset:5] heightEq:15.0] install];
        
        followButton =self.addButton;
        [followButton setImage:[UIImage imageNamed:@"Shape"] forState:UIControlStateNormal];
        [[[[followButton.layoutMaker rightParent:-edge] centerYOf:salaryLabel offset:0] sizeEq:20 h:20] install];
        
        lineLabel=self.lineLabel;
        lineLabel.backgroundColor=Colors.lineColorNor;
        [[[[[lineLabel.layoutMaker leftParent:0] rightParent:0] bottomParent:0] heightEq:1] install];
    }
    return self;
}

-(void)setInfo:(JobModel *)info
{
    _info=info;
    if (_info) {
        [self layoutIfNeeded];
        imageView.image = [UIImage imageNamed:@"user_img"];
        [imageView scaleFillAspect];
        imageView.clipsToBounds=YES;
        contentLabel.text = [NSString stringWithFormat:@"Supported by %@",_info.company.companyName];
        timeLabel.text = @"6d";
        titleLabel.text = [NSString stringWithFormat:@"%@-%@",_info.jobTitle,_info.location];
        statusLabel.text=@"POSITION CLOSE";
        NSInteger startsalary=ceilf(_info.salaryStartingValue/1000.0);
        NSInteger endsalary=ceilf(_info.salaryEndValue/1000.0);
        salaryLabel.text=[NSString stringWithFormat:@"$%@k-$%@k",@(startsalary),@(endsalary)];;
    }
}

-(void)setIsDetail:(BOOL)isDetail
{
    _isDetail=isDetail;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
