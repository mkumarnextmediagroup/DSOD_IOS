//
//  CourseTableViewCell.m
//  dentist
//
//  Created by feng zhenrong on 2019/2/15.
//  Copyright © 2019年 thenextmediagroup.com. All rights reserved.
//

#import "CourseTableViewCell.h"
#import "Common.h"
#import "XHStarRateView.h"
#import "UIImage+customed.h"
#import "Proto.h"

@implementation CourseTableViewCell
{
    UILabel *titleLabel;
    UILabel *authorLabel;
    UIImageView *imageView;
    UIButton *markButton;
    UIView *levelView;
    UILabel *levelLabel;
    UIImageView *levelImageView;
    UIImageView *timerimageView;
    UILabel *timerLabel;
    UILabel *priceLabel;
    XHStarRateView *starview;
    UIButton *gskBtn;
    UILabel *lineLabel;
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
        CGFloat sponstorimgh=((50.0/375.0)*SCREENWIDTH);
        gskBtn = [self addButton];
        [gskBtn setBackgroundImage:[UIImage imageNamed:@"sponsor_gsk"] forState:UIControlStateNormal];
        [gskBtn addTarget:self action:@selector(gskAction:) forControlEvents:UIControlEventTouchUpInside];
        [[[[[gskBtn.layoutMaker leftParent:0] rightParent:0] bottomParent:0] heightEq:sponstorimgh] install];
        
        imageView = self.addImageView;
        [[[[[imageView.layoutMaker leftParent:edge] topParent:edge] above:gskBtn offset:-10] sizeEq:88 h:117] install];
        
        UIImage *bookmarkimage=[UIImage imageNamed:@"book9-light"];
        markButton = [self addButton];
        [markButton setImage:bookmarkimage forState:UIControlStateNormal];
        [markButton addTarget:self action:@selector(markAction:) forControlEvents:UIControlEventTouchUpInside];
        [[[[markButton.layoutMaker rightParent:-5] topParent:5] sizeEq:48 h:48] install];
        
        
        titleLabel = [self topShowLabel];
        titleLabel.font = [Fonts semiBold:14];
        titleLabel.textColor=Colors.textMain;
        titleLabel.numberOfLines=2;
        [[[[titleLabel.layoutMaker toRightOf:imageView offset:edge] topOf:imageView offset:0] toLeftOf:markButton offset:10] install];
        [self levelView:0];
        
        timerimageView=self.addImageView;
        [[[[timerimageView.layoutMaker toRightOf:levelView offset:10] centerYOf:levelView offset:0] sizeEq:16 h:16] install];
        UIImage *timerimage=[UIImage imageNamed:@"ic_course_time"];
        timerimageView.image=[timerimage imageChangeColor:Colors.textDisabled];
        [timerimageView scaleFillAspect];
        
        timerLabel=[self addLabel];
        timerLabel.textColor=Colors.secondary;
        timerLabel.font=[UIFont systemFontOfSize:13];
        [[[[timerLabel.layoutMaker toRightOf:timerimageView offset:5] centerYOf:levelView offset:0] sizeEq:60 h:16] install];
        
        CGFloat bookspace=(48-bookmarkimage.size.width)/2;
        if (bookspace<=0) {
            bookspace=0;
        }
        priceLabel=[self addLabel];
        priceLabel.textColor=Colors.secondary;
        priceLabel.font=[UIFont systemFontOfSize:13];
        priceLabel.textAlignment=NSTextAlignmentRight;
        [[[[priceLabel.layoutMaker rightParent:-5-bookspace] centerYOf:levelView offset:0] sizeEq:60 h:16] install];
        starview = [[XHStarRateView alloc] initWithFrame:CGRectMake(edge, 50, 92, 16) starStyle:StarStyleCourse];
        starview.userInteractionEnabled = NO;
        starview.isAnimation = NO;
        [self addSubview:starview];
         [[[[starview.layoutMaker toRightOf:imageView offset:edge] above:levelView offset:-10] sizeEq:60 h:16] install];
        
        authorLabel=[self addLabel];
        authorLabel.textColor=Colors.textMain;
        authorLabel.font=[UIFont systemFontOfSize:12];
        [[[[authorLabel.layoutMaker toRightOf:imageView offset:edge] above:starview offset:-10] sizeEq:160 h:15] install];
        
        
        lineLabel=self.lineLabel;
        [[[[[lineLabel.layoutMaker leftParent:0] rightParent:0] bottomParent:0] heightEq:1] install];
        
        
    }
    return self;
}

