//
//  EditExperiencePage.h
//  dentist
//
//  Created by wennan on 2018/9/9.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "ScrollPage.h"
#import "TitleSwitchView.h"
#import "TitleMsgArrowView.h"

@class UserInfo;
@class Experience;

@interface EditExperiencePage : ScrollPage


@property BOOL isAdd;
@property UserInfo * _Nullable userInfo;
@property TitleSwitchView * _Nullable switchView;
@property NSString * _Nullable dsoName;
@property TitleMsgArrowView * _Nullable dsoView;
@property BOOL currentWorking;

@property(nonnull) Experience *exp;

@property void (^ _Nullable deleteCallback)(Experience * _Nullable exp);
@property void (^ _Nullable saveCallback)(Experience * _Nullable exp);

- (void)selectPracTypes:(NSArray * _Nullable )ls;
- (void)clickType:(id _Nullable )sender;
- (void)selectRoles:(NSArray * _Nullable )ls;
- (void)clickRole:(id _Nullable )sender;
- (void)selectDSO:(NSArray * _Nullable )ls;
- (void)clickDental:(id _Nullable )sender;
- (void)onSwitchChanged:(id _Nullable )sender;
- (void)bindData;
- (void)clickFromDate:(id _Nullable )sender;
- (void)clickToDate:(id _Nullable )sender;
- (void)clickCancel:(id _Nullable )sender;
- (void)clickDelete:(id _Nullable )sender;
- (void)clickBack:(id _Nullable )sender;
- (void)clickSave:(UIButton * _Nullable )btn;

@end
