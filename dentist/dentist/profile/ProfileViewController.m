//
//  ProfileViewController.m
//  dentist
//
//  Created by wennan on 2018/9/1.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "ProfileViewController.h"
#import "Proto.h"
#import "UserCell.h"
#import "IconTitleMsgDetailCell.h"
#import "IconTitleMsgCell.h"
#import "GroupLabelView.h"
#import "ProfileEditPage.h"
#import "IdName.h"


@interface ProfileViewController () {
	UserInfo *userInfo;
}

@end


@implementation ProfileViewController


- (void)onClickEdit:(id)sender {
	ProfileEditPage *edit = [ProfileEditPage new];
	[self pushPage:edit];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self buildViews];
	[self layoutLinearVertical];
}

- (void)viewDidLoad {
	[super viewDidLoad];

	UINavigationItem *item = self.navigationItem;
	item.title = @"PROFILE";
	item.rightBarButtonItems = @[
			[self navBarImage:@"edit" target:self action:@selector(onClickEdit:)],
			[self navBarText:@"Edit" target:self action:@selector(onClickEdit:)]
	];


	[self buildViews];
	[self layoutLinearVertical];

	[self showIndicator];
	backTask(^() {
		[Proto getProfileInfo];

		foreTask(^() {
			[self hideIndicator];
			[self buildViews];
			[self layoutLinearVertical];
		});
	});

}

- (GroupLabelView *)addGroupTitle:(NSString *)title {
	GroupLabelView *v = [GroupLabelView new];
	v.label.text = title;
	[self.contentView addSubview:v];
	v.layoutParam.marginTop = 8;
	return v;
}

- (void)buildViews {

	userInfo = [Proto lastUserInfo];

	NSArray *allSubView = self.contentView.subviews;
	if (allSubView != nil) {
		for (UIView *v in allSubView) {
			[v removeFromSuperview];
		}
	}

	UserCell *userCell = [UserCell new];
	userCell.imageView.imageName = @"user_img";
	[userCell.imageView loadUrl:userInfo.portraitUrlFull placeholderImage:@"user_img"];
	userCell.nameLabel.text = userInfo.fullName;
	if (userInfo.speciality == nil || userInfo.speciality.id == nil) {
		userCell.specNameLabel.text = @"-";
	} else {
		userCell.specNameLabel.text = userInfo.speciality.name;
	}
	[userCell.imageView loadUrl:userInfo.portraitUrlFull placeholderImage:@"user_img"];

	Log(@"Portrait Url: ", userInfo.portraitUrlFull);

	userCell.linkedinView.hidden = !userInfo.isLinkedin;
	[self.contentView addSubview:userCell];

	[self addGroupTitle:@"Experience"];
	if (!userInfo.isStudent) {
		if (userInfo.experienceArray == nil || userInfo.experienceArray.count == 0) {
			userInfo.experienceArray = @[[Experience new]];
		}
		for (int i = 0; i < userInfo.experienceArray.count; ++i) {
			Experience *exp = userInfo.experienceArray[i];
			IconTitleMsgDetailCell *expView = [IconTitleMsgDetailCell new];
			if (exp.dentalName == nil || exp.dentalName.length == 0) {
				expView.imageView.imageName = @"exp";
				[expView showEmpty:@"No experience added yet."];
			} else {
				[expView hideEmpty];
				if ([exp isOwnerDentist]) {
					expView.imageView.imageName = @"dental-blue";
				} else {
					expView.imageView.imageName = @"exp";
				}
				expView.titleLabel.text = exp.praticeType;
				expView.msgLabel.text = exp.dentalName;
				expView.detailLabel.text = strBuild(exp.dateFrom, @"-", exp.dateTo);
			}
			[self.contentView addSubview:expView];
			if (i == userInfo.experienceArray.count - 1) {
				[self addGrayLine:0 marginRight:0];
			} else {
				[self addGrayLine:78 marginRight:0];
			}
		}
	}


	[self addGroupTitle:@"Residency"];
	if (userInfo.residencyArray == nil || userInfo.residencyArray.count == 0) {
		userInfo.residencyArray = @[[Residency new]];
	}
	for (int i = 0; i < userInfo.residencyArray.count; ++i) {
		Residency *r = userInfo.residencyArray[i];
		IconTitleMsgDetailCell *residView = [IconTitleMsgDetailCell new];
		residView.imageView.imageName = @"residency";
		if (r.schoolId == nil || r.schoolId.length == 0) {
			[residView showEmpty:@"No residency added yet."];
		} else {
			[residView hideEmpty];
			residView.titleLabel.text = @"Residency";
			residView.msgLabel.text = r.schoolName;
			residView.detailLabel.text = strBuild(r.dateFrom, @"-", r.dateTo);
		}
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
		v.imageView.imageName = @"school";
		if (edu.schoolName == nil || edu.schoolName.length == 0) {
			[v showEmpty:@"No education added yet."];
		} else {
			[v hideEmpty];
			v.titleLabel.text = edu.schoolName;
			v.msgLabel.text = edu.certificate;
			v.detailLabel.text = strBuild(edu.dateFrom, @"-", edu.dateTo);
		}
		[self.contentView addSubview:v];
		if (i == userInfo.educationArray.count - 1) {
			[self addGrayLine:0 marginRight:0];
		} else {
			[self addGrayLine:78 marginRight:0];
		}
	}

	[self addGroupTitle:@"Contact"];

	IconTitleMsgCell *pCell = [IconTitleMsgCell new];
	pCell.imageView.imageName = @"icon-99";
	pCell.titleLabel.text = @"Practice Address";
	pCell.msgLabel.text = userInfo.practiceAddress.detailAddress;
	[self.contentView addSubview:pCell];

	CGSize sz = [pCell.msgLabel sizeThatFits:makeSize(300, 1000)];
	Log(@"address size: ", @(sz.height));
	if (sz.height > 24) {
		pCell.layoutParam.height = pCell.layoutParam.height - 24 + sz.height;
	}


	[self addGrayLine:78 marginRight:0];

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
