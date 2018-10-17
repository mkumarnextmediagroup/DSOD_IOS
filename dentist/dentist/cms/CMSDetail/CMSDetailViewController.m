//
//  CMSDetailViewController.m
//  dentist
//
//  Created by 孙兴国 on 2018/9/19.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "CMSDetailViewController.h"
#import "PlayerView.h"
#import "Common.h"
#import "Proto.h"
#import "DiscussTableViewCell.h"
#import "XHStarRateView.h"
#import "GSKViewController.h"
#import "AddReviewViewController.h"
#import "ViewAllViewController.h"
#import "AppDelegate.h"

#define edge 15
@interface CMSDetailViewController ()<UITableViewDelegate,UITableViewDataSource> {
	PlayerView  *playView;
    UITableView *myTable;
}
@end

@implementation CMSDetailViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;

    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    delegate.supportRatate = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    delegate.supportRatate = NO;
}

- (void)viewDidLoad {
	[super viewDidLoad];
    [self createNav];
    
	[self buildViews];
}

- (UIView *)headerView
{
    UIView *headerVi = [UIView new];
    headerVi.backgroundColor = [UIColor whiteColor];
    
    UILabel *countLab = [headerVi addLabel];
    countLab.font = [Fonts semiBold:12];
    [countLab textColorMain];
    countLab.text = @"40,543 Reviews";
    [[[[countLab.layoutMaker leftParent:edge] topParent:20] sizeEq:200 h:20] install];
    
    XHStarRateView *star = [[XHStarRateView alloc] initWithFrame:CGRectMake(edge, 50, 92, 16)];
    star.isAnimation = YES;
    star.currentScore = 4.5;
    star.userInteractionEnabled = NO;
    star.rateStyle = HalfStar;
    [headerVi addSubview:star];
    
    UILabel *starLab = [headerVi addLabel];
    starLab.font = [Fonts semiBold:12];
    [starLab textColorMain];
    starLab.text = @"4.5";
    [[[[starLab.layoutMaker toRightOf:star offset:10] topParent:47] sizeEq:100 h:20] install];
    
    UIButton *btn = [headerVi addButton];
    [btn setTitleColor:Colors.primary forState:UIControlStateNormal];
    [btn.titleLabel setFont:[Fonts semiBold:12]];
    [btn addTarget:self action:@selector(goToViewAllPage) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"View all" forState:UIControlStateNormal];
    [[[[btn.layoutMaker rightParent:-10] topParent:19] sizeEq:100 h:40] install];
    
    UILabel *lineLabel = [headerVi lineLabel];
    [[[[[lineLabel.layoutMaker leftParent:0] rightParent:0] topParent:77] heightEq:1] install];
    return headerVi;
}

- (void)goToViewAllPage
{
    ViewAllViewController *viewAll = [ViewAllViewController new];
    viewAll.discussInfo = self.articleInfo.discussInfo;
    [self.navigationController pushViewController:viewAll animated:YES];
}

- (UIView *)footerView
{
    UIView *footerVi = [UIView new];
    footerVi.backgroundColor = [UIColor whiteColor];
    
    UILabel *lineLabel = [footerVi lineLabel];
    [[[[[lineLabel.layoutMaker leftParent:edge] rightParent:0] topParent:0] heightEq:1] install];
    
    UILabel *lineLabel1 = [footerVi lineLabel];
    [[[[[lineLabel1.layoutMaker leftParent:0] rightParent:0] topParent:29] heightEq:1] install];

    UIButton *moreButton = [footerVi addButton];
    [moreButton setImage:[UIImage imageNamed:@"dot3.png"] forState:UIControlStateNormal];
    [[[[moreButton.layoutMaker rightParent:-edge] below:lineLabel1 offset:edge] sizeEq:20 h:20] install];
    
    UIButton *markButton = [footerVi addButton];
    [markButton setImage:[UIImage imageNamed:@"book9"] forState:UIControlStateNormal];
    [[[[markButton.layoutMaker toLeftOf:moreButton offset:-15] below:lineLabel1 offset:edge] sizeEq:20 h:20] install];
    
    UIButton *nextButton = [footerVi addButton];
    [nextButton setTitleColor:Colors.primary forState:UIControlStateNormal];
    [nextButton.titleLabel setFont:[Fonts semiBold:12]];
    [nextButton setTitle:@"Next" forState:UIControlStateNormal];
    [[[[nextButton.layoutMaker toLeftOf:markButton offset:-25] below:lineLabel1 offset:edge] sizeEq:80 h:20] install];
    
    UIButton *preButton = [footerVi addButton];
    [preButton setTitleColor:Colors.primary forState:UIControlStateNormal];
    [preButton.titleLabel setFont:[Fonts semiBold:12]];
    [preButton setTitle:@"Previous" forState:UIControlStateNormal];
    [[[[preButton.layoutMaker leftParent:edge] below:lineLabel1 offset:edge] sizeEq:80 h:20] install];
    
    return footerVi;
}

