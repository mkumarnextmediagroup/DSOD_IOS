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

- (void)onBack:(UIButton *)btn {
	[self.navigationController popViewControllerAnimated:YES];
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
