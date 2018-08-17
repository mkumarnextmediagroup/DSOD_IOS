//
// Created by entaoyang@163.com on 2018/8/15.
// Copyright (c) 2018 nextmedia.com. All rights reserved.
//

#import "LoginController.h"
#import "Common.h"


@interface LoginController ()

@end

@implementation LoginController

- (void)viewDidLoad {
	[super viewDidLoad];


	NSLog(@"%f", UIScreen.width);
	NSLog(@"%f", UIScreen.height);

	CGRect r = CGRectMake(22.5, 100, UIButton.widthLarge, UIButton.heightPrefer);

	UIButton *b = [[UIButton alloc] initWithFrame:r];
	[b setTitle:@"Login" forState:UIControlStateNormal];
	[self.view addSubview:b];
	b.stylePrimary;

	[b addTarget:self action:@selector(clickB:) forControlEvents:UIControlEventTouchUpInside];

}


- (void)clickB:(id)sender {
	[self dismissViewControllerAnimated:YES completion:nil];

}


@end