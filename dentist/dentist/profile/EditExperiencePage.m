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
#import "PickerPage.h"
#import "SearchPage.h"
#import "Proto.h"
#import "TitleEditView.h"
#import "NSDate+myextend.h"

//show "Name of Dental Support Organization (DSO)"
#define SMALLAFF @"Small Group Practice - Affiliated"
#define LARGEAFF @"Large Group Practice - Affiliated"

@implementation EditExperiencePage {
	NSInteger fromMonth;
	NSInteger fromYear;
	NSInteger toMonth;
	NSInteger toYear;

	NSString *praticeType;
	NSString *roleAtPratice;
	NSString *nameOfDental;
	BOOL workInThisRole;

    BOOL  isShowDSO;
    BOOL  showOthers;
	FromToView *fromToView;
	TitleSwitchView *switchView;
	TitleMsgArrowView *typeView;
	TitleMsgArrowView *roleView;
	TitleMsgArrowView *dentalView;
    TitleEditView     *dentalEditView;
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

	praticeType = self.exp.praticeType;
	roleAtPratice = self.exp.roleAtPratice;
	nameOfDental = self.exp.dentalName;
	workInThisRole = self.exp.workInThisRole;

	fromMonth = self.exp.fromMonth;
	fromYear = self.exp.fromYear;
	toMonth = self.exp.toMonth;
	toYear = self.exp.toYear;

    [self buildView];

}

