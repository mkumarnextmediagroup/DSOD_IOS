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
#import "TitleSwitchView.h"
#import "FromToView.h"
#import "PickerPage.h"
#import "Proto.h"
#import "TitleEditView.h"
#import "NSDate+myextend.h"
#import "IdName.h"

//show "Name of Dental Support Organization (DSO)"

#define AFFILIATED  @"Affiliated"

@implementation EditExperiencePage {
	NSInteger fromMonth;
	NSInteger fromYear;
	NSInteger toMonth;
	NSInteger toYear;

	NSString *typeId;
	NSString *typeName;
	NSString *roleId;
	NSString *roleName;

	NSString *dsoName;
	NSString *dsoId;

	NSString *pracName;


	BOOL currentWorking;

	FromToView *fromToView;
	TitleSwitchView *switchView;
	TitleMsgArrowView *typeView;
	TitleMsgArrowView *roleView;
	TitleMsgArrowView *dsoView;
	TitleEditView *dentalEditView;

}

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


	typeId = self.exp.praticeTypeId;
	typeName = self.exp.praticeType;

	roleId = self.exp.roleAtPraticeId;
	roleName = self.exp.roleAtPratice;

	dsoId = self.exp.dsoId;
	dsoName = self.exp.dsoName;

	pracName = self.exp.pracName;

	currentWorking = self.exp.workInThisRole;

	fromMonth = self.exp.fromMonth;
	fromYear = self.exp.fromYear;
	toMonth = self.exp.toMonth;
	toYear = self.exp.toYear;

	[self buildView];

}

- (void)buildView {

	[self.contentView removeAllChildren];
	fromToView = nil;
	switchView = nil;
	typeView = nil;
	roleView = nil;
	dsoView = nil;
	dentalEditView = nil;


	typeView = [TitleMsgArrowView new];
	typeView.titleLabel.text = @"Practice Type";
	if (self.isAdd) {
		typeView.msgLabel.text = @"Select";
	} else {
		typeView.msgLabel.text = typeName;
	}
	[typeView onClickView:self action:@selector(clickType:)];
	[self.contentView addSubview:typeView];
	[self addGrayLine:0 marginRight:0];


	roleView = [TitleMsgArrowView new];
	//    roleView.titleLabel.text = @"Role at Practice";
	[roleView.titleLabel setTextWithDifColor:@"Role at Practice *"];
	if (self.isAdd) {
		roleView.msgLabel.text = @"Select";
	} else {
		roleView.msgLabel.text = roleName;
	}
	[roleView onClickView:self action:@selector(clickRole:)];
	[self.contentView addSubview:roleView];
	[self addGrayLine:0 marginRight:0];

	if (typeId && typeId.length > 0) {
		if (typeName != nil && [typeName hasSuffix:AFFILIATED]) {
			dsoView = [TitleMsgArrowView new];
			//    dentalView.titleLabel.text = @"Name of Dental Support Organization (DSO)";
			[dsoView.titleLabel setTextWithDifColor:@"Name of Dental Support Organization (DSO) *"];
			if (self.isAdd) {
				dsoView.msgLabel.text = @"Select";
			} else {
				dsoView.msgLabel.text = dsoName;
			}
			[dsoView onClickView:self action:@selector(clickDental:)];
			[self.contentView addSubview:dsoView];
			[self addGrayLine:0 marginRight:0];
		} else {
			dentalEditView = [TitleEditView new];
			dentalEditView.label.text = @"Name of Practice";
			dentalEditView.edit.delegate = self;
			[dentalEditView.edit returnDone];
			dentalEditView.edit.text = pracName;
			[self.contentView addSubview:dentalEditView];
			[self addGrayLine:0 marginRight:0];
		}


		switchView = [TitleSwitchView new];
		switchView.titleLabel.text = @"I currently work in this role";
		if (self.isAdd) {
			switchView.switchView.on = NO;
		} else {
			switchView.switchView.on = currentWorking;
			if (currentWorking) {
				toYear = [[NSDate date] year];
				toMonth = [[NSDate date] month];
			}
		}
		[switchView.switchView addTarget:self action:@selector(onSwitchChanged:) forControlEvents:UIControlEventValueChanged];
		[self.contentView addSubview:switchView];
		[self addGrayLine:0 marginRight:0];


		fromToView = [FromToView new];
		[self.contentView addSubview:fromToView];
		[fromToView.fromDateLabel onClickView:self action:@selector(clickFromDate:)];
		[fromToView.toDateLabel onClickView:self action:@selector(clickToDate:)];


		UIButton *btn = self.view.addSmallButton;
		if (self.isAdd) {
			[btn title:@"Cancel"];
			[btn onClick:self action:@selector(clickCancel:)];
			[[[[[btn.layoutMaker centerXParent:0] bottomParent:-47] heightButton] widthEq:64] install];
		} else {
			[btn title:@"Delete Experience"];
			[btn onClick:self action:@selector(clickDelete:)];
			[[[[[btn.layoutMaker centerXParent:0] bottomParent:-47] heightButton] widthEq:160] install];
		}

	}
	[self layoutLinearVertical];
	[self bindData];

}

