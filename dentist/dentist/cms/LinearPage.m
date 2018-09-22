//
// Created by entaoyang on 2018/9/8.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "LinearPage.h"
#import "Common.h"
#import "LinearView.h"


@implementation LinearPage {
}


- (void)viewDidLoad {
	[super viewDidLoad];
	_contentView = [LinearView new];
	[self.view addSubview:_contentView];
	CGFloat topOffset = 0;
	CGFloat bottomOffset = 0;
	if (self.navigationController) {
		topOffset = NAVHEIGHT;
	}
	if (self.tabBarController) {
		bottomOffset = TABLEBAR_HEIGHT;
	}
	[[[[[_contentView.layoutMaker leftParent:0] rightParent:0] topParent:topOffset] bottomParent:-bottomOffset] install];
	_contentView.backgroundColor = UIColor.whiteColor;

	_contentView.backgroundColor = UIColor.redColor;


	LinearView *headView = [LinearView new];
	UILabel *nameView = [headView addLabel];
	nameView.text = @"Yang Entao";
	UILabel *addrView = [headView addLabel];
	addrView.text = @"JiNan";

	nameView.layoutParam.height = 30;
	addrView.layoutParam.height = -1;
	headView.layoutParam.height = 90;
	[headView layoutLinearVertical];

	[_contentView addSubview:headView];
	[_contentView addGrayLine:0 marginRight:0];

	LinearView *headView2 = [LinearView new];
	UILabel *nameView2 = [headView2 addLabel];
	nameView2.text = @"Yang Entao2";
	UILabel *addrView2 = [headView2 addLabel];
	addrView2.text = @"JiNan2";

	nameView2.layoutParam.height = 40;
	addrView2.layoutParam.height = 30;
	headView2.layoutParam.height = 90;
	[headView2 layoutLinearVertical];

	headView2.backgroundColor = UIColor.greenColor;

	[_contentView addSubview:headView2];
	[_contentView addGrayLine:0 marginRight:0];

	UILabel *lb = [_contentView addLabel];
	lb.backgroundColor = UIColor.blueColor;
	lb.text = @"fdsafas=====================www=========wwwpp=====================================";
	lb.layoutParam.height = -1;


	[_contentView layoutLinearVertical];

}


@end