- (void)buildView {
    
    [self.contentView removeAllChildren];
    
    if ([praticeType isEqualToString:SMALLAFF] || [praticeType isEqualToString:LARGEAFF]) {
        isShowDSO = YES;
    }
    
    typeView = [TitleMsgArrowView new];
    typeView.titleLabel.text = @"Practice Type";
    if (self.isAdd) {
        typeView.msgLabel.text = @"Select";
    } else {
        typeView.msgLabel.text = praticeType;
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
        roleView.msgLabel.text = roleAtPratice;
    }
    [roleView onClickView:self action:@selector(clickRole:)];
    [self.contentView addSubview:roleView];
    [self addGrayLine:0 marginRight:0];
    [self bindData];
    
    if (![typeView.msgLabel.text isEqualToString:@"Select"]) {
        
        if (isShowDSO) {
            dentalView = [TitleMsgArrowView new];
            //    dentalView.titleLabel.text = @"Name of Dental Support Organization (DSO)";
            [dentalView.titleLabel setTextWithDifColor:@"Name of Dental Support Organization (DSO) *"];
            if (self.isAdd) {
                dentalView.msgLabel.text = @"Select";
            } else {
                dentalView.msgLabel.text = nameOfDental;
            }
            [dentalView onClickView:self action:@selector(clickDental:)];
            [self.contentView addSubview:dentalView];
            [self addGrayLine:0 marginRight:0];
        }else
        {
            dentalEditView = [TitleEditView new];
            dentalEditView.label.text = @"Name of Practice";
            dentalEditView.edit.delegate = self;
            [dentalEditView.edit returnDone];
            [self.contentView addSubview:dentalEditView];
            [self addGrayLine:0 marginRight:0];
        }
        
        
        switchView = [TitleSwitchView new];
        switchView.titleLabel.text = @"I currently work in this role";
        if (self.isAdd) {
            showOthers = NO;
            switchView.switchView.on = NO;
        } else {
            showOthers = workInThisRole;
            switchView.switchView.on = workInThisRole;
            if (workInThisRole) {
                toYear = [[NSDate date] year];
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

//click Practice Type and select back
- (void)clickType:(id)sender {
	SearchPage *p = [SearchPage new];
	p.checkedItem = praticeType;
	p.titleText = @"PRACTICE TYPE";
	NSArray *ls = [Proto listPracticeType];
	[p setItemsPlain:ls displayBlock:nil];

	p.onResult = ^(NSObject *item) {
        
        self->praticeType = (NSString *) item;
        if ([self->praticeType isEqualToString:SMALLAFF] || [self->praticeType isEqualToString:LARGEAFF]) {
            self->isShowDSO = YES;
        }else
        {
            self->isShowDSO = NO;
        }
		[self buildView];
	};
	[self pushPage:p];
}

- (void)clickRole:(id)sender {
	SearchPage *p = [SearchPage new];
	p.checkedItem = roleAtPratice;
	p.titleText = @"ROLE AT PRACTICE";
	NSArray *ls = [Proto listRoleAtPractice];
	[p setItemsPlain:ls displayBlock:nil];

	p.onResult = ^(NSObject *item) {
        self->roleAtPratice = (NSString *) item;
		[self bindData];
	};
	[self pushPage:p];
}

- (void)clickDental:(id)sender {
	SearchPage *p = [SearchPage new];
	p.checkedItem = nameOfDental;
	p.titleText = @"NAME OF DSO";
	NSArray *ls = [Proto listDentalNames];
	[p setItemsPlain:ls displayBlock:nil];

	p.onResult = ^(NSObject *item) {
        self->nameOfDental = (NSString *) item;
		[self bindData];
	};
	[self pushPage:p];
}

- (void)onSwitchChanged:(id)sender {
	workInThisRole = switchView.switchView.on;
    if (workInThisRole) {
        fromToView.toDateLabel.text = @"Present";
        showOthers = YES;
        fromToView.toDateLabel.userInteractionEnabled = NO;
        
    
        self->toMonth =[[NSDate date] month];
        self->toYear = [[NSDate date] year];
        
    }else{
        fromToView.toDateLabel.userInteractionEnabled = YES;
        showOthers = NO;
        [self bindData];
    }
}

- (void)bindData {
	if (fromMonth > 0 && fromYear > 0) {
		fromToView.fromDateLabel.text = strBuild(nameOfMonth(fromMonth), @" ", [@(fromYear) description]);
	} else {
		fromToView.fromDateLabel.text = @"Select";
	}
	if (toMonth > 0 && toYear > 0 && !workInThisRole) {
		fromToView.toDateLabel.text = strBuild(nameOfMonth(toMonth), @" ", [@(toYear) description]);
    }else if (workInThisRole) {
        fromToView.toDateLabel.text = @"Present";
        
    }
    else {
		fromToView.toDateLabel.text = @"Select";
	}
	if (praticeType == nil || praticeType.length == 0) {
		typeView.msgLabel.text = @"Select";
	} else {
		typeView.msgLabel.text = praticeType;
	}
	if (roleAtPratice == nil || roleAtPratice.length == 0) {
		roleView.msgLabel.text = @"Select";
	} else {
		roleView.msgLabel.text = roleAtPratice;
	}
    
    if (dentalView != nil) {
        if (nameOfDental == nil || nameOfDental.length == 0) {
            dentalView.msgLabel.text = @"Select";
        } else {
            dentalView.msgLabel.text = nameOfDental;
        }
    } else {
        dentalEditView.edit.text = nameOfDental;
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
	NSLog(@"save");
    
    if (fromYear>toYear) {
        [self alertMsg:@"Date wrong" onOK:^() {
            
        }];
        return ;
    }else if(fromYear==toYear){
        if(fromMonth>toMonth){
            [self alertMsg:@"Date wrong" onOK:^() {
                
            }];
            return ;
        }
    }
    
    
    if (fromYear > toYear || (fromYear == toYear && fromMonth > toMonth)) {
        [self Den_showAlertWithTitle:localStr(@"notice") message:nil appearanceProcess:^(DenAlertController * _Nonnull alertMaker) {
            alertMaker.
            addActionDefaultTitle(@"OK");
        } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, DenAlertController * _Nonnull alertSelf) {
            if ([action.title isEqualToString:@"Yes"]) {
                [self popPage];
            }
        }];
    }
    
    if (!isShowDSO) {
        nameOfDental = dentalEditView.edit.text;
    }
	self.exp.dentalName = nameOfDental;
	self.exp.roleAtPratice = roleAtPratice;
	self.exp.workInThisRole = workInThisRole;
	self.exp.praticeType = praticeType;

    if (showOthers) {
        self.exp.toYear = 9999;
    }else
    {
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
