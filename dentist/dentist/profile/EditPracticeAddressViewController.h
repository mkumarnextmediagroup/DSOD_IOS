//
//  EditPracticeAddressViewController.h
//  dentist
//
//  Created by wennan on 2018/9/9.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScrollPage.h"
#import "TitleEditView.h"
#import "TitleMsgArrowView.h"
#import "StateCity.h"

@class Address;

@interface EditPracticeAddressViewController : ScrollPage

@property(nullable) TitleEditView *addr1View;
@property(nullable) TitleEditView *addr2View;
@property(nullable) TitleEditView *zipView;
@property(nullable) TitleEditView *cityView;
@property(nullable) TitleMsgArrowView *stateView;
@property(nullable) Address *address;
@property void (^saveCallback)(Address *address);

- (void)queryStateCityByZipCode:(NSString *)zip;
- (void)handleStateCity:(StateCity *)sc;
- (void)clickBack:(id)sender;
- (void)clickCancel:(UIButton *)btn;
- (void)clickSave:(UIButton *)btn;
- (void)clickState:(id)sender;
- (void) handleResult:(NSObject *) item ls:(NSArray *) ls;

@end
