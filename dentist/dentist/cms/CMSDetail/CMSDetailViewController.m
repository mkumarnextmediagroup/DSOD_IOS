//
//  CMSDetailViewController.m
//  dentist
//
//  Created by 孙兴国 on 2018/9/19.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "CMSDetailViewController.h"
#import "PlayerView.h"
#import "PicDetailView.h"
#import "Common.h"
#import "Proto.h"
#import "DiscussTableViewCell.h"
#import "XHStarRateView.h"
#import "GSKViewController.h"
#import "AddReviewViewController.h"
#import "ViewAllViewController.h"
#import "AppDelegate.h"
#import "DenActionSheet.h"
#import <Social/Social.h>
#import "DetailModel.h"
#import "DentistDataBaseManager.h"
#import "DetinstDownloadManager.h"
#import "UIViewController+myextend.h"
#import "BookmarkModel.h"
#import "dentist-Swift.h"
#import "DsoToast.h"

#define edge 15
@interface CMSDetailViewController ()<UITableViewDelegate,UITableViewDataSource,MyActionSheetDelegate> {
	PlayerView  *playView;
    PicDetailView *picDetailView;
    UITableView *myTable;
    UIButton *markButton;
    
    UILabel *titleLabel;
}
@end

@implementation CMSDetailViewController


-(void)viewDidLoad{
    [super viewDidLoad];
    [self createNav];
    [self loadData];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
   [self.navigationController setNavigationBarHidden:YES animated:YES];
}


-(void)loadData{
    [self showLoading];
    [[DentistDataBaseManager shareManager] queryDetailCmsCaches:self.contentId completed:^(DetailModel * _Nonnull model) {
        if (model) {
            self.articleInfo=model;
            foreTask(^() {
                if(self.articleInfo){
                    [self buildViews];
                    [self hideLoading];
                }
            });
        }
        backTask(^() {
            DetailModel *newmodel = [Proto queryForDetailPage:self.contentId];//5bdc1e7eb0f3e0701cef0253
            if (newmodel) {
                self.articleInfo=newmodel;
            }
            foreTask(^() {
                [self buildViews];
                [self hideLoading];
            });
            
        });
    }];
}


- (UIView *)headerView {
    UIView *headerVi = [UIView new];
    headerVi.backgroundColor = [UIColor whiteColor];
    
    UILabel *countLab = [headerVi addLabel];
    countLab.font = [Fonts semiBold:12];
    [countLab textColorMain];
    countLab.text = [NSString stringWithFormat:@"%@ Reviews",self.articleInfo.countOfComment?self.articleInfo.countOfComment:@"0"];
    [[[[countLab.layoutMaker leftParent:edge] topParent:20] sizeEq:200 h:20] install];
    
    XHStarRateView *star = [[XHStarRateView alloc] initWithFrame:CGRectMake(edge, 50, 92, 16)];
    star.isAnimation = YES;
    

    //server return  "OptionalDouble[1.5769230769230769]"
    NSString *avgCommentRatingString = self.articleInfo.avgCommentRating;
    avgCommentRatingString = [avgCommentRatingString stringByReplacingOccurrencesOfString:@"OptionalDouble["withString:@""];
    avgCommentRatingString = [avgCommentRatingString stringByReplacingOccurrencesOfString:@"]"withString:@""];
    avgCommentRatingString = [NSString stringWithFormat:@"%0.1f", [avgCommentRatingString floatValue]];


    star.currentScore = [avgCommentRatingString floatValue];
    star.userInteractionEnabled = NO;
    star.rateStyle = HalfStar;
    [headerVi addSubview:star];
    
    UILabel *starLab = [headerVi addLabel];
    starLab.font = [Fonts semiBold:12];
    [starLab textColorMain];
    starLab.text = avgCommentRatingString;
    [[[[starLab.layoutMaker toRightOf:star offset:10] topParent:47] sizeEq:100 h:20] install];
    
    UIButton *btn = [headerVi addButton];
    [btn setTitleColor:Colors.primary forState:UIControlStateNormal];
    [btn.titleLabel setFont:[Fonts semiBold:12]];
    [btn addTarget:self action:@selector(goToViewAllPage) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"View all" forState:UIControlStateNormal];
    [[[[btn.layoutMaker rightParent:-10] topParent:19] sizeEq:100 h:40] install];
    
    if (self.articleInfo.discussInfos.count>0) {
        UILabel *lineLabel = [headerVi lineLabel];
        [[[[[lineLabel.layoutMaker leftParent:0] rightParent:0] topParent:77] heightEq:1] install];
    }
    return headerVi;
}

