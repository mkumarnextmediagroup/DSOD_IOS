//
//  EditExperiencePage.m
//  dentist
//
//  Created by wennan on 2018/9/9.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "EditExperiencePage.h"
#import "Common.h"
#import "UserInfo.h"
#import "TitleMsgArrowView.h"
#import "Experience.h"
#import "TitleSwitchView.h"
#import "FromToView.h"
#import "DatePickerPage.h"

@interface EditExperiencePage ()

@end

@implementation EditExperiencePage

- (instancetype)init {
	self = [super init];
	_isAdd = NO;
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	UINavigationItem *item = self.navigationItem;
	if (self.isAdd) {
		item.title = @"ADD EXPERIENCE";
	} else {
		item.title = @"EDIT EXPERIENCE";
	}
	item.leftBarButtonItem = [self navBarBack:self action:@selector(clickBack:)];
	item.rightBarButtonItem = [self navBarText:@"Save" target:self action:@selector(clickSave:)];

	TitleMsgArrowView *typeView = [TitleMsgArrowView new];
	typeView.titleLabel.text = @"Practice Type";
	if (self.isAdd) {
		typeView.msgLabel.text = @"Select";
	} else {
		typeView.msgLabel.text = self.exp.praticeType;
	}
	[self.contentView addSubview:typeView];
	[self addGrayLine:0 marginRight:0];


	TitleMsgArrowView *roleView = [TitleMsgArrowView new];
	roleView.titleLabel.text = @"Role at Practice";
	if (self.isAdd) {
		roleView.msgLabel.text = @"Select";
	} else {
		roleView.msgLabel.text = self.exp.roleAtPratice;
	}
	[self.contentView addSubview:roleView];
	[self addGrayLine:0 marginRight:0];

	TitleMsgArrowView *dentalView = [TitleMsgArrowView new];
	dentalView.titleLabel.text = @"Name of Dental Support Organization (DSO)";
	if (self.isAdd) {
		dentalView.msgLabel.text = @"Select";
	} else {
		dentalView.msgLabel.text = self.exp.dentalName;
	}
	[self.contentView addSubview:dentalView];
	[self addGrayLine:0 marginRight:0];

	TitleSwitchView *switchView = [TitleSwitchView new];
	switchView.titleLabel.text = @"I currently work in this role";
	if (self.isAdd) {

	} else {

	}
	[self.contentView addSubview:switchView];
	[self addGrayLine:0 marginRight:0];


	FromToView *fromToView = [FromToView new];
	[self.contentView addSubview:fromToView];
	[fromToView.fromDateLabel onClickView:self action:@selector(clickFromDate:)];


	UIButton *btn = self.view.addSmallButton;
	[btn title:@"Cancel"];
	[[[[[btn.layoutMaker centerXParent:0] bottomParent:-50] heightButton] widthEq:64] install];
	[btn onClick:self action:@selector(clickCancel:)];

	[self layoutLinearVertical];

}

- (void)clickFromDate:(id)sender {
	DatePickerPage *p = [DatePickerPage new];
	[self presentViewController:p animated:YES completion:nil];
}

- (void)clickCancel:(id)sender {
	Log(@"cancel");
	[self popPage];
}


- (void)clickBack:(id)sender {
	[self popPage];
}

- (void)clickSave:(UIButton *)btn {
	NSLog(@"save");
}

- (void)delBtnClick:(UIButton *)btn {
	NSLog(@"del");
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
