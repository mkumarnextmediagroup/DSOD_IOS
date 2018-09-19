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

@interface CMSDetailViewController () {
	PlayerView *playView;
}
@end

@implementation CMSDetailViewController

- (void)viewDidLoad {
	[super viewDidLoad];

    [self createNav];
    
	UINavigationItem *item = self.navigationItem;
	item.title = @"SPONSORED CONTENT";
	item.rightBarButtonItems = @[
			[self navBarImage:@"arrowUp" target:self action:@selector(onClickUp:)],
			[self navBarImage:@"arrowDown" target:self action:@selector(onClickDown:)]
	];
	item.leftBarButtonItem = [self navBarBack:self action:@selector(onBack:)];

	[self buildViews];
//    [playView resetLayout];
//
//    [self layoutLinearVertical];
}

- (void)createNav
{
    UIView *topVi = [UIView new];
    topVi.frame = CGRectMake(0, 0, SCREENWIDTH, NAVHEIGHT);
    topVi.backgroundColor = Colors.bgNavBarColor;
    [self.view addSubview:topVi];
    
    
    UILabel *content = [UILabel new];
    content.font = [UIFont systemFontOfSize:15];
    content.textColor = [UIColor whiteColor];
    content.text = @"SPONSORED CONTENT";
    content.textAlignment = NSTextAlignmentCenter;
    content.frame = CGRectMake(50, 23+NAVHEIGHT_OFFSET, SCREENWIDTH - 100, 40);
    [topVi addSubview:content];
    
    UIButton *dismissBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [dismissBtn setImage:[UIImage imageNamed:@"back_arrow"] forState:UIControlStateNormal];
    dismissBtn.frame = CGRectMake(0, 24+NAVHEIGHT_OFFSET, 60, 40);
    [topVi addSubview:dismissBtn];
    [dismissBtn addTarget:self action:@selector(onBack:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextBtn setImage:[UIImage imageNamed:@"arrow_down"] forState:UIControlStateNormal];
    nextBtn.frame = CGRectMake(SCREENWIDTH - 80, 24+NAVHEIGHT_OFFSET, 40, 40);
    [topVi addSubview:nextBtn];
    [nextBtn addTarget:self action:@selector(onClickDown:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *preBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [preBtn setImage:[UIImage imageNamed:@"arrow_up"] forState:UIControlStateNormal];
    preBtn.frame = CGRectMake(SCREENWIDTH - 40, 24+NAVHEIGHT_OFFSET, 40, 40);
    [topVi addSubview:preBtn];
    [preBtn addTarget:self action:@selector(onClickUp:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *line = [UILabel new];
    line.frame = CGRectMake(0, NAVHEIGHT - 1.5, SCREENWIDTH, 1.5);
    line.backgroundColor = rgb255(222, 222, 222);
    [topVi addSubview:line];
}

- (void)onBack:(UIButton *)btn {
	[self dismissViewControllerAnimated:YES completion:nil];
}


- (void)buildViews {
	playView = [PlayerView new];
	[self.contentView addSubview:playView];
	[playView bind:self.articleInfo];
//    [self layoutLinearVertical];
	[[[[playView.layoutMaker leftParent:0] rightParent:0] topParent:0] install];
	[self.contentView.layoutUpdate.bottom.greaterThanOrEqualTo(playView) install];

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
