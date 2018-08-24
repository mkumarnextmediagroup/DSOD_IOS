//
// Created by yet on 2018/8/17.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "MainController.h"
#import "Common.h"
#import "RegController.h"


@interface MainController ()

@end

@implementation MainController

- (void)viewDidLoad {
	[super viewDidLoad];


	UILabel *aText = [UILabel new];
	aText.text = @"Main Page";
	aText.font = [Fonts medium:28];
	[aText wordSpace:-1];
	aText.textColor = Colors.textMain;
	aText.backgroundColor = UIColor.clearColor;
	[self.view addSubview:aText];

	[[[aText.layoutMaker centerParent] sizeFit] install];


	UIButton *aButton = [UIButton new];
	[aButton title:@"Exit"];
	[aButton stylePrimary];
	[self.view addSubview:aButton];

	[[[[[aButton layoutMaker] below:aText offset:30] sizeEq:330 h:BTN_HEIGHT] centerXParent:0] install];


	[aButton onClick:self action:@selector(clickYes:)];

}

- (void)clickYes:(id)sender {
	exit(0);
}


@end
