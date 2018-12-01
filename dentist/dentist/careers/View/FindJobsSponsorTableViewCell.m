//
//  FindJobsSponsorTableViewCell.m
//  dentist
//
//  Created by feng zhenrong on 2018/11/30.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "FindJobsSponsorTableViewCell.h"
#import "Common.h"
#import "LargeUIButton.h"
#define edge 15

@implementation FindJobsSponsorTableViewCell{
    UIView *largeView;
    UIView *bgView;
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
    UIImageView *locationimageView;
    UILabel *locationLabel;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        bgView=self.contentView.addView;
        
        imageView = bgView.addImageView;
        
        newimageView=bgView.addImageView;
        newimageView.image=[UIImage imageNamed:@"Group Copy"];
        [newimageView scaleFillAspect];
        newimageView.clipsToBounds=YES;
        
        contentLabel=bgView.addLabel;
        
        
        timeLabel = bgView.addLabel;
        
        
        statusLabel = bgView.addLabel;
        
        
        titleLabel = bgView.addLabel;
        
        
        bankImageView=bgView.addImageView;
        bankImageView.image=[UIImage imageNamed:@"icons8-banknotes"];
        [bankImageView scaleFillAspect];
        bankImageView.clipsToBounds=YES;
        
        salaryLabel = bgView.addLabel;
        
        
        followButton = [LargeUIButton new]; //bgView.addButton;
        [bgView addSubview:followButton];
        if (_follow) {
            [followButton setImage:[UIImage imageNamed:@"Shape full"] forState:UIControlStateNormal];
        }else{
            [followButton setImage:[UIImage imageNamed:@"Shape"] forState:UIControlStateNormal];
        }
        
        [followButton addTarget:self action:@selector(followAction:) forControlEvents:UIControlEventTouchUpInside];
        
        lineLabel=bgView.lineLabel;
        
        desLabel=bgView.addLabel;
        
        
        locationimageView=bgView.addImageView;
        locationimageView.image=[UIImage imageNamed:@"icons8-marker"];
        [locationimageView scaleFillAspect];
        locationimageView.clipsToBounds=YES;
        
        
        locationLabel=bgView.addLabel;
        desLabel.hidden=YES;
        locationimageView.hidden=YES;
        locationLabel.hidden=YES;
        newimageView.hidden=YES;
        
        [self setDetailFrame];
    }
    return self;
}

-(void)setIsNew:(BOOL)isNew
{
    _isNew=isNew;
    if (_isNew) {
        newimageView.hidden=NO;
    }else{
        newimageView.hidden=YES;
    }
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
        salaryLabel.text=[NSString stringWithFormat:@"$%@k-$%@k",@(startsalary),@(endsalary)];
        desLabel.text=_info.jobDescription;
        locationLabel.text=_info.location;
        [salaryLabel sizeToFit];
        [[salaryLabel.layoutUpdate sizeEq:salaryLabel.frame.size.width h:16] install];
        [[bankImageView.layoutUpdate toLeftOf:salaryLabel offset:-5] install];
        if (_follow) {
            [followButton setImage:[UIImage imageNamed:@"Shape full"] forState:UIControlStateNormal];
        }else{
            if ([_info.isAttention boolValue]) {
                [followButton setImage:[UIImage imageNamed:@"Shape full"] forState:UIControlStateNormal];
            }else{
                [followButton setImage:[UIImage imageNamed:@"Shape"] forState:UIControlStateNormal];
            }
        }
        
    }
}

-(void)setDetailFrame{
    desLabel.hidden=NO;
    locationimageView.hidden=NO;
    locationLabel.hidden=NO;
    lineLabel.hidden=YES;
    bgView.layer.borderColor=Colors.strokes.CGColor;
    bgView.layer.borderWidth=1.0;
    
    contentLabel.font = [Fonts semiBold:11];
    contentLabel.textColor = Colors.textAlternate;
    timeLabel.textAlignment=NSTextAlignmentRight;
    timeLabel.font = [Fonts regular:12];
    timeLabel.textColor = Colors.textDisabled;
    statusLabel.font = [Fonts semiBold:8];
    statusLabel.textColor = Colors.textAlternate;
    titleLabel.font = [Fonts semiBold:16];
    [titleLabel textColorMain];
    titleLabel.numberOfLines=0;
    salaryLabel.font = [Fonts regular:14];
    salaryLabel.textColor = Colors.textColor9c;
    salaryLabel.textAlignment=NSTextAlignmentRight;
    
    locationLabel.font = [Fonts regular:14];
    locationLabel.textColor = Colors.textColor9c;
    
    desLabel.font = [Fonts semiBold:11];
    desLabel.textColor = Colors.textAlternate;
    desLabel.numberOfLines=0;
    
    
    
    [[[[[bgView.layoutMaker leftParent:10] rightParent:-10] topParent:5] bottomParent:-5] install];
    [[[[newimageView.layoutMaker leftParent:0] topParent:0] sizeEq:58 h:58] install];
    [[[[imageView.layoutMaker leftParent:edge] topParent:edge] sizeEq:55 h:55] install];
    
    [[[[timeLabel.layoutMaker topParent:edge] rightParent:-edge] sizeEq:28 h:15.0] install];
    [[[[statusLabel.layoutMaker toLeftOf:timeLabel offset:3] topParent:edge] sizeEq:80 h:15.0] install];
    [[[[titleLabel.layoutMaker toRightOf:imageView offset:10] toLeftOf:statusLabel offset:3] topParent:edge] install];
    [[[[[[contentLabel.layoutMaker toRightOf:imageView offset:10] heightEq:15.0] rightParent:-46] below:titleLabel offset:0] bottomOf:imageView offset:0] install];
    [[[[followButton.layoutMaker rightParent:-edge] bottomOf:imageView offset:0] sizeEq:20 h:20] install];
    [[[[desLabel.layoutMaker leftParent:edge] rightParent:-46] below:contentLabel offset:5] install];
    
    [[[[locationimageView.layoutMaker leftParent:edge] below:desLabel offset:8]  sizeEq:12 h:12] install];
    [[[[[locationLabel.layoutMaker toRightOf:locationimageView offset:7] below:desLabel offset:7] sizeEq:100 h:16.0] bottomParent:-10] install];
    [[[[[salaryLabel.layoutMaker rightParent:-edge] below:desLabel offset:7] sizeEq:100 h:16.0] bottomParent:-10] install];
    
    [[[[bankImageView.layoutMaker toLeftOf:salaryLabel offset:-5] below:desLabel offset:8]   sizeEq:12 h:12] install];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)followAction:(UIButton *)sender
{
    if(_follow){
        if(self.delegate && [self.delegate respondsToSelector:@selector(UnFollowJobAction:view:)]){
            [self.delegate UnFollowJobAction:_indexPath view:self];
        }
    }else{
        if ([_info.isAttention boolValue]) {
            if(self.delegate && [self.delegate respondsToSelector:@selector(UnFollowJobAction:view:)]){
                [self.delegate UnFollowJobAction:_indexPath view:self];
            }
        }else{
            if(self.delegate && [self.delegate respondsToSelector:@selector(FollowJobAction:view:)]){
                [self.delegate FollowJobAction:_indexPath view:self];
            }
        }
    }
    
}

-(void)updateFollowStatus:(BOOL)isfllow
{
    if (isfllow) {
        _info.isAttention=@"1";
        [followButton setImage:[UIImage imageNamed:@"Shape full"] forState:UIControlStateNormal];
    }else{
        _info.isAttention=@"0";
        [followButton setImage:[UIImage imageNamed:@"Shape"] forState:UIControlStateNormal];
    }
}

@end