- (void)selectPracTypes:(NSArray *)ls {
	[self selectIdName:@"PRACTICE TYPE" array:ls selectedId:typeId result:^(IdName *item) {
		typeId = item.id;
		typeName = item.name;
		[self buildView];
	}];
}

//click Practice Type and select back
- (void)clickType:(id)sender {
	[self showIndicator];
	backTask(^() {
		NSArray *array = [Proto queryPracticeTypes];
		foreTask(^() {
			[self hideIndicator];
			[self selectPracTypes:array];
		});
	});

}


- (void)selectRoles:(NSArray *)ls {
	[self selectIdName:@"ROLE AT PRACTICE" array:ls selectedId:roleId result:^(IdName *item) {
		roleId = item.id;
		roleName = item.name;
		[self bindData];
	}];
}

- (void)clickRole:(id)sender {
	[self showIndicator];
	backTask(^() {
		NSArray *array = [Proto queryPracticeRoles:@""];
		foreTask(^() {
			[self hideIndicator];
			[self selectRoles:array];
		});
	});
}

- (void)selectDSO:(NSArray *)ls {
	[self selectIdName:@"NAME OF DSO" array:ls selectedId:nil result:^(IdName *item) {
		dsoId = item.id;
		dsoName = item.name;
		[self bindData];
	}];
}

- (void)clickDental:(id)sender {
	[self showIndicator];
	backTask(^() {
		NSArray *array = [Proto queryPracticeDSO:@""];
		foreTask(^() {
			[self hideIndicator];
			[self selectDSO:array];
		});
	});
}

- (void)onSwitchChanged:(id)sender {
	currentWorking = switchView.switchView.on;
	if (currentWorking) {
		fromToView.toDateLabel.text = @"Present";
		fromToView.toDateLabel.userInteractionEnabled = NO;
		self->toMonth = [[NSDate date] month];
		self->toYear = [[NSDate date] year];
	} else {
		fromToView.toDateLabel.userInteractionEnabled = YES;
	}
	[self bindData];
}

- (void)bindData {
	if (fromMonth > 0 && fromYear > 0) {
		fromToView.fromDateLabel.text = strBuild(nameOfMonth(fromMonth), @" ", [@(fromYear) description]);
	} else {
		fromToView.fromDateLabel.text = @"Select";
	}

	fromToView.toDateLabel.userInteractionEnabled = !currentWorking;
	if (currentWorking) {
		fromToView.toDateLabel.text = @"Present";
	} else {
		if (toMonth > 0 && toYear > 0) {
			fromToView.toDateLabel.text = strBuild(nameOfMonth(toMonth), @" ", [@(toYear) description]);
		} else {
			fromToView.toDateLabel.text = @"Select";
		}
	}

	if (typeName == nil || typeName.length == 0) {
		typeView.msgLabel.text = @"Select";
	} else {
		typeView.msgLabel.text = typeName;
	}
	if (roleName == nil || roleName.length == 0) {
		roleView.msgLabel.text = @"Select";
	} else {
		roleView.msgLabel.text = roleName;
	}

	if (dsoView != nil) {
		if (dsoName == nil || dsoName.length == 0) {
			dsoView.msgLabel.text = @"Select";
		} else {
			dsoView.msgLabel.text = dsoName;
		}
	}
	if (dentalEditView) {
		dentalEditView.edit.text = pracName;
	}


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

- (void)clickCancel:(id)sender {
	Log(@"cancel");
	[self popPage];
}

- (void)clickDelete:(id)sender {
	Log(@"delete");
	Confirm *dlg = [Confirm new];
	dlg.okText = @"Yes";
	dlg.title = @"Delete Experience";
	dlg.msg = @"Are you sure you want to delete this experience?";
	[dlg show:self onOK:^() {
		[self popPage];
		if (self.deleteCallback) {
			self.deleteCallback(self.exp);
		}
	}];
}


- (void)clickBack:(id)sender {
	[self popPage];
}

- (void)clickSave:(UIButton *)btn {

	if (dentalEditView) {
		pracName = dentalEditView.edit.textTrimed;
	}


	self.exp.praticeTypeId = typeId;
	self.exp.praticeType = typeName;

	self.exp.roleAtPratice = roleName;
	self.exp.roleAtPraticeId = roleId;

	self.exp.dsoName = dsoName;
	self.exp.dsoId = dsoId;

	self.exp.pracName = pracName;

	self.exp.workInThisRole = currentWorking;

	if (currentWorking) {
		self.exp.toYear = [[NSDate date] year] + 100;
	} else {
		self.exp.toYear = [[NSDate date] year];
	}
	self.exp.fromMonth = fromMonth;
	self.exp.fromYear = fromYear;
	self.exp.toMonth = toMonth;

	if (self.saveCallback) {
		self.saveCallback(self.exp);
	}
	[self popPage];
}


@end
