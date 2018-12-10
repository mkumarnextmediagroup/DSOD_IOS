//
//  FindJobsTableViewCell.m
//  dentist
//
//  Created by feng zhenrong on 2018/11/29.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "FindJobsTableViewCell.h"
#import "Common.h"
#import "LargeUIButton.h"
#import "DentistDataBaseManager.h"
#define edge 15

@implementation FindJobsTableViewCell{
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
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        bgView=self.contentView.addView;

        imageView = bgView.addImageView;

        newimageView=bgView.addImageView;
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
        
        [self setNormalFrame];
    }
    return self;
}

-(void)setInfo:(JobModel *)info
{
    _info=info;
    if (_info) {
        [self layoutIfNeeded];
        NSString *logourl=_info.dso.companyLogoUrl;
        [imageView loadUrl:logourl placeholderImage:@"user_img"];
        [imageView scaleFillAspect];
        imageView.clipsToBounds=YES;
        contentLabel.text = [NSString stringWithFormat:@"Supported by %@",_info.company];
        NSInteger diffday=[NSDate getDifferenceByTimestamp:_info.modifiedDate];
        if (diffday==0) {
            timeLabel.text = @"today";
        }else if (diffday>=1){
            timeLabel.text = [NSString stringWithFormat:@"%@d",@(diffday)];
        }else{
            timeLabel.text = @"-d";
        }
        
        titleLabel.text = [NSString stringWithFormat:@"%@-%@",_info.jobTitle,_info.location];
        statusLabel.text=@"POSITION CLOSE";
        NSInteger startsalary=ceilf(_info.salaryStartingValue/1000.0);
        NSInteger endsalary=ceilf(_info.salaryEndValue/1000.0);
        salaryLabel.text=[NSString stringWithFormat:@"$%@k-$%@k",@(startsalary),@(endsalary)];
        desLabel.text=_info.jobDescription;
        locationLabel.text=_info.location;
        if (_follow) {
            [followButton setImage:[UIImage imageNamed:@"Shape full"] forState:UIControlStateNormal];
        }else{
            if ([_info.isAttention boolValue]) {
                [followButton setImage:[UIImage imageNamed:@"Shape full"] forState:UIControlStateNormal];
            }else{
                [followButton setImage:[UIImage imageNamed:@"Shape"] forState:UIControlStateNormal];
            }
        }
        if(_info.status==3){
            self->newimageView.hidden=NO;
            self->newimageView.image=[UIImage imageNamed:@"Closed"];
        }else{
            [[DentistDataBaseManager shareManager] checkJobsStatus:_info.id publishDate:_info.publishOn modifiedDate:_info.modifiedDate completed:^(NSInteger result) {
                foreTask(^{
                    if (result==1) {
                        self->newimageView.hidden=NO;
                        self->newimageView.image=[UIImage imageNamed:@"New"];
                    }else if (result==2){
                        self->newimageView.hidden=NO;
                        self->newimageView.image=[UIImage imageNamed:@"Updated"];
                    }else{
                        self->newimageView.hidden=YES;
                    }
                });
                
            }];
        }
        
    }
}

-(void)setInfoDic:(NSDictionary *)infoDic
{
    _infoDic=infoDic;
    if (_infoDic) {
        [self layoutIfNeeded];
        NSString *logourl=[_infoDic objectForKey:@"logoUrl"];
        NSString *companyName=[_infoDic objectForKey:@"companyName"];
        NSString *jobTitle=[_infoDic objectForKey:@"jobTitle"];
        NSString *salary=[_infoDic objectForKey:@"salary"];
        BOOL isAttention=[[_infoDic objectForKey:@"isAttention"] boolValue];
        [imageView loadUrl:logourl placeholderImage:@"user_img"];
//        imageView.image = [UIImage imageNamed:@"user_img"];
        [imageView scaleFillAspect];
        imageView.clipsToBounds=YES;
        contentLabel.text = [NSString stringWithFormat:@"%@",companyName];
        timeLabel.text = @"6d";
        titleLabel.text = [NSString stringWithFormat:@"%@",jobTitle];
        statusLabel.text=@"";
        salaryLabel.text=[NSString stringWithFormat:@"%@",salary];
        if (_follow) {
            [followButton setImage:[UIImage imageNamed:@"Shape full"] forState:UIControlStateNormal];
        }else{
            if (isAttention) {
                [followButton setImage:[UIImage imageNamed:@"Shape full"] forState:UIControlStateNormal];
            }else{
                [followButton setImage:[UIImage imageNamed:@"Shape"] forState:UIControlStateNormal];
            }
        }
        
    }
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

//-(void)setIsDetail:(BOOL)isDetail
//{
//    _isDetail=isDetail;
//    if (_isDetail) {
//        [self setDetailFrame];
//
//    }else{
//        [self setNormalFrame];
//    }
//}

-(void)setNormalFrame{
    desLabel.hidden=YES;
    locationimageView.hidden=YES;
    locationLabel.hidden=YES;
    lineLabel.hidden=NO;
    bgView.layer.borderColor=[UIColor clearColor].CGColor;
    bgView.layer.borderWidth=0.0;
    contentLabel.font = [Fonts semiBold:11];
    contentLabel.textColor = Colors.textAlternate;
    timeLabel.textAlignment=NSTextAlignmentRight;
    timeLabel.font = [Fonts regular:12];
    timeLabel.textColor = Colors.textDisabled;
    statusLabel.font = [Fonts semiBold:8];
    statusLabel.textColor = Colors.textAlternate;
    titleLabel.font = [Fonts semiBold:13];
    [titleLabel textColorMain];
    titleLabel.numberOfLines=2;
    salaryLabel.font = [Fonts regular:12];
    salaryLabel.textColor = Colors.textDisabled;
    salaryLabel.textAlignment=NSTextAlignmentRight;
    
    [[[[[bgView.layoutMaker leftParent:0] rightParent:0] topParent:0] bottomParent:0] install];
    [[[[newimageView.layoutMaker leftParent:0] topParent:0] sizeEq:58 h:58] install];
    [[[imageView.layoutMaker leftParent:edge] sizeEq:55 h:55] install];
    
    [[[[timeLabel.layoutMaker topParent:edge] rightParent:-edge] sizeEq:80 h:15.0] install];
//    [[[[statusLabel.layoutMaker toLeftOf:timeLabel offset:3] topParent:edge] sizeEq:80 h:15.0] install];
    [[[[titleLabel.layoutMaker toRightOf:imageView offset:10] toLeftOf:timeLabel offset:3] topParent:edge] install];
    
    [[[[[contentLabel.layoutMaker toRightOf:imageView offset:10] heightEq:15.0] rightParent:-46] below:titleLabel offset:5] install];
    
    [[[[bankImageView.layoutMaker toRightOf:imageView offset:10] below:contentLabel offset:7] sizeEq:11 h:11] install];
    [[[[[salaryLabel.layoutMaker toRightOf:bankImageView offset:7] below:contentLabel offset:5] heightEq:15.0] bottomParent:-edge] install];
    [[[[followButton.layoutMaker rightParent:-edge] centerYOf:salaryLabel offset:0] sizeEq:20 h:20] install];
    [[[[[lineLabel.layoutMaker leftParent:0] rightParent:0] bottomParent:0] heightEq:1] install];
    [[imageView.layoutUpdate centerYParent:0] install];
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