-(void)levelView:(NSInteger)level
{
    NSString *levelStr;
    if (level<=0) {
        levelStr=@"Beginner";
    }
    CGSize strSize=CGSizeMake(MAXFLOAT, 15);
    NSDictionary *attr=@{NSFontAttributeName:[UIFont systemFontOfSize:13.0]};
    CGSize leftlableSize=[levelStr boundingRectWithSize:strSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size;
    CGFloat levelw=leftlableSize.width+10+10+23;
    if (!levelView) {
        levelView=self.addView;//[[UIView alloc] initWithFrame:CGRectMake(0, 0, levelw, 28)];
        levelView.layer.borderWidth=1;
        levelView.layer.borderColor=Colors.textColorDDDDDD.CGColor;
        [[[[levelView.layoutMaker toRightOf:imageView offset:16] bottomOf:imageView offset:0] sizeEq:levelw h:28] install];
        levelImageView=levelView.addImageView;
        levelImageView.image=[UIImage imageNamed:@"cellular-connection-full"];
        [[[[levelImageView.layoutMaker leftParent:5] centerYParent:0] sizeEq:18 h:12] install];
        [levelImageView scaleFillAspect];
        levelImageView.clipsToBounds=YES;
        levelLabel=levelView.addLabel;
        levelLabel.text=levelStr;
        levelLabel.textColor=Colors.black1A191A;
        levelLabel.font=[UIFont systemFontOfSize:13.0];
        [[[levelLabel.layoutMaker toRightOf:levelImageView offset:5] centerYParent:0] sizeEq:leftlableSize.width+5 h:15];
    }
    [[levelView.layoutUpdate widthEq:levelw] install];
    [[[levelLabel.layoutUpdate toRightOf:levelImageView offset:5] centerYParent:0] install];
    
    
    
}

-(void)setModel:(GenericCoursesModel *)model
{
    _model=model;
    if(_model){
        [imageView loadUrl:_model.image placeholderImage:@"art-img"];
        [imageView scaleFillAspect];
        imageView.clipsToBounds=YES;
        titleLabel.text=_model.name;
        if (_model.authors && _model.authors.count>0) {
            if(_model.authors[0] && [_model.authors[0] isKindOfClass:[NSDictionary class]]){
                NSDictionary *authordic=_model.authors[0] ;
                authorLabel.text=[NSString stringWithFormat:@"%@",[authordic objectForKey:@"fullName"]];
            }
            
        }
        timerLabel.text=_model.timeRequired;
        NSString *pricestr=@"FREE";
        if (!_model.free) {
            pricestr=[NSString stringWithFormat:@"$%@",@(_model.price)];
        }
        priceLabel.text=pricestr;
        [self levelView:0];
        if(_isHideSponsor){
            [[gskBtn.layoutUpdate heightEq:0] install];
            
        }else{
            if (![NSString isBlankString:model.sponsoredId]) {
                CGFloat sponstorimgh=((50.0/375.0)*SCREENWIDTH);
                [[gskBtn.layoutUpdate heightEq:sponstorimgh] install];
            }else{
                [[gskBtn.layoutUpdate heightEq:0] install];
            }
        }
        
        
        [markButton setImage:[UIImage imageNamed:self.model.isBookmark?@"book9-light":@"book9"] forState:UIControlStateNormal];
        
//        NSLog(@"%@---%@",self.model.id,self.model.isBookmark?@"yes":@"no");
        
        [[lineLabel.layoutUpdate bottomOf:gskBtn offset:0] install];
    }
}

/**
 bookmark action
 @param sender uibutton
 */
-(void)markAction:(UIButton *)sender{
 
    
    if(self.model.isBookmark){
        [self.vc showLoading];
        [Proto lmsDelBookmarkByCourseId:self.model.id completed:^(BOOL success, NSString *msg) {
            [self.vc hideLoading];
            if(success){
                self.model.isBookmark = NO;
                [self->markButton setImage:[UIImage imageNamed:self.model.isBookmark?@"book9-light":@"book9"] forState:UIControlStateNormal];
                if(self.bookmarkStatusChanged){
                    self.bookmarkStatusChanged(self.model);
                }
            }else{
                [self.vc alertMsg:[NSString isBlankString:msg]?@"Failed to delete bookmark":msg onOK:nil];
            }
        }];
    }else{
        [self.vc showLoading];
        [Proto lmsAddBookmark:self.model.id completed:^(BOOL success, NSString *msg) {
            [self.vc hideLoading];
            if(success){
                self.model.isBookmark = YES;
                [self->markButton setImage:[UIImage imageNamed:self.model.isBookmark?@"book9-light":@"book9"] forState:UIControlStateNormal];
                if(self.bookmarkStatusChanged){
                    self.bookmarkStatusChanged(self.model);
                }
            }else{
                [self.vc alertMsg:[NSString isBlankString:msg]?@"Failed to add bookmark":msg onOK:nil];
            }
        }];
    }
    
    
    
}

/**
 sponsored action
 @param sender uibutton
  */
-(void)gskAction:(UIButton *)sender
{
    if (self.detegate && [self.detegate respondsToSelector:@selector(sponsoredAction:)]) {
        [self.detegate sponsoredAction:_indexPath];
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
