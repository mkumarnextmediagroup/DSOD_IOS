//
// Created by entaoyang on 2018/9/8.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "TestScrollPage.h"
#import "Common.h"
#import "LayoutParam.h"


@implementation TestScrollPage {
	UILabel *lb;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	self.navigationItem.rightBarButtonItem = [self navBarText:@"Test" target:self action:@selector(clickTest:)];

	lb = [UILabel new];
	lb.backgroundColor = UIColor.blueColor;
	lb.text = @"==========11111===========";
	[self.contentView addSubview:lb];
	lb.layoutParam.height = 60;


	[self layoutLinearVertical];
}


- (void)rebuild {
	for (int i = 0; i < 10; ++i) {
		UILabel *lb = [UILabel new];
		lb.backgroundColor = rgb255(i * 10, 255 - i * 10, 0);
		lb.text = [NSString stringWithFormat:@"%d", i];
		[self.contentView addSubview:lb];
		[[[[[[lb layoutMaker] leftParent:0] rightParent:0] topParent:100 * i] heightEq:100] install];
	}
}


- (void)clickTest:(id)sender {
	NSLog(@"click ");
	UILabel *lb2 = [UILabel new];
	lb2.backgroundColor = UIColor.greenColor;
	lb2.text = @"======333333333===============";
//	[self.contentView addSubview:lb2];
	[self.contentView insertSubview:lb2 aboveSubview:lb];
	lb2.layoutParam.height = 500;
	lb2.layoutParam.marginLeft = 0;

	[self layoutLinearVertical];

}

@end