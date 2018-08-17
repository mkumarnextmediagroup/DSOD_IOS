//
// Created by yet on 2018/8/17.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "WelcomController.h"
#import "Common.h"
#import "Masonry.h"
#import "LoginController.h"
#import "UIControl+customed.h"
#import "UIView+customed.h"


@interface WelcomController ()

@end

@implementation WelcomController

- (void)viewDidLoad {
	[super viewDidLoad];
	UIImage *image = [UIImage imageNamed:@"bg_1.png"];
	UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
	[self.view addSubview:imageView];

	[imageView makeLayout:^(MASConstraintMaker *m) {
		m.width.equalTo(self.view.mas_width);
		m.height.equalTo(self.view.mas_height);
		m.centerX.equalTo(self.view.mas_centerX);
		m.centerY.equalTo(self.view.mas_centerY);
	}];


	UIImageView *logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo.png"]];
	[self.view addSubview:logoView];
	[logoView makeLayout:^(MASConstraintMaker *m) {
		m.width.equalTo(@260);
		m.height.equalTo(@54);
		m.top.equalTo(self.view.mas_top).offset(54);
		m.centerX.equalTo(self.view.mas_centerX);
	}];

	UITextView *welText = [UITextView new];
	welText.text = localStr(@"welcome");
	welText.font = [Fonts medium:42];
	welText.textColor = UIColor.whiteColor;
	welText.backgroundColor = UIColor.clearColor;
	[self.view addSubview:welText];
	[welText makeLayout:^(MASConstraintMaker *m) {
		m.width.equalTo(@208);
		m.height.equalTo(@60);
		m.left.equalTo(self.view.mas_left).offset(EDGE);
		m.top.equalTo(self.view.mas_top).offset(360);
	}];

	UITextView *sayText = [UITextView new];
	sayText.text = localStr(@"sayhello");
	sayText.font = Fonts.heading2;
	sayText.textColor = UIColor.whiteColor;
	sayText.backgroundColor = UIColor.clearColor;
	[self.view addSubview:sayText];
	[sayText makeLayout:^(MASConstraintMaker *m) {
		m.width.equalTo(@330);
		m.height.equalTo(@40);
		m.left.equalTo(self.view.mas_left).offset(EDGE);
		m.top.equalTo(self.view.mas_top).offset(390);
	}];

	UITextView *bodyText = [UITextView new];
	bodyText.text = localStr(@"getmeet");
	bodyText.font = [Fonts regular:14];
	bodyText.textColor = UIColor.whiteColor;
	bodyText.backgroundColor = UIColor.clearColor;
	[self.view addSubview:bodyText];
	[bodyText makeLayout:^(MASConstraintMaker *m) {
		m.width.equalTo(@330);
		m.height.equalTo(@70);
		m.left.equalTo(self.view.mas_left).offset(EDGE);
		m.top.equalTo(self.view.mas_top).offset(440);
	}];

	UIButton *startButton = [UIButton new];
	[startButton title:localStr(@"getstart")];
	startButton.styleWhite;
	[self.view addSubview:startButton];
	[startButton makeLayout:^(MASConstraintMaker *m) {
		m.width.equalTo(@BTN_WIDTH);
		m.height.equalTo(@BTN_HEIGHT);
		m.bottom.equalTo(self.view.mas_bottom).offset(-113);
		m.centerX.equalTo(self.view.mas_centerX);
	}];


	UIButton *loginButton = [UIButton new];
	[loginButton title:localStr(@"login")];
	loginButton.stylePrimary;
	[self.view addSubview:loginButton];
	[loginButton makeLayout:^(MASConstraintMaker *m) {
		m.width.equalTo(@BTN_WIDTH);
		m.height.equalTo(@BTN_HEIGHT);
		m.bottom.equalTo(self.view.mas_bottom).offset(-65);
		m.centerX.equalTo(self.view.mas_centerX);
	}];


	[loginButton onClick:self action:@selector(clickLogin:)];

}

- (void)clickLogin:(id)sender {
	NSLog(@"click");
	LoginController *c = [LoginController new];
	[self presentViewController:c animated:YES completion:nil];
}


@end