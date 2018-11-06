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
        [coverImgView setContentMode:UIViewContentModeScaleAspectFill];
        coverImgView.clipsToBounds = YES;
        [self addSubview:coverImgView];
        [[[[[coverImgView.layoutMaker topParent:edge] leftParent:edge] rightParent:-edge] heightEq:SCREENWIDTH*5/4]install];
        
        
        optionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self optionBtnReadStyle];
        [self addSubview:optionBtn];
        [[[[optionBtn.layoutMaker sizeEq:120 h:36] rightParent:-edge] below:coverImgView offset:edge]install];
        [optionBtn addTarget:self action:@selector(optionBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        
        publishDateLabel = [UILabel new];
        publishDateLabel.font = [UIFont systemFontOfSize:12];
        [publishDateLabel textColorMain];// 4a4a4a
        [self addSubview:publishDateLabel];
        [[[[[publishDateLabel.layoutMaker below:coverImgView offset:edge]toLeftOf:optionBtn offset:-edge]leftParent:edge] heightEq:18]install];
       
        volIssueLabel = [UILabel new];
        volIssueLabel.font = [UIFont systemFontOfSize:12];
        [volIssueLabel textColorAlternate];// 9b
        [self addSubview:volIssueLabel];
        [[[[[volIssueLabel.layoutMaker below:publishDateLabel offset:0]toLeftOf:optionBtn offset:-edge]leftParent:edge] heightEq:18]install];

    }
    return self;
}

- (void)setMagazineModel:(MagazineModel *)magazineModel{
    _magazineModel = magazineModel;
    
    magazineModel.cover = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1542037826&di=64e2e24bf769d5c2b71d7372a0515d7d&imgtype=jpg&er=1&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimage%2Fc0%253Dshijue1%252C0%252C0%252C294%252C40%2Fsign%3Dec50dee888025aafc73f76889384c111%2Fa50f4bfbfbedab643e0cd5e8fd36afc379311e9f.jpg";
    if(magazineModel.cover){
        [coverImgView loadUrl:magazineModel.cover placeholderImage:@"bg_1"];
    }
    coverImgView.contentMode=UIViewContentModeScaleAspectFill;
    coverImgView.clipsToBounds=YES;
    publishDateLabel.text = [NSString timeWithTimeIntervalString:magazineModel.publishDate];
    volIssueLabel.text = [NSString stringWithFormat:@"%@ %@",magazineModel.vol?magazineModel.vol:@"", magazineModel.issue?magazineModel.issue:@""];
    
    
    switch ([self getUnitePageDownloadStatus]) {
        case UPageNoDownload:
            [self optionBtnDownloadStyle];
            break;
        case UPageDownloading:
            [self optionBtnDownloadingStyle];
            break;
        case UPageDownloaded:
            [self optionBtnReadStyle];
            break;
    }
    
}

-(void)optionBtnDownloadStyle{
    [optionBtn.layer setBorderWidth:1.0];
    optionBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [optionBtn title:@"Download"];
    [optionBtn setTitleColor:rgbHex(0x4A4A4A) forState:UIControlStateNormal];
    [optionBtn.layer setBorderColor:rgb255(221, 221, 221).CGColor];
    [optionBtn setBackgroundImage:colorImage(makeSize(1, 1), rgbHex(0xffffff)) forState:UIControlStateNormal];
    [optionBtn setBackgroundImage:colorImage(makeSize(1, 1), rgbHex(0xdddddd)) forState:UIControlStateHighlighted];
}

-(void)optionBtnDownloadingStyle{
    [optionBtn.layer setBorderWidth:1.0];
    optionBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [optionBtn title:@"Download"];
    [optionBtn setTitleColor:rgbHex(0x4A4A4A) forState:UIControlStateNormal];
    [optionBtn.layer setBorderColor:rgb255(221, 221, 221).CGColor];
    [optionBtn setBackgroundImage:colorImage(makeSize(1, 1), rgbHex(0xffffff)) forState:UIControlStateNormal];
    [optionBtn setBackgroundImage:colorImage(makeSize(1, 1), rgbHex(0xdddddd)) forState:UIControlStateHighlighted];
}

-(void)optionBtnReadStyle{
    [optionBtn.layer setBorderWidth:0.0];
    optionBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [optionBtn title:@"Read"];
    [optionBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [optionBtn.layer setBorderColor:rgb255(221, 221, 221).CGColor];
    [optionBtn setBackgroundImage:colorImage(makeSize(1, 1), rgbHex(0x879AA8)) forState:UIControlStateNormal];
    [optionBtn setBackgroundImage:colorImage(makeSize(1, 1), rgbHex(0x627888)) forState:UIControlStateHighlighted];
}

-(UnitePageDownloadStatus)getUnitePageDownloadStatus{
    //TODO state of judgment
    //        5bd7ff462676fdc2e88b5496  5bd800192676fdc2e88b5498
    if([_magazineModel._id isEqualToString:@"5bd7ff462676fdc2e88b5496"]
       || [_magazineModel._id isEqualToString:@"5bd800192676fdc2e88b5498"]){
        return UPageDownloaded;
    }
    
    
    return UPageNoDownload;
}

-(void)optionBtnAction:(UIButton *)sender{
    if(self.optonBtnOnClickListener){
        self.optonBtnOnClickListener([self getUnitePageDownloadStatus], self.magazineModel);
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:NO animated:animated];

}

@end
