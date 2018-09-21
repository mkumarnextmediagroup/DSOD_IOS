//
//  EditPracticeAddressViewController.m
//  dentist
//
//  Created by wennan on 2018/9/9.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "EditPracticeAddressViewController.h"
#import "Common.h"
#import "Address.h"
#import "TitleEditView.h"
#import "TitleMsgArrowView.h"
#import "SearchPage.h"
#import "Proto.h"
#import "StateCity.h"


@implementation EditPracticeAddressViewController {
	TitleEditView *addr1View;
	TitleEditView *addr2View;
	TitleEditView *zipView;
	TitleEditView *cityView;
	TitleMsgArrowView *stateView;

}

- (void)viewDidLoad {
	[super viewDidLoad];
	UINavigationItem *item = self.navigationItem;
	item.title = @"PRACTICE ADDRESS";
	item.leftBarButtonItem = [self navBarBack:self action:@selector(clickBack:)];
	item.rightBarButtonItem = [self navBarText:@"Save" target:self action:@selector(clickSave:)];

	if (self.address == nil) {
		self.address = [Address new];
	}

	addr1View = [TitleEditView new];
	addr1View.label.text = @"Address1";
	addr1View.edit.delegate = self;
	[addr1View.edit returnDone];
	[self.contentView addSubview:addr1View];

	addr2View = [TitleEditView new];
	addr2View.label.text = @"Address2";
	addr2View.edit.delegate = self;
	[addr2View.edit returnDone];
	[self.contentView addSubview:addr2View];

	zipView = [TitleEditView new];
	zipView.label.text = @"Zip Code";
	zipView.edit.delegate = self;
	zipView.edit.keyboardType = UIKeyboardTypeNumberPad;
	[self.contentView addSubview:zipView];

	cityView = [TitleEditView new];
	cityView.label.text = @"City";
	cityView.edit.delegate = self;
	[cityView.edit returnDone];
	[self.contentView addSubview:cityView];

	stateView = [TitleMsgArrowView new];
	stateView.titleLabel.text = @"State";
	[stateView onClickView:self action:@selector(clickState:)];
	[self.contentView addSubview:stateView];

	[self layoutLinearVertical];

	[self bindData];

	UIButton *cancelBtn = [self.view addSmallButton];
	[cancelBtn setTitle:@"Cancel" forState:UIControlStateNormal];
	[cancelBtn addTarget:self action:@selector(clickCancel:) forControlEvents:UIControlEventTouchUpInside];
	[[[[cancelBtn.layoutMaker sizeEq:60 h:BTN_HEIGHT] centerXParent:0] bottomParent:-47] install];
}

- (void)bindData {
	addr1View.edit.text = self.address.address1;
	addr2View.edit.text = self.address.address2;
	zipView.edit.text = self.address.zipCode;
	cityView.edit.text = self.address.city;
	stateView.msgLabel.text = self.address.stateLabel;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
	[super textFieldDidEndEditing:textField];
	if (zipView) {
		if (textField == zipView.edit) {
			[self queryStateCityByZipCode:textField.textTrimed];
		}
	}
}

- (void)queryStateCityByZipCode:(NSString *)zip {
	if (!zip || zip.length != 5) {
		return;
	}
	[self showIndicator];
	backTask(^() {
		StateCity *sc = [Proto getStateAndCity:zip];
		foreTask(^() {
			[self hideIndicator];
			if (sc) {
				if (sc.city) {
					cityView.edit.text = sc.city;
				}
				if (sc.state) {
					stateView.msgLabel.text = sc.state;
				}
			}
		});

	});
}

- (void)clickBack:(id)sender {

	[self Den_showAlertWithTitle:nil message:localStr(@"delAndBack") appearanceProcess:^(DenAlertController *_Nonnull alertMaker) {
		alertMaker.
				addActionCancelTitle(@"Cancel").
				addActionDefaultTitle(@"Yes");
	}               actionsBlock:^(NSInteger buttonIndex, UIAlertAction *_Nonnull action, DenAlertController *_Nonnull alertSelf) {
		if ([action.title isEqualToString:@"Yes"]) {
			[self popPage];
		}
	}];

}

- (void)clickCancel:(UIButton *)btn {
	[self popPage];
}

- (void)clickSave:(UIButton *)btn {
	self.address.address1 = [NSString stringWithFormat:@"%@\n", addr1View.edit.textTrimed];
	if (![addr2View.edit.textTrimed isEqualToString:@""]) {
		self.address.address2 = [NSString stringWithFormat:@"%@\n", addr2View.edit.textTrimed];
	} else {
		self.address.address2 = @"";
	}
	self.address.zipCode = zipView.edit.textTrimed;
	self.address.city = cityView.edit.textTrimed;
	self.address.stateLabel = stateView.msgLabel.text;

	if (self.saveCallback) {
		self.saveCallback(self.address);
	}
	[self popPage];
}


- (void)clickState:(id)sender {
	SearchPage *p = [SearchPage new];
	p.checkedItem = stateView.msgLabel.text;
	p.titleText = @"STATE";
	NSArray *ls = [Proto listStates];
	[p setItemsPlain:ls displayBlock:nil];

	p.onResult = ^(NSObject *item) {
//        stateView.msgLabel.text = (NSString *) item;
		NSString *currentState = (NSString *) item;
		NSArray *shLs = [Proto shortStates];
		for (int i = 0; i < ls.count; i++) {
			if ([ls[i] isEqualToString:currentState]) {
				self->stateView.msgLabel.text = shLs[i];
			}
		}
	};
	[self pushPage:p];

}


@end
