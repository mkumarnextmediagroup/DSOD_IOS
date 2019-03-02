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
    UIButton *gskBtn;
    UILabel *lineLabel;
    UIButton *startBtn;
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
//        [gskBtn addTarget:self action:@selector(gskAction:) forControlEvents:UIControlEventTouchUpInside];
        [[[[[gskBtn.layoutMaker leftParent:0] rightParent:0] bottomParent:0] heightEq:sponstorimgh] install];
        
        imageView = self.addImageView;
        [[[[[imageView.layoutMaker leftParent:edge] topParent:edge] above:gskBtn offset:-10] sizeEq:88 h:117] install];
        
        titleLabel = [self topShowLabel];
        titleLabel.font = [Fonts semiBold:14];
        titleLabel.textColor=Colors.textMain;
        titleLabel.numberOfLines=2;
        [[[[titleLabel.layoutMaker toRightOf:imageView offset:edge] topOf:imageView offset:0] rightParent:-edge] install];
        startBtn = [self addButton];
        [[[[[gskBtn.layoutMaker leftParent:0] rightParent:0] bottomParent:0] heightEq:sponstorimgh] install];
        
        authorLabel=[self addLabel];
        authorLabel.textColor=Colors.textMain;
        authorLabel.font=[UIFont systemFontOfSize:12];
//        [[[[authorLabel.layoutMaker toRightOf:imageView offset:edge] above:starview offset:-10] sizeEq:160 h:15] install];
        
        
        lineLabel=self.lineLabel;
        [[[[[lineLabel.layoutMaker leftParent:0] rightParent:0] bottomParent:0] heightEq:1] install];
        
        
    }
    return self;
}

-(void)setIsHideSponsor:(BOOL)isHideSponsor
{
    _isHideSponsor=isHideSponsor;
    if(_isHideSponsor){
        [[gskBtn.layoutUpdate heightEq:0] install];
        
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