- (void)createNav
{
    UIView *topVi = [UIView new];
    topVi.backgroundColor = Colors.bgNavBarColor;
    [self.view addSubview:topVi];
    [[[[[topVi.layoutMaker leftParent:0] rightParent:0] topParent:0] heightEq:NAVHEIGHT] install];
    
    UILabel *content = [topVi addLabel];
    content.font = [Fonts semiBold:15];
    content.textColor = [UIColor whiteColor];
    content.text = @"SPONSORED CONTENT";
    content.textAlignment = NSTextAlignmentCenter;
    [[[[content.layoutMaker leftParent:(SCREENWIDTH - 200)/2] topParent:23+NAVHEIGHT_OFFSET] sizeEq:200 h:40] install];
    
    UIButton *dismissBtn = [topVi addButton];
    [dismissBtn setImage:[UIImage imageNamed:@"back_arrow"] forState:UIControlStateNormal];
    [dismissBtn addTarget:self action:@selector(onBack:) forControlEvents:UIControlEventTouchUpInside];
    [[[[dismissBtn.layoutMaker leftParent:0] topParent:24+NAVHEIGHT_OFFSET] sizeEq:60 h:40] install];
    
    
    UIButton *nextBtn = [topVi addButton];
    [nextBtn setImage:[UIImage imageNamed:@"arrow_down"] forState:UIControlStateNormal];
    [[[[nextBtn.layoutMaker leftParent:SCREENWIDTH - 80] topParent:24+NAVHEIGHT_OFFSET] sizeEq:40 h:40] install];
    [nextBtn addTarget:self action:@selector(onClickDown:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *preBtn = [topVi addButton];
    [preBtn setImage:[UIImage imageNamed:@"arrow_up"] forState:UIControlStateNormal];
    [[[[preBtn.layoutMaker leftParent:SCREENWIDTH - 40] topParent:24+NAVHEIGHT_OFFSET] sizeEq:40 h:40] install];
    [preBtn addTarget:self action:@selector(onClickUp:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *line = [topVi lineLabel];
    [[[[line.layoutMaker topParent:NAVHEIGHT - 1] leftParent:0] sizeEq:SCREENWIDTH h:1] install];
}

- (void)onBack:(UIButton *)btn {
    [playView.sbPlayer stop];
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)buildViews {
	playView = [PlayerView new];
    [playView.bgBtn addTarget:self action:@selector(gotoReview) forControlEvents:UIControlEventTouchUpInside];
    [playView.gskBtn addTarget:self action:@selector(gskBtnClick) forControlEvents:UIControlEventTouchUpInside];
	[self.contentView addSubview:playView];
	[playView bind:self.articleInfo];
	[[[[playView.layoutMaker leftParent:0] rightParent:0] topParent:NAVHEIGHT] install];
   
// [self.contentView.layoutUpdate.bottom.greaterThanOrEqualTo(playView) install];
    
    myTable = [UITableView new];
    [self.contentView addSubview:myTable];
    myTable.dataSource = self;
    myTable.delegate = self;
    myTable.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [[[[[[myTable layoutMaker] leftParent:0] rightParent:0] below:playView offset:0] sizeEq:SCREENWIDTH h:485] install];
    [self.contentView.layoutUpdate.bottom.greaterThanOrEqualTo(myTable) install];

}

- (void)gotoReview
{
    AddReviewViewController *reviewVC = [AddReviewViewController new];
    [self.navigationController pushViewController:reviewVC animated:YES];
}

//GSK btn click and go to the GSK list page
- (void)gskBtnClick
{
    GSKViewController *gskVC = [GSKViewController new];
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
    return self.articleInfo.discussInfo.count;
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
    cell.disInfo = self.articleInfo.discussInfo[indexPath.row];
    return cell;

}

- (void)onClickUp:(UIButton *)btn {
	NSLog(@"clickup");
}

- (void)onClickDown:(UIButton *)btn {
	NSLog(@"onClickDown");
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
