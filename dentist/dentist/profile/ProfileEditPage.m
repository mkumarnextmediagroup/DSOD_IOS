//
// Created by entaoyang on 2018/9/9.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "ProfileEditPage.h"
#import "EditUserView.h"
#import "Common.h"
#import "LayoutParam.h"
#import "UserInfo.h"
#import "Proto.h"
#import "TitleEditView.h"
#import "TitleMsgArrowView.h"
#import "IconTitleMsgCell.h"
#import "IconTitleMsgDetailCell.h"
#import "GroupLabelView.h"
#import "EditPracticeAddressViewController.h"
#import "EditResidencyViewController.h"
#import "EditEduViewController.h"
#import "UpdateViewController.h"


@implementation ProfileEditPage {
	UserInfo *userInfo;
	EditUserView *userView;
	TitleEditView *nameView;
	TitleMsgArrowView *specView;
	IconTitleMsgCell *resumeView;

	NSMutableArray<IconTitleMsgDetailCell * > *residencyViews;
	NSMutableArray<IconTitleMsgDetailCell * > *eduViews;
	TitleEditView *phoneView;
	TitleEditView *emailView;
	TitleMsgArrowView *practiceAddressView;
}

- (void)viewDidLoad {
	[super viewDidLoad];

	UINavigationItem *item = self.navigationItem;
	item.title = localStr(@"editPractice");
	item.rightBarButtonItem = [self navBarText:@"SAVE" target:self action:@selector(onSave:)];
	item.leftBarButtonItem = [self navBarImage:@"back_arrow" target:self action:@selector(onBack:)];


	userInfo = [Proto lastUserInfo];
	residencyViews = [NSMutableArray arrayWithCapacity:4];
	eduViews = [NSMutableArray arrayWithCapacity:4];

	userView = [EditUserView new];
	userView.layoutParam.height = 200;
	[self.contentView addSubview:userView];

	[self addGrayLine:0 marginRight:0];

	[self addGroupTitle:@"Personal Info"];

	nameView = [TitleEditView new];
	nameView.label.text = @"Full name";
	[self.contentView addSubview:nameView];

	[self addGrayLine:0 marginRight:0];

	specView = [TitleMsgArrowView new];
	specView.titleLabel.text = @"Speciality";
	[specView onClick:self action:@selector(clickSpec:)];
	[self.contentView addSubview:specView];

	[self addGrayLine:0 marginRight:0];

	[self addGroupTitle:@"Upload resume or import data"];

	resumeView = [IconTitleMsgCell new];
	resumeView.imageView.imageName = @"cloud";
	resumeView.titleLabel.text = @"Upload Resume";
	resumeView.msgLabel.text = @"Your professional information will be imported automatically.";
	[self.contentView addSubview:resumeView];

	[self addGrayLine:0 marginRight:0];

	GroupLabelView *residGroupView = [self addGroupTitle:@"Residency"];
	[residGroupView.button onClick:self action:@selector(clickAddResidency:)];

	if (userInfo.residencyArray == nil || userInfo.residencyArray.count == 0) {
		userInfo.residencyArray = @[[Residency new]];
	}
	for (int i = 0; i < userInfo.residencyArray.count; ++i) {
		IconTitleMsgDetailCell *residView = [IconTitleMsgDetailCell new];
		residView.imageView.imageName = @"residency";
		residView.titleLabel.text = @"Residency";
		residView.msgLabel.text = @"-";
		residView.detailLabel.text = @"-";

		residView.hasArrow = YES;

		residView.argN = i;
		[residView onClickView:self action:@selector(clickResidency:)];

		[self.contentView addSubview:residView];
		[residencyViews addObject:residView];
		if (i == userInfo.residencyArray.count - 1) {
			[self addGrayLine:0 marginRight:0];
		} else {
			[self addGrayLine:78 marginRight:0];
		}
	}


	GroupLabelView *eduGroupView = [self addGroupTitle:@"Education"];
	[eduGroupView.button onClick:self action:@selector(clickAddEducation:)];

	if (userInfo.educationArray == nil || userInfo.educationArray.count == 0) {
		userInfo.educationArray = @[[Education new]];
	}
	for (int i = 0; i < userInfo.educationArray.count; ++i) {
		IconTitleMsgDetailCell *v = [IconTitleMsgDetailCell new];
		v.imageView.imageName = @"edu";
		v.titleLabel.text = @"-";
		v.msgLabel.text = @"-";
		v.detailLabel.text = @"-";
		v.hasArrow = YES;
		v.argN = i;
		[v onClickView:self action:@selector(clickEdu:)];

		[self.contentView addSubview:v];
		[eduViews addObject:v];
		if (i == userInfo.educationArray.count - 1) {
			[self addGrayLine:0 marginRight:0];
		} else {
			[self addGrayLine:78 marginRight:0];
		}
	}

	[self addGroupTitle:@"Contact Info"];

	practiceAddressView = [TitleMsgArrowView new];
	practiceAddressView.titleLabel.text = @"Practice address";
	practiceAddressView.msgLabel.text = @"-";
	[practiceAddressView onClick:self action:@selector(clickPraticeAddress:)];
	[self.contentView addSubview:practiceAddressView];
	[self addGrayLine:0 marginRight:0];


	phoneView = [TitleEditView new];
	phoneView.label.text = @"Mobile number";
	[self.contentView addSubview:phoneView];
	[self addGrayLine:0 marginRight:0];

	emailView = [TitleEditView new];
	emailView.label.text = @"Preferred email address";
	[self.contentView addSubview:emailView];
	[self addGrayLine:0 marginRight:0];


	[self bindData];
	[self layoutLinearVertical];
}

