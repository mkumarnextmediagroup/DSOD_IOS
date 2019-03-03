//
//  CourseEnrollmentTableViewCell.m
//  dentist
//
//  Created by feng zhenrong on 2019/3/1.
//  Copyright © 2019年 thenextmediagroup.com. All rights reserved.
//

#import "CourseEnrollmentTableViewCell.h"
#import "Common.h"
#import "XHStarRateView.h"
#import "UIImage+customed.h"
#import "Proto.h"
#import "BookmarkManager.h"
@implementation CourseEnrollmentTableViewCell
{
    UILabel *titleLabel;
    UILabel *authorLabel;
    UIImageView *imageView;
    UILabel *lineLabel;
    UIButton *startBtn;
    UIView *progressBgView;
    UIProgressView *progressView;
    UILabel *progressLabel;
    UILabel *statusLabel;
}


/**
 init cell layout
 
 @param style UITableViewCellStyle
 @param reuseIdentifier  reuseIdentifier
 @return instance
 */
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSInteger edge = 16;
        
        imageView = self.addImageView;
        [[[[[imageView.layoutMaker leftParent:edge] topParent:edge] bottomParent:-edge] sizeEq:88 h:117] install];
        
        titleLabel = [self topShowLabel];
        titleLabel.font = [Fonts semiBold:14];
        titleLabel.textColor=Colors.textMain;
        titleLabel.numberOfLines=2;
        [[[[titleLabel.layoutMaker toRightOf:imageView offset:edge] topOf:imageView offset:0] rightParent:-edge] install];
        
        authorLabel=[self addLabel];
        authorLabel.textColor=Colors.textMain;
        authorLabel.font=[UIFont systemFontOfSize:12];
        [[[[authorLabel.layoutMaker toRightOf:imageView offset:edge] below:titleLabel offset:15] sizeEq:160 h:15] install];
        
        startBtn = [self addButton];
        startBtn.backgroundColor=Colors.textDisabled;
        startBtn.titleLabel.font=[UIFont systemFontOfSize:13.0];
        [startBtn setTitle:@"Start Course" forState:UIControlStateNormal];
        [startBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [[[[startBtn.layoutMaker toRightOf:imageView offset:edge] bottomOf:imageView offset:0] sizeEq:104 h:28] install];
        [self progressBgView:0];
        progressBgView.hidden=YES;
        
        lineLabel=self.lineLabel;
        [[[[[lineLabel.layoutMaker leftParent:0] rightParent:0] bottomParent:0] heightEq:1] install];
        
        
    }
    return self;
}

-(void)progressBgView:(NSInteger)progress
{
    NSString *statusStr;
    if (progress==1) {
        statusStr=@"Completed";
    }else{
        statusStr=@"Continue";
    }

    if (!progressBgView) {
        progressBgView=self.addView;//[[UIView alloc] initWithFrame:CGRectMake(0, 0, levelw, 28)];
        [[[[[progressBgView.layoutMaker toRightOf:imageView offset:16] rightParent:-16] bottomOf:imageView offset:0] heightEq:35] install];
        progressView = [UIProgressView new];
        [progressBgView addSubview:progressView];
        //进度条 完成的颜色
        progressView.progressTintColor = Colors.textDisabled;
        //进度条 未完成的颜色
        progressView.trackTintColor = Colors.textColorDDDDDD;
        [[[[[progressView.layoutMaker leftParent:0] rightParent:0] bottomParent:0] heightEq:2] install];
        statusLabel=progressBgView.addLabel;
        statusLabel.textColor = Colors.textDisabled;
        statusLabel.font=[UIFont systemFontOfSize:15.0];
        statusLabel.textAlignment=NSTextAlignmentLeft;
        [[[[statusLabel.layoutMaker leftParent:0] above:progressView offset:-10] sizeEq:80 h:20] install];
        progressLabel=progressBgView.addLabel;
        progressLabel.textColor = Colors.textDisabled;
        progressLabel.font=[UIFont systemFontOfSize:15.0];
        progressLabel.textAlignment=NSTextAlignmentRight;
        [[[[progressLabel.layoutMaker rightParent:0] above:progressView offset:-10] sizeEq:80 h:20] install];
    }
    statusLabel.text=statusStr;
    progressLabel.text=[NSString stringWithFormat:@"%@%@",@(progress*100),@"%"];
    
    
    
}

-(void)setStartStatus:(NSInteger)startStatus
{
    _startStatus=startStatus;
    if (_startStatus==0) {
        startBtn.hidden=NO;
        progressBgView.hidden=YES;
    }else{
        startBtn.hidden=YES;
        progressBgView.hidden=NO;
    }
}

-(void)setModel:(LMSEnrollmentModel *)model
{
    _model=model;
    if(_model){
        GenericCoursesModel *coursemodel=_model.course;
        if (coursemodel) {
            [imageView loadUrl:[Proto getFileUrlByObjectId:coursemodel.image] placeholderImage:@"art-img"];
            [imageView scaleFillAspect];
            imageView.clipsToBounds=YES;
            titleLabel.text=coursemodel.name;
            if (coursemodel.authors && coursemodel.authors.count>0) {
                if(coursemodel.authors[0] && [coursemodel.authors[0] isKindOfClass:[NSDictionary class]]){
                    NSDictionary *authordic=coursemodel.authors[0] ;
                    authorLabel.text=[NSString stringWithFormat:@"%@",[authordic objectForKey:@"fullName"]];
                }
                
            }
        }
        
        [self progressBgView:_model.progress];
        self.startStatus=_model.status;
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
