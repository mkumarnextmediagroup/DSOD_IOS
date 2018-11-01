//
// Created by entaoyang on 2018/9/9.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScrollPage.h"
#import "TitleEditView.h"
#import "UserInfo.h"
#import "EditExperiencePage.h"
#import "IconTitleMsgDetailCell.h"


@interface ProfileEditPage : ScrollPage

@property TitleEditView *phoneView;
@property UserInfo *userInfo;
@property NSInteger num;

- (void)textFieldDidEditing:(UITextField *)textField;
- (void)clickSpec:(id)sender;
- (void)clickAddExp:(id)sender;
- (void)selectText:(NSString *)title value:(NSString *)value array:(NSArray *)array result:(void (^)(NSString *))result;
- (void)clickExp:(IconTitleMsgDetailCell *)sender;
- (void)addExp:(Experience *)e;

@end
