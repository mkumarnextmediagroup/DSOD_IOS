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

	_addr1View = [TitleEditView new];
	_addr1View.label.text = @"Address1";
	_addr1View.edit.delegate = self;
	[_addr1View.edit returnDone];
	[self.contentView addSubview:_addr1View];

	_addr2View = [TitleEditView new];
	_addr2View.label.text = @"Address2";
	_addr2View.edit.delegate = self;
	[_addr2View.edit returnDone];
	[self.contentView addSubview:_addr2View];

	_zipView = [TitleEditView new];
	_zipView.label.text = @"Zip Code";
	_zipView.edit.delegate = self;
    _zipView.edit.maxLength = 5;
	_zipView.edit.keyboardType = UIKeyboardTypeNumberPad;
	[self.contentView addSubview:_zipView];

	_cityView = [TitleEditView new];
	_cityView.label.text = @"City";
	_cityView.edit.delegate = self;
	[_cityView.edit returnDone];
	[self.contentView addSubview:_cityView];

	_stateView = [TitleMsgArrowView new];
	_stateView.titleLabel.text = @"State";
	[_stateView onClickView:self action:@selector(clickState:)];
	[self.contentView addSubview:_stateView];

	[self layoutLinearVertical];

	[self bindData];

	UIButton *cancelBtn = [self.view addSmallButton];
	[cancelBtn setTitle:@"Cancel" forState:UIControlStateNormal];
	[cancelBtn addTarget:self action:@selector(clickCancel:) forControlEvents:UIControlEventTouchUpInside];
	[[[[cancelBtn.layoutMaker sizeEq:60 h:BTN_HEIGHT] centerXParent:0] bottomParent:-47] install];
}

- (void)bindData {
	_addr1View.edit.text = self.address.address1;
	_addr2View.edit.text = self.address.address2;
	_zipView.edit.text = self.address.zipCode;
	_cityView.edit.text = self.address.city;
	_stateView.msgLabel.text = self.address.stateLabel;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
	[super textFieldDidEndEditing:textField];
	if (_zipView) {
		if (textField == _zipView.edit) {
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
            [self handleStateCity:sc];
		});

	});
}

- (void)handleStateCity:(StateCity *)sc {
    [self hideIndicator];
    if (sc) {
        if (sc.city) {
            _cityView.edit.text = sc.city;
        }
        if (sc.state) {
            _stateView.msgLabel.text = sc.state;
        }
    }
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
	self.address.address1 = [NSString stringWithFormat:@"%@\n", _addr1View.edit.textTrimed];
	if (![_addr2View.edit.textTrimed isEqualToString:@""]) {
		self.address.address2 = [NSString stringWithFormat:@"%@\n", _addr2View.edit.textTrimed];
	} else {
		self.address.address2 = @"";
	}
	self.address.zipCode = _zipView.edit.textTrimed;
	self.address.city = _cityView.edit.textTrimed;
	self.address.stateLabel = _stateView.msgLabel.text;

	if (self.saveCallback) {
		self.saveCallback(self.address);
	}
	[self popPage];
}


- (void)clickState:(id)sender {
	SearchPage *p = [SearchPage new];
	p.checkedItem = _stateView.msgLabel.text;
	p.titleText = @"STATE";
	NSArray *ls = [Proto listStates];
	[p setItemsPlain:ls displayBlock:nil];

	p.onResult = ^(NSObject *item) {
        [self handleResult:item ls:ls];
	};
	[self pushPage:p];

}

- (void) handleResult:(NSObject *) item ls:(NSArray *) ls {
//        stateView.msgLabel.text = (NSString *) item;
    NSString *currentState = (NSString *) item;
    NSArray *shLs = [Proto shortStates];
    for (int i = 0; i < ls.count; i++) {
        if ([ls[i] isEqualToString:currentState]) {
            self->_stateView.msgLabel.text = shLs[i];
        }
    }
}

@end
