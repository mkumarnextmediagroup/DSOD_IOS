//
// Created by yet on 2018/8/17.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "StudentController.h"
#import "Common.h"
#import "RegController.h"


@interface StudentController ()

@end

@implementation StudentController

-(void)keywordtapCLick
{
    [self.view endEditing:YES];
}
- (void)viewDidLoad {
	[super viewDidLoad];
    UITapGestureRecognizer *keywordtap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keywordtapCLick)];
    [self.view addGestureRecognizer:keywordtap];
	UIImage *image = [UIImage imageNamed:@"bg_3.png"];
	UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
	[self.view addSubview:imageView];
	[imageView layoutFill];
    
    UIImageView *backView = self.view.addImageView;
    backView.imageName = @"back_arrow";
    [[[[[backView layoutMaker] sizeFit] leftParent:16] topParent:30+NAVHEIGHT_OFFSET] install];
    [backView onClick:self action:@selector(popBtnClick:)];
    

	UIImageView *logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
	[self.view addSubview:logoView];
	[logoView layoutCenterXOffsetTop:260 height:54 offset:54+NAVHEIGHT_OFFSET];


	UILabel *studentText = [UILabel new];
	studentText.text = localStr(@"areyoustudent");
	studentText.font = [Fonts heavy:37];
	[studentText wordSpace:-1];
	studentText.textColor = UIColor.whiteColor;
	studentText.backgroundColor = UIColor.clearColor;
	[self.view addSubview:studentText];


	UILabel *bodyText = [UILabel new];
	bodyText.numberOfLines = 0;
	bodyText.text = localStr(@"stu_info");
	bodyText.font = [Fonts regular:15];
	bodyText.textColor = UIColor.whiteColor;
	bodyText.backgroundColor = UIColor.clearColor;
	[self.view addSubview:bodyText];


	UIButton *yesButton = [UIButton new];
	[yesButton title:localStr(@"yes")];
	[yesButton styleWhite];
	[self.view addSubview:yesButton];


	UIButton *noButton = [UIButton new];
	[noButton title:localStr(@"no")];
	[noButton styleWhite];
	[self.view addSubview:noButton];


	StackLayout *sl = [StackLayout new];
	[sl push:noButton height:BTN_HEIGHT marginBottom:65];
	[sl push:yesButton height:BTN_HEIGHT marginBottom:8];
	[sl push:bodyText height:50 marginBottom:10];
	[sl push:studentText height:60 marginBottom:0];
	[sl install];

	[noButton onClick:self action:@selector(clickNo:)];
	[yesButton onClick:self action:@selector(clickYes:)];

}

/**
 back event
 */
- (void)popBtnClick:(id)sender {
    NSLog(@"popBtnClick");
    [self popPage];
}

/**
 check you it is a student
 if click yes，go to the registration page from student
 */
- (void)clickYes:(id)sender {
	RegController *c = [RegController new];
	c.student = YES;
    NSLog(@"%d",c.student);
	c.registSuccessBlock = ^{
		[self dismiss];
	};
	[self presentViewController:c animated:YES completion:nil];
}

/**
 check you it is a student
 if click no，go to the registration page from normal
 */
- (void)clickNo:(id)sender {
	RegController *c = [RegController new];
	c.student = NO;
	c.registSuccessBlock = ^{
		[self dismiss];
	};
	[self presentViewController:c animated:YES completion:nil];
}

@end
