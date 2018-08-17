//
// Created by yet on 2018/8/17.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "StudentController.h"
#import "Common.h"
#import "Masonry.h"
#import "LoginController.h"
#import "UIControl+customed.h"
#import "UIView+customed.h"


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


	UITextView *studentText = [UITextView new];
	studentText.text = localStr(@"areyoustudent");
	studentText.font = [Fonts medium:30];
	studentText.textColor = UIColor.whiteColor;
	studentText.backgroundColor = UIColor.clearColor;
	[self.view addSubview:studentText];
	[studentText layoutFillXOffsetBottom:60 offset:215];


	UITextView *bodyText = [UITextView new];
	bodyText.text = localStr(@"stu_info");
	bodyText.font = [Fonts regular:14];
	bodyText.textColor = UIColor.whiteColor;
	bodyText.backgroundColor = UIColor.clearColor;
	[self.view addSubview:bodyText];
	[bodyText layoutFillXOffsetBottom:70 offset:154];


	UIButton *yesButton = [UIButton new];
	[yesButton title:localStr(@"yes")];
	yesButton.styleWhite;
	[self.view addSubview:yesButton];
	[yesButton layoutFillXOffsetBottom:BTN_HEIGHT offset:113];


	UIButton *noButton = [UIButton new];
	[noButton title:localStr(@"no")];
	noButton.styleWhite;
	[self.view addSubview:noButton];
	[noButton layoutFillXOffsetBottom:BTN_HEIGHT offset:65];


//	[noButton onClick:self action:@selector(clickLogin:)];
//	[yesButton onClick:self action:@selector(clickStudent:)];

}

- (void)clickLogin:(id)sender {
	NSLog(@"click");
	LoginController *c = [LoginController new];
	[self presentViewController:c animated:YES completion:nil];
}


@end