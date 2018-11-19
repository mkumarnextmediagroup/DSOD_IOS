//
//  UnitePageCell.m
//  dentist
//
//  Created by wanglibo on 2018/10/31.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "UnitePageCell.h"
#import "Common.h"
#import "DentistDataBaseManager.h"
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
    
    if(magazineModel.cover){
        [coverImgView loadUrl:magazineModel.cover placeholderImage:@"bg_1"];
    }
    coverImgView.contentMode=UIViewContentModeScaleAspectFill;
    coverImgView.clipsToBounds=YES;
    publishDateLabel.text = [NSDate USDateShortFormatWithStringTimestamp:magazineModel.publishDate];
    volIssueLabel.text = [NSString stringWithFormat:@"%@ %@",magazineModel.vol?magazineModel.vol:@"", magazineModel.issue?magazineModel.issue:@""];
    
    [self optionBtnDownloadStyle];
    
    [[DentistDataBaseManager shareManager] checkUniteStatus:magazineModel._id completed:^(NSInteger result) {
        NSLog(@"======下载状态=%@",@(result));
        foreTask(^{
            switch (result) {
                case 0:
                    [self optionBtnDownloadStyle];
                    break;
                case 1:
                    [self optionBtnDownloadingStyle];
                    break;
                case 2:
                    [self optionBtnReadStyle];
                    break;
            }
        });
        
    }];
//    switch ([self getUnitePageDownloadStatus]) {
//        case UPageNoDownload:
//            [self optionBtnDownloadStyle];
//            break;
//        case UPageDownloading:
//            [self optionBtnDownloadingStyle];
//            break;
//        case UPageDownloaded:
//            [self optionBtnReadStyle];
//            break;
//    }
    
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
    //TODO False data
    if([_magazineModel._id isEqualToString:@"5bd7ff462676fdc2e88b5496"]
       || [_magazineModel._id isEqualToString:@"5bd800192676fdc2e88b5498"]){
        return UPageDownloaded;
    }
    
    
    return UPageNoDownload;
}

-(void)optionBtnAction:(UIButton *)sender{
//    if(self.optonBtnOnClickListener){
//        self.optonBtnOnClickListener([self getUnitePageDownloadStatus], self.magazineModel);
//    }
    if (_magazineModel) {
        [[DentistDataBaseManager shareManager] checkUniteStatus:self->_magazineModel._id completed:^(NSInteger result) {
            NSLog(@"======下载状态=%@",@(result));
            foreTask(^{
                if (self.optonBtnOnClickDownload) {
                    self.optonBtnOnClickDownload(result, self->_magazineModel);
                }
            });
            
        }];
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
