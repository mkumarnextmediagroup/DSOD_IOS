//
//  UniteDownloadingViewController.m
//  dentist
//
//  Created by wanglibo on 2018/11/2.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "UniteDownloadingViewController.h"
#import "common.h"
#import "SliderListViewController.h"
#import "IIViewDeckController.h"
#import "AppDelegate.h"
#import "dentist-Swift.h"

@interface UniteDownloadingViewController (){
    UIImageView *coverImgView;
    UILabel *publishDateLabel;
    UILabel *volIssueLabel;
    UILabel *sizeLabel;
    UIButton *downloadingBtn;
    UIButton *downloadBtn;
    UIButton *cancelBtn;
}

@end

@implementation UniteDownloadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = NO;
    UINavigationItem *item = self.navigationItem;
    item.title = @"";
    item.leftBarButtonItem = [self navBarBack:self action:@selector(onBack:)];
    item.rightBarButtonItem = [self menuButton];
//    UIScrollView *contentView = [UIScrollView new];
//    contentView.backgroundColor = UIColor.redColor;
//    contentView.contentSize =  CGSizeMake(self.view.frame.size.width, self.view.frame.size.height * 2);
//
//
//    [contentView.layoutMaker ]
    
    UIView *contentView = [UIView new];
    contentView.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:contentView];
    [[[contentView.layoutMaker topParent:NAVHEIGHT] sizeEq:SCREENWIDTH h:SCREENHEIGHT -NAVHEIGHT ]install];
    
    
    coverImgView = [UIImageView new];
    [coverImgView setContentMode:UIViewContentModeScaleAspectFill];
    coverImgView.clipsToBounds = YES;
    [contentView addSubview:coverImgView];
    [[[[[coverImgView.layoutMaker topParent:15] leftParent:15] rightParent:-15] heightEq:SCREENWIDTH*6/5]install];
    
    publishDateLabel = [UILabel new];
    publishDateLabel.font = [UIFont systemFontOfSize:15];
    [publishDateLabel textColorMain];    [contentView addSubview:publishDateLabel];
    [[[publishDateLabel.layoutMaker below:coverImgView offset:10] centerXParent:0]install];

    
    volIssueLabel = [UILabel new];
    volIssueLabel.font = [UIFont systemFontOfSize:15];
    [volIssueLabel textColorMain];
    [contentView addSubview:volIssueLabel];
    [[[volIssueLabel.layoutMaker below:publishDateLabel offset:0] centerXParent:0]install];
    
    sizeLabel = [UILabel new];
    sizeLabel.font = [UIFont systemFontOfSize:12];
    [sizeLabel textColorAlternate];
    [contentView addSubview:sizeLabel];
    [[[sizeLabel.layoutMaker below:volIssueLabel offset:5] centerXParent:0]install];
    
    
    downloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [downloadBtn.layer setBorderWidth:1.0];
    downloadBtn.titleLabel.font =[UIFont systemFontOfSize:14];
    [downloadBtn title:@"Download"];
    [downloadBtn setTitleColor:rgbHex(0x4a4a4a) forState:UIControlStateNormal];
    [downloadBtn.layer setBorderColor:rgb255(221, 221, 221).CGColor];
    [downloadBtn setBackgroundImage:colorImage(makeSize(1, 1), rgbHex(0xffffff)) forState:UIControlStateNormal];
    [downloadBtn setBackgroundImage:colorImage(makeSize(1, 1), rgbHex(0xdddddd)) forState:UIControlStateHighlighted];
    [contentView addSubview:downloadBtn];
    [[[[downloadBtn.layoutMaker sizeEq:120 h:36] below:sizeLabel offset:15] centerXParent:0 ]install];
    [downloadBtn addTarget:self action:@selector(downloadBtnAction) forControlEvents:UIControlEventTouchUpInside];

    downloadingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [downloadingBtn.layer setBorderWidth:1.0];
    downloadingBtn.titleLabel.font =[UIFont systemFontOfSize:14];
    [downloadingBtn title:@"Downloading..."];
    [downloadingBtn setTitleColor:rgbHex(0x4a4a4a) forState:UIControlStateNormal];
    [downloadingBtn.layer setBorderColor:rgb255(221, 221, 221).CGColor];
    [downloadingBtn setBackgroundImage:colorImage(makeSize(1, 1), rgbHex(0xffffff)) forState:UIControlStateNormal];
    [downloadingBtn setBackgroundImage:colorImage(makeSize(1, 1), rgbHex(0xdddddd)) forState:UIControlStateHighlighted];
    [contentView addSubview:downloadingBtn];
    [[[[downloadingBtn.layoutMaker sizeEq:180 h:36] below:sizeLabel offset:15] centerXParent:-60]  install];
    [downloadingBtn addTarget:self action:@selector(downloadingBtnAction) forControlEvents:UIControlEventTouchUpInside];

    
    cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn.layer setBorderWidth:1.0];
    cancelBtn.titleLabel.font =[UIFont systemFontOfSize:14];
    [cancelBtn title:@"Cancel"];
    [cancelBtn setTitleColor:rgbHex(0x4a4a4a) forState:UIControlStateNormal];
    [cancelBtn.layer setBorderColor:rgb255(221, 221, 221).CGColor];
    [cancelBtn setBackgroundImage:colorImage(makeSize(1, 1), rgbHex(0xffffff)) forState:UIControlStateNormal];
    [cancelBtn setBackgroundImage:colorImage(makeSize(1, 1), rgbHex(0xdddddd)) forState:UIControlStateHighlighted];
    [contentView addSubview:cancelBtn];
    [[[[cancelBtn.layoutMaker sizeEq:100 h:36] below:sizeLabel offset:15]centerXParent:90 ]install];
    [cancelBtn addTarget:self action:@selector(cancelBtnAction) forControlEvents:UIControlEventTouchUpInside];

   
    [self loadData];
}

- (UIBarButtonItem *)menuButton {
    return [self navBarImage:@"menu" target:[AppDelegate instance] action:@selector(onOpenMenuAnoSide:)];
}

-(void)downloadBtnAction{
    downloadBtn.hidden = YES;
    downloadingBtn.hidden = NO;
    cancelBtn.hidden = NO;
}
-(void)downloadingBtnAction{
    
}
-(void)cancelBtnAction{
//    downloadBtn.hidden = NO;
//    downloadingBtn.hidden = YES;
//    cancelBtn.hidden = YES;
    
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)loadData{

    if(self.magazineModel.cover){
        [coverImgView loadUrl:self.magazineModel.cover placeholderImage:@"bg_1"];
    }
    publishDateLabel.text = [NSString timeWithTimeIntervalString:self.magazineModel.publishDate];
    volIssueLabel.text = [NSString stringWithFormat:@"%@ %@",self.magazineModel.vol?self.magazineModel.vol:@"", self.magazineModel.issue?self.magazineModel.issue:@""];

    sizeLabel.text = @"52 MB";
    
    downloadBtn.hidden = YES;
    downloadingBtn.hidden = NO;
    cancelBtn.hidden = NO;
    
    WeakSelf
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        ThumViewController *thumvc=[ThumViewController new];
        thumvc.modelarr=weakSelf.datas;
        [weakSelf.navigationController pushViewController:thumvc animated:YES];
    });

}



- (void)onBack:(UIButton *)btn {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
