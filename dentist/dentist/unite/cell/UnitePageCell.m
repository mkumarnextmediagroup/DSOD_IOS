//
//  UnitePageCell.m
//  dentist
//
//  Created by wanglibo on 2018/10/31.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "UnitePageCell.h"
#import "Common.h"
#define edge 15

#define RGBHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@implementation UnitePageCell{
    UIImageView *coverImgView;
    UILabel *publishDateLabel;
    UILabel *volIssueLabel;
    UIButton *optionBtn;
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        coverImgView = [UIImageView new];
        [self addSubview:coverImgView];
        [[[[[coverImgView.layoutMaker topParent:edge] leftParent:edge] rightParent:-edge] heightEq:520]install];
        
        optionBtn = [UIButton new];
        [optionBtn title:@"Download"];
        [optionBtn setTitleColor:RGBHex(0x879aa8) forState:UIControlStateNormal];
        [optionBtn.layer setBorderWidth:1.0];
        [optionBtn.layer setBorderColor:rgb255(221, 221, 221).CGColor];
        [optionBtn setBackgroundImage:colorImage(makeSize(1, 1), UIColor.whiteColor) forState:UIControlStateNormal];
        [optionBtn setBackgroundImage:colorImage(makeSize(1, 1), rgb255(221, 221, 221)) forState:UIControlStateHighlighted];
        [self addSubview:optionBtn];
        [[[[optionBtn.layoutMaker sizeEq:120 h:36] rightParent:-edge] below:coverImgView offset:edge]install];
        
        publishDateLabel = [UILabel new];
        publishDateLabel.font = [Fonts semiBold:12];
        [publishDateLabel textColorMain];// 4a4a4a
        [self addSubview:publishDateLabel];
        [[[[[publishDateLabel.layoutMaker below:coverImgView offset:edge]toLeftOf:optionBtn offset:-edge]leftParent:edge] heightEq:18]install];
       
        volIssueLabel = [UILabel new];
        volIssueLabel.font = [Fonts semiBold:12];
        [volIssueLabel textColorAlternate];// 9b
        [self addSubview:volIssueLabel];
        [[[[[volIssueLabel.layoutMaker below:publishDateLabel offset:0]toLeftOf:optionBtn offset:-edge]leftParent:edge] heightEq:18]install];

    }
    return self;
}

- (void)setMagazineModel:(MagazineModel *)magazineModel{
    magazineModel.cover = @"http://app800.cn/i/p.png";
    if(magazineModel.cover){
        [coverImgView loadUrl:magazineModel.cover placeholderImage:@"school"];
    }
    publishDateLabel.text = [NSString timeWithTimeIntervalString:magazineModel.publishDate];
    volIssueLabel.text = [NSString stringWithFormat:@"%@ %@",magazineModel.vol?magazineModel.vol:@"", magazineModel.issue?magazineModel.issue:@""];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:NO animated:animated];

}

@end
