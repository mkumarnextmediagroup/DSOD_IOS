//
//  EditResidencyViewController.m
//  dentist
//
//  Created by Jacksun on 2018/9/6.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "EditResidencyViewController.h"
#import "Residency.h"
#import "Proto.h"
#import "TitleMsgArrowView.h"
#import "FromToView.h"
#import "SearchPage.h"
#import "PickerPage.h"


@implementation EditResidencyViewController {
	TitleMsgArrowView *resView;
	FromToView *fromToView;
	NSInteger fromMonth;
	NSInteger fromYear;
	NSInteger toMonth;
	NSInteger toYear;
}

- (void)viewDidLoad {
	[super viewDidLoad];

	if (self.residency == nil) {
		self.residency = [Residency new];
	}
	fromMonth = self.residency.fromMonth;
	fromYear = self.residency.fromYear;
	toMonth = self.residency.toMonth;
	toYear = self.residency.toYear;

	UINavigationItem *item = self.navigationItem;
	item.rightBarButtonItem = [self navBarText:@"Save" target:self action:@selector(saveBtnClick:)];
	item.leftBarButtonItem = [self navBarBack:self action:@selector(clickBack:)];
	if (self.isAdd) {
		item.title = @"ADD RESIDENCY";
	} else {
		item.title = @"EDIT RESIDENCY";
	}


	resView = [TitleMsgArrowView new];
	resView.titleLabel.text = @"Residency at";
	resView.msgLabel.text = @"Select";
	[resView onClickView:self action:@selector(clickResidency:)];
	[self.contentView addSubview:resView];

	fromToView = [FromToView new];
	[self.contentView addSubview:fromToView];
	[fromToView.fromDateLabel onClickView:self action:@selector(clickFromDate:)];
	[fromToView.toDateLabel onClickView:self action:@selector(clickToDate:)];


	[self layoutLinearVertical];
	[self bindData];


	UIButton *editBtn = [self.view addSmallButton];
	if (self.isAdd) {
		[editBtn setTitle:@"Cancel" forState:UIControlStateNormal];
		[editBtn onClick:self action:@selector(clickBack:)];
	} else {
		[editBtn setTitle:@"Delete Residency" forState:UIControlStateNormal];
		[editBtn onClick:self action:@selector(clickDelete:)];
	}
	[self.view addSubview:editBtn];
	[[[[editBtn.layoutMaker sizeEq:160 h:BTN_HEIGHT] bottomParent:-20] centerXParent:0] install];
}

- (void)bindData {
	if (fromMonth > 0 && fromYear > 0) {
		fromToView.fromDateLabel.text = strBuild(nameOfMonth(fromMonth), @" ", [@(fromYear) description]);
	} else {
		fromToView.fromDateLabel.text = @"Select";
	}
	if (toMonth > 0 && toYear > 0) {
		fromToView.toDateLabel.text = strBuild(nameOfMonth(toMonth), @" ", [@(toYear) description]);
	} else {
		fromToView.toDateLabel.text = @"Select";
	}
}

- (void)clickFromDate:(id)sender {
	PickerPage *p = [PickerPage pickYearMonthFromNowDownTo:1930];
	p.preSelectData = @[@(fromMonth), @(fromYear)];
	p.resultCallback = ^(NSArray *result) {
		Log(result);
		NSNumber *num1 = result[0];
		fromMonth = num1.integerValue;
		NSNumber *num2 = result[1];
		fromYear = num2.integerValue;
		[self bindData];

	};
	[self presentViewController:p animated:YES completion:nil];
}

- (void)clickToDate:(id)sender {
	PickerPage *p = [PickerPage pickYearMonthFromNowDownTo:1930];
	p.preSelectData = @[@(toMonth), @(toYear)];
	p.resultCallback = ^(NSArray *result) {
		Log(result);
		NSNumber *num1 = result[0];
		toMonth = num1.integerValue;
		NSNumber *num2 = result[1];
		toYear = num2.integerValue;
		[self bindData];

	};
	[self presentViewController:p animated:YES completion:nil];
}

- (void)clickResidency:(id)sender {
	SearchPage *p = [SearchPage new];
	p.checkedItem = self.residency.place;
	p.titleText = @"RESIDENCY AT";
	NSArray *ls = [Proto listResidency];
	[p setItemsPlain:ls displayBlock:nil];

	p.onResult = ^(NSObject *item) {
		resView.msgLabel.text = (NSString *) item;
	};
	[self pushPage:p];
}

- (void)clickDelete:(UIButton *)btn {
	Confirm *d = [Confirm new];
	d.title = @"Delete Residency";
	d.msg = @"Are you sure you want to delete this residency?";
	d.okText = @"Yes";

	[d show:self onOK:^() {
		self.deleteCallback(self.residency);
		[self popPage];
	}];
}

- (void)clickBack:(id)sender {
	[self popPage];
}

- (void)saveBtnClick:(UIButton *)btn {
	self.residency.place = resView.msgLabel.text;
	self.residency.fromMonth = fromMonth;
	self.residency.fromYear = fromYear;
	self.residency.toMonth = toMonth;
	self.residency.toYear = toYear;

	self.saveCallback(self.residency);

	[self alertMsg:@"Saved Successfullly" onOK:^() {
		[self popPage];
	}];

}


@end