- (void)goToViewAllPage {
    ViewAllViewController *viewAll = [ViewAllViewController new];
//    viewAll.discussInfo = self.articleInfo.discussInfos;
    viewAll.contentId = self.contentId;
    [self.navigationController pushViewController:viewAll animated:YES];
}

- (UIView *)footerView {
    UIView *footerVi = [UIView new];
    footerVi.backgroundColor = [UIColor whiteColor];
    
    UILabel *lineLabel = [footerVi lineLabel];
    lineLabel.backgroundColor = rgbHex(0xdddddd);
    [[[[[lineLabel.layoutMaker leftParent:edge] rightParent:0] topParent:0] heightEq:0.5] install];
    
    UILabel *lineLabel1 = [footerVi lineLabel];
    [[[[[lineLabel1.layoutMaker leftParent:0] rightParent:0] topParent:29] heightEq:1] install];

    UIButton *moreButton = [footerVi addButton];
    [moreButton setImage:[UIImage imageNamed:@"dot3.png"] forState:UIControlStateNormal];
    [[[[moreButton.layoutMaker rightParent:0] below:lineLabel1 offset:0] sizeEq:48 h:48] install];
    [moreButton addTarget:self action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [moreButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 15)];
    
    markButton = [footerVi addButton];
    if (_articleInfo.isBookmark) {
        [markButton setImage:[UIImage imageNamed:@"book9-light"] forState:UIControlStateNormal];
    }else{
        [markButton setImage:[UIImage imageNamed:@"book9"] forState:UIControlStateNormal];
    }
    [[[[markButton.layoutMaker toLeftOf:moreButton offset:0] below:lineLabel1 offset:0] sizeEq:48 h:48] install];
    [markButton addTarget:self action:@selector(markBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [markButton setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    
    UIButton *nextButton = [footerVi addButton];
    [nextButton setTitleColor:Colors.primary forState:UIControlStateNormal];
    [nextButton.titleLabel setFont:[Fonts semiBold:12]];
    [nextButton setTitle:@"Next" forState:UIControlStateNormal];
    [[[[nextButton.layoutMaker toLeftOf:markButton offset:-25] below:lineLabel1 offset:edge] sizeEq:80 h:20] install];
    [nextButton addTarget:self action:@selector(onClickDown:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *preButton = [footerVi addButton];
    [preButton setTitleColor:Colors.primary forState:UIControlStateNormal];
    [preButton.titleLabel setFont:[Fonts semiBold:12]];
    [preButton setTitle:@"Previous" forState:UIControlStateNormal];
    [[[[preButton.layoutMaker leftParent:edge] below:lineLabel1 offset:edge] sizeEq:80 h:20] install];
    [preButton addTarget:self action:@selector(onClickUp:) forControlEvents:UIControlEventTouchUpInside];
    preButton.hidden = ![self hasPre];
    nextButton.hidden = ![self hasNext];
    return footerVi;
}

- (void)createNav {
    UIView *topVi = [UIView new];
    topVi.backgroundColor = Colors.bgNavBarColor;
    [self.view addSubview:topVi];
    [[[[[topVi.layoutMaker leftParent:0] rightParent:0] topParent:0] heightEq:getRectNavAndStatusHight] install];
    titleLabel = [topVi addLabel];
    titleLabel.font = [Fonts semiBold:15];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [[[[titleLabel.layoutMaker leftParent:(SCREENWIDTH - 200)/2] bottomParent:-((getRectNavHight-40)/2)] sizeEq:200 h:40] install];
    
    UIButton *dismissBtn = [topVi addButton];
    [dismissBtn setImage:[UIImage imageNamed:@"back_arrow"] forState:UIControlStateNormal];
    [dismissBtn addTarget:self action:@selector(onBack:) forControlEvents:UIControlEventTouchUpInside];
    [[[[dismissBtn.layoutMaker leftParent:0] bottomParent:-((getRectNavHight-40)/2)] sizeEq:60 h:40] install];
    
    
    UIButton *nextBtn = [topVi addButton];
    [nextBtn setImage:[UIImage imageNamed:@"icon_arrow_down"] forState:UIControlStateNormal];
    [[[[nextBtn.layoutMaker leftParent:SCREENWIDTH - 90] bottomParent:-((getRectNavHight-40)/2)] sizeEq:40 h:40] install];
    [nextBtn addTarget:self action:@selector(onClickDown:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *preBtn = [topVi addButton];
    [preBtn setImage:[UIImage imageNamed:@"icon_arrow_up"] forState:UIControlStateNormal];
    [[[[preBtn.layoutMaker leftParent:SCREENWIDTH - 50] bottomParent:-((getRectNavHight-40)/2)] sizeEq:40 h:40] install];
    [preBtn addTarget:self action:@selector(onClickUp:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *line = [topVi lineLabel];
    [[[[line.layoutMaker topParent:getRectNavAndStatusHight - 1] leftParent:0] sizeEq:SCREENWIDTH h:1] install];
    
    
    preBtn.hidden = ![self hasPre];
    nextBtn.hidden = ![self hasNext];
}

- (void)onBack:(UIButton *)btn {
    [playView.sbPlayer stop];

    NSArray *viewcontrollers=self.navigationController.viewControllers;
    if(_goBackCloseAll || viewcontrollers.count == 1){
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)buildViews {
    if (!self.articleInfo) {  return; }
    NSDictionary *sponsorInfo = @{@"260":@"sponsor_align",
                                  @"259":@"sponsor_nobel",
                                  @"197":@"sponsor_gsk"};
    titleLabel.text = sponsorInfo[self.articleInfo.sponsorId] ? @"SPONSORED CONTENT" : @"";
    if(!picDetailView){
        picDetailView = [PicDetailView new];
        picDetailView.vc = self;
        [picDetailView.moreButton addTarget:self action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [picDetailView.markButton addTarget:self action:@selector(markBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [picDetailView.sponsorImageBtn addTarget:self action:@selector(gskBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [picDetailView.sponsorBtn addTarget:self action:@selector(gskBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [picDetailView.bgBtn addTarget:self action:@selector(gotoReview) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:picDetailView];
    }
    [picDetailView bind:self.articleInfo];
    [[[[picDetailView.layoutMaker leftParent:0] rightParent:0] topParent:0] install];
    [self.contentView.layoutUpdate.bottom.greaterThanOrEqualTo(picDetailView) install];

    if (!myTable) {
        myTable = [UITableView new];
        [self.contentView addSubview:myTable];
        myTable.dataSource = self;
        myTable.delegate = self;
        myTable.scrollEnabled = NO;
        myTable.separatorInset = UIEdgeInsetsMake(0, edge, 0, 0);
        myTable.separatorColor = rgbHex(0xdddddd);;
         [[[[[[myTable layoutMaker] leftParent:0] rightParent:0] below:picDetailView offset:0] sizeEq:SCREENWIDTH h:500] install];
    }
    if (_articleInfo.isBookmark) {
        [markButton setImage:[UIImage imageNamed:@"book9-light"] forState:UIControlStateNormal];
    }else{
        [markButton setImage:[UIImage imageNamed:@"book9"] forState:UIControlStateNormal];
    }
    [[myTable.layoutUpdate heightEq:self.articleInfo.discussInfos.count * 110 + 150] install];
    [myTable reloadData];
    [self.contentView.layoutUpdate.bottom.greaterThanOrEqualTo(myTable) install];
}

//click more button
- (void)moreBtnClick:(UIButton *)btn
{
    NSArray *imgArr = [NSArray arrayWithObjects:@"downLoadIcon",@"shareIcon", nil];
    DenActionSheet *denSheet = [[DenActionSheet alloc] initWithDelegate:self title:nil cancelButton:nil imageArr:imgArr otherTitle:@"Download",@"Share", nil];
    [denSheet show:self.view];
    
}

- (void)markBtnClick:(UIButton *)btn {
    if(_articleInfo.isBookmark){
        //删除
        UIView *dsontoastview=[DsoToast toastViewForMessage:@"Remove from bookmarks……" ishowActivity:YES];
        [self.navigationController.view showToast:dsontoastview duration:30.0 position:CSToastPositionBottom completion:nil];
        [Proto deleteBookmarkByEmailAndContentId:getLastAccount() contentId:_articleInfo.id completed:^(HttpResult *result) {
            foreTask(^() {
                [self.navigationController.view hideToast];
                if (result.OK) {
                    //
                    self.articleInfo.isBookmark=NO;
                    [self->playView.markButton setImage:[UIImage imageNamed:@"book9"] forState:UIControlStateNormal];
                    [self->picDetailView.markButton setImage:[UIImage imageNamed:@"book9"] forState:UIControlStateNormal];
                    [self->markButton setImage:[UIImage imageNamed:@"book9"] forState:UIControlStateNormal];
                }else{
                    NSString *message=result.msg;
                    if([NSString isBlankString:message]){
                        message=@"Failed";
                    }
                    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
                    [window makeToast:message
                             duration:1.0
                             position:CSToastPositionBottom];
                    [self.navigationController popViewControllerAnimated:YES];
                }
            });
        }];
    }else{
        //添加
        CMSModel *newmodel=[[CMSModel alloc] init];
        newmodel.id=_articleInfo.id;
        newmodel.title=_articleInfo.title;
        newmodel.featuredMediaId=_articleInfo.featuredMediaId;
        newmodel.categoryId=_articleInfo.categoryId;
        newmodel.categoryName=_articleInfo.categoryName;
        newmodel.contentTypeId=_articleInfo.contentTypeId;
        newmodel.contentTypeName=_articleInfo.contentTypeName;
        newmodel.featuredMedia=_articleInfo.featuredMedia;
        UIView *dsontoastview=[DsoToast toastViewForMessage:@"Saving to bookmarks…" ishowActivity:YES];
        [self.navigationController.view showToast:dsontoastview duration:30.0 position:CSToastPositionBottom completion:nil];
        [Proto addBookmark:getLastAccount() cmsmodel:newmodel completed:^(HttpResult *result) {
            foreTask(^() {
                [self.navigationController.view hideToast];
                
                if (result.OK) {
                    //
                    self.articleInfo.isBookmark=YES;
                    [self->playView.markButton setImage:[UIImage imageNamed:@"book9-light"] forState:UIControlStateNormal];
                    [self->picDetailView.markButton setImage:[UIImage imageNamed:@"book9-light"] forState:UIControlStateNormal];
                    [self->markButton setImage:[UIImage imageNamed:@"book9-light"] forState:UIControlStateNormal];
                }else{
                    if(result.code==2033){
                        self.articleInfo.isBookmark=YES;
                        [self->playView.markButton setImage:[UIImage imageNamed:@"book9-light"] forState:UIControlStateNormal];
                        [self->picDetailView.markButton setImage:[UIImage imageNamed:@"book9-light"] forState:UIControlStateNormal];
                        [self->markButton setImage:[UIImage imageNamed:@"book9-light"] forState:UIControlStateNormal];
                    }else{
                        NSString *message=result.msg;
                        if([NSString isBlankString:message]){
                            message=@"Failed";
                        }
                        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
                        [window makeToast:message
                                 duration:1.0
                                 position:CSToastPositionBottom];
                        [self.navigationController popViewControllerAnimated:YES];
                    }
                    
                }
            });
        }];
    }
}

- (void)gotoReview {
    AddReviewViewController *reviewVC = [AddReviewViewController new];
    reviewVC.contentId = self.contentId;
    WeakSelf
    reviewVC.addReviewSuccessCallbak = ^(){
        [weakSelf loadData];
    };
    [self.navigationController pushViewController:reviewVC animated:YES];
}

//GSK btn click and go to the GSK list page
- (void)gskBtnClick {
    GSKViewController *gskVC = [GSKViewController new];
    gskVC.author = [NSString stringWithFormat:@"%@ %@",_articleInfo.author.firstName,_articleInfo.author.lastName];
    gskVC.sponsorId=self.articleInfo.sponsorId;
    [self.navigationController pushViewController:gskVC animated:YES];
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return self.footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 78;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 75;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.articleInfo.discussInfos.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIden = @"cell";
    DiscussTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIden];
    if (cell == nil) {
        cell = [[DiscussTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIden];
    }
    
    cell.disInfo = self.articleInfo.discussInfos[indexPath.row];
    return cell;

}

-(void)showTipView:(NSString *)msg
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:msg preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"点击取消");
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}




- (BOOL)hasPre{
    return self.cmsmodelsArray && self.cmsmodelsArray.count > 0 && self.modelIndexOfArray > 0;
}

- (BOOL)hasNext{
    return self.cmsmodelsArray && self.cmsmodelsArray.count > 0 && self.modelIndexOfArray < self.cmsmodelsArray.count - 1;
}

- (void)onClickUp:(UIButton *)btn {
	NSLog(@"clickup");
    if([self hasPre]){
        int index = self.modelIndexOfArray-1;
        [self openNewCmsDetail:[self modelIdOfIndex:index] index:index withAnimation:kCATransitionFromBottom];
    }else{
         [self showTipView:@"is the first page"];
    }
}

- (void)onClickDown:(UIButton *)btn {
	NSLog(@"onClickDown");
    if([self hasNext]){
        int index = self.modelIndexOfArray+1;
        [self openNewCmsDetail:[self modelIdOfIndex:index] index:index withAnimation:kCATransitionFromTop];
    }else{
        [self showTipView:@"is the last page"];
    }
}

-(NSString*)modelIdOfIndex:(int)index{
    NSString *modelId = nil;
    id model = self.cmsmodelsArray[index];
    if ([model isKindOfClass:[CMSModel class]]) {
        modelId = ((CMSModel *)model).id;
    }else if ([model isKindOfClass:[BookmarkModel class]]) {
        modelId = ((BookmarkModel *)model).postId;
    }
    return modelId;
}


- (void)openNewCmsDetail:(NSString*)contentId index:(int)index withAnimation:(CATransitionSubtype)subtype{
    if([NSString isBlankString:contentId]){
        return;
    }
    
    CMSDetailViewController *cmsDetialVC = [CMSDetailViewController new];
    cmsDetialVC.contentId = contentId;
    cmsDetialVC.cmsmodelsArray = self.cmsmodelsArray;
    cmsDetialVC.modelIndexOfArray = index;
    cmsDetialVC.goBackCloseAll = YES;
    
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionPush;
    animation.duration =0.5f;
    animation.subtype =subtype;
    [[UIApplication sharedApplication].keyWindow.layer addAnimation:animation forKey:nil];
    [self.navigationController pushViewController:cmsDetialVC animated:NO];
}

#pragma mark ---MyActionSheetDelegate
- (void)myActionSheet:(DenActionSheet *)actionSheet parentView:(UIView *)parentView subLabel:(UILabel *)subLabel index:(NSInteger)index
{
    switch (index) {
        case 0://---click the Download button
        {
            NSLog(@"download click");
            //添加
            if (_articleInfo) {
                CMSModel *newmodel=[[CMSModel alloc] init];
                newmodel.id=_articleInfo.id;
                newmodel.title=_articleInfo.title;
                newmodel.featuredMediaId=_articleInfo.featuredMediaId;
                newmodel.categoryId=_articleInfo.categoryId;
                newmodel.categoryName=_articleInfo.categoryName;
                newmodel.contentTypeId=_articleInfo.contentTypeId;
                newmodel.contentTypeName=_articleInfo.contentTypeName;
                newmodel.featuredMedia=_articleInfo.featuredMedia;
                UIView *dsontoastview=[DsoToast toastViewForMessage:@"Download is Add…" ishowActivity:YES];
                [self.navigationController.view showToast:dsontoastview duration:1.0 position:CSToastPositionBottom completion:nil];
                [[DetinstDownloadManager shareManager] startDownLoadCMSModel:newmodel addCompletion:^(BOOL result) {
                } completed:^(BOOL result) {}];
            }
            
        }
            break;
        case 1://---click the Share button
        {
            NSLog(@"Share click");
            if (_articleInfo) {
                NSString *urlstr=@"";
                NSString *title=[NSString stringWithFormat:@"%@",_articleInfo.title];
                NSString* type = _articleInfo.featuredMedia[@"type"];
                if([type isEqualToString:@"1"] ){
                    //pic
                    NSDictionary *codeDic = _articleInfo.featuredMedia[@"code"];
                    urlstr = codeDic[@"thumbnailUrl"];
                }else{
                    urlstr = _articleInfo.featuredMedia[@"code"];
                }
                NSString *someid=_articleInfo.id;
                if (![NSString isBlankString:urlstr]) {
                    dispatch_async(dispatch_get_global_queue(0, 0), ^{
                        NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlstr]];
                        UIImage *image = [UIImage imageWithData:data];
                        if (image) {
                            NSURL *shareurl = [NSURL URLWithString:getShareUrl(@"content", someid)];
                            NSArray *activityItems = @[shareurl,title,image];
                            
                            UIActivityViewController *avc = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];
                            [self presentViewController:avc animated:YES completion:nil];
                        }
                    });
                }else{
                    NSURL *shareurl = [NSURL URLWithString:getShareUrl(@"content", someid)];
                    NSArray *activityItems = @[shareurl,title];
                    
                    UIActivityViewController *avc = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];
                    [self presentViewController:avc animated:YES completion:nil];
                }
                
            }else{
                NSString *msg=@"";
                msg=@"error";
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:msg preferredStyle:UIAlertControllerStyleAlert];
                
                [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                    NSLog(@"点击取消");
                }]];
                [self presentViewController:alertController animated:YES completion:nil];
            }
        }
            break;
        default:
            break;
    }
}

- (void)dealloc {
    if (picDetailView){
        [picDetailView timerInvalidate];
    }
}

@end
