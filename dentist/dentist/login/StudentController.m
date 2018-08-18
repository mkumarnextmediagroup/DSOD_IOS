//
// Created by yet on 2018/8/17.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "StudentController.h"
#import "Common.h"
#import "LoginController.h"
#import "UIView+customed.h"
#import "StackLayout.h"


@interface StudentController ()

@end

@implementation StudentController

- (void)viewDidLoad {
	[super viewDidLoad];
	UIImage *image = [UIImage imageNamed:@"bg_3.png"];
	UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
	[self.view addSubview:imageView];
	[imageView layoutFill];

	UIImageView *logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_white"]];
	[self.view addSubview:logoView];
	[logoView layoutCenterXOffsetTop:260 height:54 offset:54];


	UILabel *studentText = [UILabel new];
	studentText.text = localStr(@"areyoustudent");
	studentText.font = [Fonts medium:30];
	studentText.textColor = UIColor.whiteColor;
	studentText.backgroundColor = UIColor.clearColor;
	[self.view addSubview:studentText];


	UILabel *bodyText = [UILabel new];
	bodyText.numberOfLines = 0 ;
	bodyText.text = localStr(@"stu_info");
	bodyText.font = [Fonts regular:15];
	bodyText.textColor = UIColor.whiteColor;
	bodyText.backgroundColor = UIColor.clearColor;
	[self.view addSubview:bodyText];


	UIButton *yesButton = [UIButton new];
	[yesButton title:localStr(@"yes")];
	yesButton.styleWhite;
	[self.view addSubview:yesButton];


	UIButton *noButton = [UIButton new];
	[noButton title:localStr(@"no")];
	noButton.styleWhite;
	[self.view addSubview:noButton];


	StackLayout *sl = [StackLayout new];
	[sl push:noButton height:BTN_HEIGHT marginBottom:65];
	[sl push:yesButton height:BTN_HEIGHT marginBottom:8];
	[sl push:bodyText height:50 marginBottom:10];
	[sl push:studentText height:60 marginBottom:0];
	[sl install];

//	[noButton onClick:self action:@selector(clickLogin:)];
//	[yesButton onClick:self action:@selector(clickStudent:)];

}

- (void)clickLogin:(id)sender {
	NSLog(@"click");
	LoginController *c = [LoginController new];
	[self presentViewController:c animated:YES completion:nil];
}


@end