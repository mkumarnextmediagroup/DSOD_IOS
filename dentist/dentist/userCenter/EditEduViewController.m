//
//  EditEduViewController.m
//  dentist
//
//  Created by Jacksun on 2018/9/3.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "EditEduViewController.h"
#import "SwitchTableViewCell.h"
#import "CommSelectTableViewCell.h"
#import "UpdateViewController.h"
#import "PickerViewController.h"
#import "Education.h"
#import "Common.h"
#import "TitleSwitchView.h"
#import "TitleMsgArrowView.h"
#import "TitleEditView.h"
#import "FromToView.h"
#import "PickerPage.h"
#import "SearchPage.h"
#import "Proto.h"


@implementation EditEduViewController {
	BOOL schoolInUS;
	NSString *schoolName;
	NSInteger fromMonth;
	NSInteger fromYear;
	NSInteger toMonth;
	NSInteger toYear;
	TitleSwitchView *switchView;
	TitleMsgArrowView *schoolSelectView;
	TitleEditView *schoolEditView;
	FromToView *fromToView;

}


- (void)viewDidLoad {
	[super viewDidLoad];
	if (self.education == nil) {
		self.education = [Education new];
	}

	schoolInUS = self.education.schoolInUS;
	schoolName = self.education.schoolName;
	fromMonth = self.education.fromMonth;
	fromYear = self.education.fromYear;
	toMonth = self.education.toMonth;
	toYear = self.education.toYear;


	UINavigationItem *item = self.navigationItem;
	if (self.isAdd) {
		item.title = @"ADD EDUCATION";
	} else {
		item.title = @"EDIT EDUCATION";
	}
	item.rightBarButtonItem = [self navBarText:@"Save" target:self action:@selector(saveBtnClick:)];
    item.leftBarButtonItem = [self navBarBack:self action:@selector(clickBack:)];

	[self buildViews];


	UIButton *editBtn = [self.view addSmallButton];
	if (self.isAdd) {
		[editBtn setTitle:@"Cancel" forState:UIControlStateNormal];
		[editBtn onClick:self action:@selector(clickBack:)];
	} else {
		[editBtn setTitle:@"Delete Education" forState:UIControlStateNormal];
		[editBtn onClick:self action:@selector(clickDelete:)];
	}
	[self.view addSubview:editBtn];
	[[[[editBtn.layoutMaker sizeEq:160 h:BTN_HEIGHT] bottomParent:-20] centerXParent:0] install];
}


- (void)buildViews {
	[self.contentView removeAllChildren];

	switchView = [TitleSwitchView new];
	switchView.titleLabel.text = @"Attended Dental School in the US";
	[self.contentView addSubview:switchView];
	[switchView.switchView addTarget:self action:@selector(onSwitchChange:) forControlEvents:UIControlEventValueChanged];
	[self addGrayLine:0 marginRight:0];

	if (schoolInUS) {
		schoolSelectView = [TitleMsgArrowView new];
		schoolSelectView.titleLabel.text = @"Dental School";
		[self.contentView addSubview:schoolSelectView];
		[schoolSelectView onClickView:self action:@selector(clickSchool:)];
	} else {
		schoolEditView = [TitleEditView new];
		schoolEditView.label.text = @"Dental School";
		schoolEditView.edit.delegate = self;
		[schoolEditView.edit returnDone];
		[self.contentView addSubview:schoolEditView];
	}
	[self addGrayLine:0 marginRight:0];

	fromToView = [FromToView new];
	[self.contentView addSubview:fromToView];
	[fromToView.fromDateLabel onClickView:self action:@selector(clickFromDate:)];
	[fromToView.toDateLabel onClickView:self action:@selector(clickToDate:)];

	[self layoutLinearVertical];

	[self bindData];

}


- (void)bindData {
	switchView.switchView.on = schoolInUS;
	if (schoolSelectView != nil) {
		schoolSelectView.msgLabel.text = schoolName;
	} else {
		schoolEditView.edit.text = schoolName;
	}

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

- (void)onSwitchChange:(id)sender {
	schoolInUS = switchView.switchView.on;
	Log(@"switch: ", @(schoolInUS));
	[self buildViews];
}

- (void)clickFromDate:(id)sender {
	PickerPage *p = [PickerPage pickYearMonthFromNowDownTo:1950];
	p.preSelectData = @[@(fromMonth), @(fromYear)];
	p.resultCallback = ^(NSArray *result) {
		Log(result);
		NSNumber *num1 = result[0];
        self->fromMonth = num1.integerValue;
		NSNumber *num2 = result[1];
        self->fromYear = num2.integerValue;
		[self bindData];

	};
	[self presentViewController:p animated:YES completion:nil];
}

- (void)clickToDate:(id)sender {
	PickerPage *p = [PickerPage pickYearMonthFromNowDownTo:1950];
	p.preSelectData = @[@(toMonth), @(toYear)];
	p.resultCallback = ^(NSArray *result) {
		Log(result);
		NSNumber *num1 = result[0];
        self->toMonth = num1.integerValue;
		NSNumber *num2 = result[1];
        self->toYear = num2.integerValue;
		[self bindData];

	};
	[self presentViewController:p animated:YES completion:nil];
}

- (void)clickSchool:(id)sender {
	SearchPage *p = [SearchPage new];
	p.checkedItem = schoolName;
	p.titleText = @"DENTAL SCHOOL";
	NSArray *ls = [Proto listResidency];
	[p setItemsPlain:ls displayBlock:nil];

	p.onResult = ^(NSObject *item) {
        self->schoolName = (NSString *) item;
		[self bindData];
	};
	[self pushPage:p];
}

- (void)clickDelete:(UIButton *)btn {
	Confirm *d = [Confirm new];
	d.title = @"Delete Education";
	d.msg = @"Are you sure you want to delete this education?";
	d.okText = @"Yes";

	[d show:self onOK:^() {
		self.deleteCallback(self.education);
		[self popPage];
	}];
}

- (void)clickBack:(id)sender {
	[self popPage];
}

- (void)saveBtnClick:(UIButton *)btn {
	self.education.schoolInUS = switchView.switchView.on;
	if (self.education.schoolInUS) {
		self.education.schoolName = schoolSelectView.msgLabel.text;
	} else {
		self.education.schoolName = schoolEditView.edit.textTrimed;
	}
	self.education.fromMonth = fromMonth;
	self.education.fromYear = fromYear;
	self.education.toMonth = toMonth;
	self.education.toYear = toYear;

	self.saveCallback(self.education);

	[self alertMsg:@"Saved Successfullly" onOK:^() {
		[self popPage];
	}];

}


@end
