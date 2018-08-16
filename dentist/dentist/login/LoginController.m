//
// Created by entaoyang@163.com on 2018/8/15.
// Copyright (c) 2018 nextmedia.com. All rights reserved.
//

#import "LoginController.h"
#import "Colors.h"


@interface LoginController ()

@end

@implementation LoginController

- (void)viewDidLoad {
	[super viewDidLoad];
	CGRect r = CGRectMake(100, 100, 200, 200);
	UILabel *lb = [[UILabel alloc] initWithFrame:r];
	lb.text = @"LoginPage";
	[self.view addSubview:lb];
	lb.textColor = Colors.success;

}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];


}


@end