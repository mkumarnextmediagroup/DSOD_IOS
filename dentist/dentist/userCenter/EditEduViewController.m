//
//  EditEduViewController.m
//  dentist
//
//  Created by Jacksun on 2018/9/3.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "EditEduViewController.h"
#import "Education.h"
#import "Common.h"
#import "TitleSwitchView.h"
#import "TitleMsgArrowView.h"
#import "TitleEditView.h"
#import "FromToView.h"
#import "PickerPage.h"
#import "Proto.h"
#import "IdName.h"


@implementation EditEduViewController {
	NSString *schoolId;
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

	schoolId = self.education.schoolId;
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


	switchView = [TitleSwitchView new];
	switchView.titleLabel.text = @"Attended Dental School in the US";
	[self.contentView addSubview:switchView];
	switchView.switchView.on = self.education.schoolInUS;
	[switchView.switchView addTarget:self action:@selector(onSwitchChange:) forControlEvents:UIControlEventValueChanged];
	[self addGrayLine:0 marginRight:0];

	schoolSelectView = [TitleMsgArrowView new];
	schoolSelectView.hidden = YES;
	schoolSelectView.titleLabel.text = @"Dental School";
	[self.contentView addSubview:schoolSelectView];
	[schoolSelectView onClickView:self action:@selector(clickSchool:)];

	schoolEditView = [TitleEditView new];
	schoolEditView.label.text = @"Dental School";
	schoolEditView.edit.delegate = self;
	[schoolEditView.edit returnDone];
	[self.contentView addSubview:schoolEditView];

	schoolSelectView.hidden = !self.education.schoolInUS;
	schoolEditView.hidden = self.education.schoolInUS;
	if (self.education.schoolInUS) {
		schoolSelectView.msgLabel.text = self.education.schoolName;
		schoolEditView.edit.text = @"";
	} else {
		schoolSelectView.msgLabel.text = @"";
		schoolEditView.edit.text = self.education.schoolName;
	}

	[self addGrayLine:0 marginRight:0];

	fromToView = [FromToView new];
	[self.contentView addSubview:fromToView];
	[fromToView.fromDateLabel onClickView:self action:@selector(clickFromDate:)];
	[fromToView.toDateLabel onClickView:self action:@selector(clickToDate:)];


	fromToView.showPresentWhenGreatNow = YES;
	[fromToView fromValue:fromYear month:fromMonth];
	[fromToView toValue:toYear month:toMonth];

	[self layoutLinearVertical];


	UIButton *editBtn = [self.view addSmallButton];
	if (self.isAdd) {
		[editBtn setTitle:@"Cancel" forState:UIControlStateNormal];
		[editBtn onClick:self action:@selector(clickBack:)];
	} else {
		[editBtn setTitle:@"Delete Education" forState:UIControlStateNormal];
		[editBtn onClick:self action:@selector(clickDelete:)];
	}
	[self.view addSubview:editBtn];
	[[[[editBtn.layoutMaker sizeEq:160 h:BTN_HEIGHT] bottomParent:-47] centerXParent:0] install];
}


- (void)onSwitchChange:(id)sender {
	BOOL b = switchView.switchView.on;
	schoolSelectView.hidden = !b;
	schoolEditView.hidden = b;
	[self layoutLinearVertical];
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
		[fromToView fromValue:self->fromYear month:self->fromMonth];

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
		[fromToView toValue:self->toYear month:self->toMonth];

	};
	[self presentViewController:p animated:YES completion:nil];
}

- (void)selectSchool:(NSArray *)ls {
	[self selectIdName:@"DENTAL SCHOOL" array:ls selectedId:schoolId result:^(IdName *item) {
		self->schoolId = item.id;
		schoolSelectView.msgLabel.text = item.name;
	}];
}

- (void)clickSchool:(id)sender {

	[self showIndicator];
	backTask(^() {
		NSArray *array = [Proto queryDentalSchool];
		foreTask(^() {
			[self hideIndicator];
			[self selectSchool:array];
		});
	});
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

	if (fromYear > toYear) {
		[self alertMsg:@"Date wrong" onOK:^() {

		}];
		return;
	} else if (fromYear == toYear) {
		if (fromMonth > toMonth) {
			[self alertMsg:@"Date wrong" onOK:^() {

			}];
			return;
		}
	}
	self.education.schoolInUS = switchView.switchView.on;
	if (self.education.schoolInUS) {
		self.education.schoolName = schoolSelectView.msgLabel.text;
		self.education.schoolId = schoolId;
	} else {
		self.education.schoolName = schoolEditView.edit.textTrimed;
		self.education.schoolId = nil;
	}
	self.education.fromMonth = fromMonth;
	self.education.fromYear = fromYear;
	self.education.toMonth = toMonth;
	self.education.toYear = toYear;

	self.saveCallback(self.education);

	[self alertMsg:@"Saved Successfully" onOK:^() {
		[self popPage];
	}];

}


@end
