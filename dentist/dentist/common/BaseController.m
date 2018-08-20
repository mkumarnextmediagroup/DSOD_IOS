//
// Created by yet on 2018/8/17.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "BaseController.h"
#import "UITextField+styled.h"
#import "Colors.h"
#import "Masonry.h"
#import "Common.h"
#import "UIView+customed.h"
#import "UIImageView+customed.h"

@implementation BaseController {

}

-(void) dismiss {
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)openPage:(UIViewController *)c {
	[self presentViewController:c animated:YES completion:nil];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
	NSLog(@"begin editing");
	if (textField.borderStyle == UITextBorderStyleNone) {
		textField.styleLineActive;
	} else {
		textField.styleActive;
	}
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
	NSLog(@"end  editing");
	if (textField.borderStyle == UITextBorderStyleNone) {
		textField.styleLineNormal;
	} else {
		textField.styleNormal;
	}
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	textField.resignFirstResponder;
	return YES;
}

- (void)setTopTitle:(NSString *)title imageName:(UIImage *)imageName
{
    UIView *topVi = [UIView new];
    topVi.frame = CGRectMake(0, 0, SCREENWIDTH, NAVHEIGHT);
    topVi.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topVi];
    
    UILabel *content = [UILabel new];
    content.font = [UIFont systemFontOfSize:19];
    content.textColor = [UIColor blackColor];
    content.text = title;
    content.frame = CGRectMake(50, 23, SCREENWIDTH - 100, 40);
    [topVi addSubview:content];
    
    UIButton *dismissBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [dismissBtn setImage:imageName forState:UIControlStateNormal];
    dismissBtn.frame = CGRectMake(SCREENWIDTH - 60, 24, 60, 40);
    [topVi addSubview:dismissBtn];
    [dismissBtn addTarget:self action:@selector(dismissBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *line = [UILabel new];
    line.frame = CGRectMake(0, NAVHEIGHT - 1.5, SCREENWIDTH, 1.5);
    line.backgroundColor = rgb255(222, 222, 222);
    [topVi addSubview:line];
}

- (void)dismissBtnClick
{
    [self dismiss];
}

@end
