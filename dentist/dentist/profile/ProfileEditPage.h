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
@property UIImage *selectImage;

- (void)textFieldDidEditing:(UITextField *)textField;
- (void)clickSpec:(id)sender;
- (void)clickAddExp:(id)sender;
- (void)selectText:(NSString *)title value:(NSString *)value array:(NSArray *)array result:(void (^)(NSString *))result;
- (void)clickExp:(IconTitleMsgDetailCell *)sender;
- (void)addExp:(Experience *)e;
- (void)deleteExp:(Experience *)e;
- (void)clickResidency:(IconTitleMsgDetailCell *)sender;
- (void)onSave:(id)sender;
- (void)callActionSheetFunc;
- (void)clickAddResidency:(id)sender;
- (void)deleteResidency:(Residency *)r;
- (void)addResidency:(Residency *)r;
- (void)addEducation:(Education *)e;
- (void)deleteEducation:(Education *)e;
- (void)clickAddEducation:(id)sender;
- (void)clickEdu:(IconTitleMsgDetailCell *)sender;
- (void)clickPraticeAddress:(id)sender;
- (void)onBack:(id)sender;
- (void)editPortrait:(id)sender;
- (void)afterSelectDo:(UIImage *)image;
- (NSString *)getDocumentImage;
- (void)saveImageDocuments:(UIImage *)image;

@end
