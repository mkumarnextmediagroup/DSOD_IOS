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
#import "StudentController.h"
#import "StackLayout.h"
#import "UILabel+customed.h"
#import "Async.h"
#import "Http.h"


@interface WelcomController ()

@end

@implementation WelcomController

- (void)viewDidLoad {
	[super viewDidLoad];
	UIImage *image = [UIImage imageNamed:@"bg_1.png"];
	UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
	[self.view addSubview:imageView];

	[imageView layoutFill];

	UIImageView *logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_white"]];
	[self.view addSubview:logoView];
	[logoView layoutCenterXOffsetTop:260 height:54 offset:54];


	UILabel *welText = [UILabel new];
	welText.text = localStr(@"welcome");
	welText.font = [Fonts heavy:44];
	[welText wordSpace:-1];
	welText.textColor = UIColor.whiteColor;
	welText.backgroundColor = UIColor.clearColor;
	[self.view addSubview:welText];


	UILabel *sayText = [UILabel new];
	sayText.text = localStr(@"sayhello");
	sayText.font = [Fonts medium:19];
	[sayText wordSpace:-0.2f];
	sayText.textColor = UIColor.whiteColor;
	sayText.backgroundColor = UIColor.clearColor;
	[self.view addSubview:sayText];

	UILabel *bodyText = [UILabel new];
	bodyText.numberOfLines = 0;
	bodyText.text = localStr(@"getmeet");
	bodyText.font = [Fonts regular:15];
	bodyText.textColor = UIColor.whiteColor;
	bodyText.backgroundColor = UIColor.clearColor;
	[self.view addSubview:bodyText];


	UIButton *startButton = [UIButton new];
	[startButton title:localStr(@"getstart")];
	[startButton styleWhite];
	[self.view addSubview:startButton];


	UIButton *loginButton = [UIButton new];
	[loginButton title:localStr(@"login")];
	[loginButton stylePrimary];
	[self.view addSubview:loginButton];

	StackLayout *sl = [StackLayout new];
	[sl push:loginButton height:BTN_HEIGHT marginBottom:65];
	[sl push:startButton height:BTN_HEIGHT marginBottom:8];
	[sl push:bodyText height:60 marginBottom:14];
	[sl push:sayText height:30 marginBottom:12];
	[sl push:welText height:36 marginBottom:2];

	[sl install];


	[loginButton onClick:self action:@selector(clickLogin:)];
	[startButton onClick:self action:@selector(clickStudent:)];

}

- (void)clickStudent:(id)sender {
	[self openPage:[StudentController new]];
}

- (void)clickLogin:(id)sender {
	NSLog(@"click");
	LoginController *c = [LoginController new];
	[self openPage:c];


	backAction(self, @selector(testThread:), @"");

}

- (void)testThread:(NSString *)what {

}

- (void)testHttp {
	Http *h = [Http new];
	h.url = @"http://app800.cn/apps/res/download";
	[h arg:@"id" value:@"131"];
	h.progressRecv = self;
	HttpResult *r = h.get;
	NSLog(@"Result: %d", r.httpCode);
	NSLog(@"Error: %@", r.error);
	if (r.data != nil) {
		NSLog(@"Size: %d", r.data.length);
	}
}

//- (void)onHttpStart:(int)total {
//	NSLog(@"Progress start: %d", total);
//}

- (void)onHttpProgress:(int)current total:(int)total percent:(int)percent {
	NSLog(@"Progress : %d  %d  %d", current, total, percent);
}

//- (void)onHttpFinish:(BOOL)success {
//	NSLog(@"Progress Finished: %d", success);
//}


@end