- (GroupLabelView *)addGroupTitle:(NSString *)title {
	GroupLabelView *v = [GroupLabelView new];
	v.label.text = title;
	[self.contentView addSubview:v];
	v.layoutParam.marginTop = 24;
	return v;
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	userInfo = [Proto lastUserInfo];
	[self bindData];
}


- (void)bindData {
	nameView.edit.text = userInfo.fullName;
	specView.msgLabel.text = userInfo.specialityLabel;
	if (userInfo.residencyArray != nil) {
		for (int i = 0; i < userInfo.residencyArray.count; ++i) {
			Residency *r = userInfo.residencyArray[i];
			IconTitleMsgDetailCell *v = residencyViews[i];
			v.msgLabel.text = r.place;
			v.detailLabel.text = strBuild(r.dateFrom, @"-", r.dateTo);
		}
	}
	if (userInfo.educationArray != nil) {
		for (int i = 0; i < userInfo.educationArray.count; ++i) {
			Education *edu = userInfo.educationArray[i];
			IconTitleMsgDetailCell *v = eduViews[(NSUInteger) i];
			v.titleLabel.text = edu.schoolName;
			v.msgLabel.text = edu.certificate;
			v.detailLabel.text = strBuild(edu.dateFrom, @"-", edu.dateTo);
		}
	}
	phoneView.edit.text = userInfo.phone;
	emailView.edit.text = userInfo.email;
	practiceAddressView.msgLabel.text = userInfo.practiceAddress.detailAddress;
}

- (void)clickSpec:(id)sender {
	UpdateViewController *update = [UpdateViewController new];
	update.titleStr = @"SPECIALITY";
	[self pushPage:update];
}


- (void)clickAddResidency:(id)sender {
	NSLog(@"click add residency");
    
    EditResidencyViewController *editRes = [EditResidencyViewController new];
    editRes.addOrEdit = @"add";
//    editRes.residency = r;
    [self pushPage:editRes];
    
}

- (void)clickAddEducation:(id)sender {
	NSLog(@"click add education");
    EditEduViewController *editRes = [EditEduViewController new];
    editRes.addOrEdit = @"add";
    [self pushPage:editRes];
}

- (void)clickPraticeAddress:(id)sender {
	EditPracticeAddressViewController *p = [EditPracticeAddressViewController new];
	p.address = userInfo.practiceAddress;
	[self pushPage:p];
}

- (void)clickResidency:(IconTitleMsgDetailCell *)sender {
	int n = sender.argN;
	Residency *r = userInfo.residencyArray[n];
	EditResidencyViewController *editRes = [EditResidencyViewController new];
	editRes.addOrEdit = @"edit";
    editRes.updateIndex = n;
	editRes.residency = r;
	[self pushPage:editRes];
}

- (void)clickEdu:(IconTitleMsgDetailCell *)sender {
	NSInteger n = sender.argN;
	EditEduViewController *editRes = [EditEduViewController new];
	editRes.addOrEdit = @"edit";
	editRes.education = userInfo.educationArray[n];
	[self pushPage:editRes];
}

- (void)onBack:(id)sender {
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)onSave:(id)sender {
}
@end
