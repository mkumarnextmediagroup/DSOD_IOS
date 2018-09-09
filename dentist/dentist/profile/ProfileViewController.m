//
//  ProfileViewController.m
//  dentist
//
//  Created by wennan on 2018/9/1.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "ProfileViewController.h"
#import "ProfileHeaderTableViewCell.h"
#import "ProfileNormalTableViewCell.h"
#import "ProfileTailTableViewCell.h"
#import "EditProfileViewController.h"
#import "Profile.h"
#import "ProfileGroup.h"
#import "Async.h"
#import "Proto.h"
#import "GroupItem.h"
#import "UserCell.h"
#import "IconTitleMsgDetailCell.h"
#import "IconTitleMsgCell.h"
#import "LineTableCell.h"
#import "GroupLabelView.h"

#define GROUP_BASE @"base"
#define GROUP_RESIDENCY @"Residency"
#define GROUP_EDUCATION @"Education"
#define GROUP_CONTACT @"Contact"
#define GROUP_EXP @"Experience"


@interface ProfileViewController () <UITableViewDelegate, UITableViewDataSource> {
	UserInfo *userInfo;

}

@end


@implementation ProfileViewController


- (void)onClickEdit:(id)sender {
	EditProfileViewController *edit = [EditProfileViewController new];
	[self.navigationController pushViewController:edit animated:YES];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	userInfo = [Proto lastUserInfo];

	UINavigationItem *item = self.navigationItem;
	item.title = @"PROFILE";
	item.rightBarButtonItems = @[
			[self navBarImage:@"edit" target:self action:@selector(onClickEdit:)],
			[self navBarText:@"Edit" target:self action:@selector(onClickEdit:)]
	];

	[self buildViews];
	[self layoutLinearVertical];
}

- (GroupLabelView *)addGroupTitle:(NSString *)title {
	GroupLabelView *v = [GroupLabelView new];
	v.label.text = title;
	[self.contentView addSubview:v];
	v.layoutParam.marginTop = 8;
	return v;
}

- (void)buildViews {

	UserCell *userCell = [UserCell new];
	userCell.imageView.imageName = @"user_img";
	userCell.nameLabel.text = userInfo.fullName;
	userCell.specNameLabel.text = userInfo.specialityLabel;
	[self.contentView addSubview:userCell];

	[self addGroupTitle:@"Residency"];
	if (userInfo.residencyArray == nil || userInfo.residencyArray.count == 0) {
		userInfo.residencyArray = @[[Residency new]];
	}
	for (int i = 0; i < userInfo.residencyArray.count; ++i) {
		Residency *r = userInfo.residencyArray[i];
		IconTitleMsgDetailCell *residView = [IconTitleMsgDetailCell new];
		residView.titleLabel.text = @"Residency";
		residView.imageView.imageName = @"residency";
		if (r.place == nil || r.place.length == 0) {
			residView.msgLabel.text = @"-";
		} else {
			residView.msgLabel.text = r.place;
		}
		residView.detailLabel.text = strBuild(r.dateFrom, @"-", r.dateTo);

		[self.contentView addSubview:residView];
		if (i == userInfo.residencyArray.count - 1) {
			[self addGrayLine:0 marginRight:0];
		} else {
			[self addGrayLine:78 marginRight:0];
		}
	}

	[self addGroupTitle:@"Education"];

	if (userInfo.educationArray == nil || userInfo.educationArray.count == 0) {
		userInfo.educationArray = @[[Education new]];
	}
	for (int i = 0; i < userInfo.educationArray.count; ++i) {
		Education *edu = userInfo.educationArray[i];
		IconTitleMsgDetailCell *v = [IconTitleMsgDetailCell new];
		v.imageView.imageName = @"edu";
		v.titleLabel.text = edu.schoolName;
		v.msgLabel.text = edu.certificate;
		v.detailLabel.text = strBuild(edu.dateFrom, @"-", edu.dateTo);
		[self.contentView addSubview:v];
		if (i == userInfo.educationArray.count - 1) {
			[self addGrayLine:0 marginRight:0];
		} else {
			[self addGrayLine:78 marginRight:0];
		}
	}

	[self addGroupTitle:@"Contact"];
	IconTitleMsgCell *phoneCell = [IconTitleMsgCell new];
	phoneCell.imageView.imageName = @"phone";
	phoneCell.titleLabel.text = @"Mobile Number";
	phoneCell.msgLabel.text = userInfo.phone;
	[self.contentView addSubview:phoneCell];

	[self addGrayLine:78 marginRight:0];

	IconTitleMsgCell *emailCell = [IconTitleMsgCell new];
	emailCell.imageView.imageName = @"menu-msg";
	emailCell.titleLabel.text = @"Preferred Email Address";
	emailCell.msgLabel.text = userInfo.email;
	[self.contentView addSubview:emailCell];
}


@end
