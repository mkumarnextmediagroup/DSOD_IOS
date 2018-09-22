//
// Created by entaoyang on 2018/9/8.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "TestPage.h"
#import "Common.h"
#import "LinearView.h"
#import "LinearVerView.h"


@implementation TestPage {
	LinearVerView *linearView;
}

- (void)clickTest:(id)sender {
	UILabel *lb = linearView.subviews[0];
	lb.text = @"000----------------------";
}

- (void)viewDidLoad {
	[super viewDidLoad];
	self.navigationItem.title = @"Test ";
	self.navigationItem.rightBarButtonItem = [self navBarText:@"Test" target:self action:@selector(clickTest:)];


	linearView = [LinearVerView new];
	linearView.tag = 100;
	linearView.backgroundColor = UIColor.greenColor;
	[self.contentView addSubview:linearView];
	[[[[[linearView.layoutMaker leftParent:0] rightParent:0] topParent:10] heightEq:320] install];


	LinearVerView *lv = [LinearVerView new];
	lv.tag = 110;
	[linearView addSubview:lv];
	lv.layoutParam.height = LP_WRAP;
	lv.layoutParam.marginTop = 10;
	lv.layoutParam.marginBottom = 10;
	lv.layoutParam.marginLeft = 10;
	lv.layoutParam.marginRight = 10;
	lv.backgroundColor = UIColor.blueColor;

	UILabel *lb = [lv addLabel];
	lb.tag = 111;
	lb.numberOfLines = 0;
	lb.backgroundColor = UIColor.redColor;
	lb.text = @"111=====================www=========wwwpp=====================END";
	lb.layoutParam.marginTop = 10;
	lb.layoutParam.marginBottom = 10;
	lb.layoutParam.marginLeft = 10;
	lb.layoutParam.marginRight = 10;
	lb.layoutParam.height = LP_WRAP;


	UIButton *b = [lv addButton];
	b.tag = 112;
	b.backgroundColor = UIColor.redColor;
	[b setTitle:@"Hello" forState:UIControlStateNormal];
	b.layoutParam.height = 40;
	b.layoutParam.marginTop = 10;
	b.layoutParam.marginBottom = 10;
	b.layoutParam.marginLeft = 10;
	b.layoutParam.marginRight = 10;


}


@end