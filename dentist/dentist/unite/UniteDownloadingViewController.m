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
#import "SliderListView.h"
#import "DetinstDownloadManager.h"

@interface UniteDownloadingViewController (){
    UIImageView *coverImgView;
    UILabel *publishDateLabel;
    UILabel *volIssueLabel;
    UILabel *sizeLabel;
    UIButton *downloadingBtn;
    UIButton *downloadBtn;
    UIButton *cancelBtn;
    
    BOOL isShow;
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

    UIActivityIndicatorView *iv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    iv.tag = 998;
    iv.color = UIColor.blueColor;
    iv.backgroundColor = [UIColor clearColor];
    [downloadingBtn addSubview:iv];
    [[[[iv.layoutMaker leftParent:13] topParent:1] bottomParent:1] install];
    [iv startAnimating];
    [self downloadData];
//    [self loadData];
}

- (UIBarButtonItem *)menuButton {
    return [self navBarImage:@"menu" target:self action:@selector(rightBtnClick)];
}

- (void)rightBtnClick
{
    [[SliderListView sharedInstance:self.view isSearch:YES magazineId:self.magazineModel._id] showSliderView];
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
        [weakSelf.navigationController pushViewController:thumvc animated:YES];
    });
}

-(void)downloadData
{
    if(self.magazineModel.cover){
        [coverImgView loadUrl:self.magazineModel.cover placeholderImage:@"bg_1"];
    }
    publishDateLabel.text = [NSString timeWithTimeIntervalString:self.magazineModel.publishDate];
    volIssueLabel.text = [NSString stringWithFormat:@"%@ %@",self.magazineModel.vol?self.magazineModel.vol:@"", self.magazineModel.issue?self.magazineModel.issue:@""];
    
    sizeLabel.text = @"52 MB";
    
    downloadBtn.hidden = YES;
    downloadingBtn.hidden = NO;
    cancelBtn.hidden = NO;
    //添加几条模拟文章ID数据
    _magazineModel.articles=@[@"5bed09ec367a358ae0e74c39",@"5bed09ed367a358ae0e74c40",@"5bed09ee367a358ae0e74c47"];
    [[DetinstDownloadManager shareManager] startDownLoadUniteArticles:_magazineModel addCompletion:^(BOOL result) {
        
    } completed:^(BOOL result) {
        if(result){
            NSLog(@"===============下载成功===============");
            //查询下载的文章数据
            [[DentistDataBaseManager shareManager] queryUniteArticlesCachesList:self.magazineModel._id completed:^(NSArray<DetailModel *> * _Nonnull array) {
                if (array) {
                    
                }
                
            }];
           
            WeakSelf
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                ThumViewController *thumvc=[ThumViewController new];
                thumvc.uniteid=self->_magazineModel._id;
                [weakSelf.navigationController pushViewController:thumvc animated:YES];
            });
        }else{
            NSLog(@"===============下载失败===============");
        }
    }];
}



- (void)onBack:(UIButton *)btn {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
