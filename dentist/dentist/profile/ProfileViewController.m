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
#import "ViewResumeItemView.h"
@import Firebase;

@interface ProfileViewController ()

@end


@implementation ProfileViewController

/**
 go to the profile edit page
 */
- (void)onClickEdit:(id)sender {
	ProfileEditPage *edit = [ProfileEditPage new];
	[self pushPage:edit];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self buildViews];
	[self layoutLinearVertical];
    [FIRAnalytics setScreenName:@"Profile_View_Controller" screenClass:@"ProfileView"];
}

- (void)viewDidLoad {
	[super viewDidLoad];

	UINavigationItem *item = self.navigationItem;
	item.title = @"PROFILE";
	item.rightBarButtonItems = @[
			[self navBarImage:@"edit" target:self action:@selector(onClickEdit:)],
			[self navBarText:@"Edit" target:self action:@selector(onClickEdit:)]
	];
    if (_isSecond) {
        item.leftBarButtonItem = [self navBarImage:@"back_arrow" target:self action:@selector(backToFirst)];
    }


	[self buildViews];
	[self layoutLinearVertical];

    /**
     get the profile info
     */
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

/**
 back event
 */
- (void)backToFirst
{
    NSArray *viewcontrollers=self.navigationController.viewControllers;
    if (viewcontrollers.count>1) {
        if ([viewcontrollers objectAtIndex:viewcontrollers.count-1]==self) {
            //push方式
            [self.navigationController popViewControllerAnimated:NO];
        }
    }
    else{
        //present方式
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}

- (GroupLabelView *)addGroupTitle:(NSString *)title {
	GroupLabelView *v = [GroupLabelView new];
	v.label.text = title;
	[self.contentView addSubview:v];
	v.layoutParam.marginTop = 8;
	return v;
}

/**
 display the profile view
 */
- (void)buildViews {

	_userInfo = [Proto lastUserInfo];

	NSArray *allSubView = self.contentView.subviews;
	if (allSubView != nil) {
		for (UIView *v in allSubView) {
			[v removeFromSuperview];
		}
	}

	UserCell *userCell = [UserCell new];
	userCell.imageView.imageName = @"user_img";
	[userCell.imageView loadUrl:_userInfo.portraitUrlFull placeholderImage:@"user_img"];
	userCell.nameLabel.text = _userInfo.fullName;
	if (_userInfo.speciality == nil || _userInfo.speciality.id == nil) {
		userCell.specNameLabel.text = @"";
	} else {
		userCell.specNameLabel.text = _userInfo.speciality.name;
	}
	[userCell.imageView loadUrl:_userInfo.portraitUrlFull placeholderImage:@"user_img"];

	Log(@"Portrait Url: ", _userInfo.portraitUrlFull);

	userCell.linkedinView.hidden = !_userInfo.isLinkedin;
	[self.contentView addSubview:userCell];
    
    
    [self addGroupTitle:@"Resume"];
    ViewResumeItemView *viewResumeItemView = [[ViewResumeItemView alloc]initWithViewController:self];
    [self.contentView addSubview:viewResumeItemView];
    [self addGrayLine:0 marginRight:0];
    [viewResumeItemView showWithLastResumeUrl:_userInfo.resume_url fileName:_userInfo.resume_name]; 
    
    
    
    

	if (!_userInfo.isStudent) {

		[self addGroupTitle:@"Experience"];

		if (_userInfo.experienceArray == nil || _userInfo.experienceArray.count == 0) {
			_userInfo.experienceArray = @[[Experience new]];
		}
		for (int i = 0; i < _userInfo.experienceArray.count; ++i) {
			Experience *exp = _userInfo.experienceArray[i];
			IconTitleMsgDetailCell *expView = [IconTitleMsgDetailCell new];
			if (exp.praticeTypeId == nil || exp.praticeTypeId.length == 0) {
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
				if (exp.useDSO) {
					expView.msgLabel.text = exp.dsoName;
				} else {
					expView.msgLabel.text = exp.pracName;
				}

				expView.detailLabel.text = strBuild(exp.dateFrom, @"-", exp.dateTo);
			}
			[self.contentView addSubview:expView];
			if (i == _userInfo.experienceArray.count - 1) {
				[self addGrayLine:0 marginRight:0];
			} else {
				[self addGrayLine:78 marginRight:0];
			}
		}
	}


	[self addGroupTitle:@"Residency"];
	if (_userInfo.residencyArray == nil || _userInfo.residencyArray.count == 0) {
		_userInfo.residencyArray = @[[Residency new]];
	}
	for (int i = 0; i < _userInfo.residencyArray.count; ++i) {
		Residency *r = _userInfo.residencyArray[i];
		IconTitleMsgDetailCell *residView = [IconTitleMsgDetailCell new];
		residView.imageView.imageName = @"residency";
		if (r.schoolId == nil || r.schoolId.length == 0) {
			[residView showEmpty:@"No residency added yet."];
		} else {
			[residView hideEmpty];
			residView.titleLabel.text = @"Residency";
			residView.msgLabel.text = r.schoolName;
			residView.detailLabel.text = [NSString stringWithFormat:@"%@",@(r.toYear)];//strBuild(r.dateFrom, @"-", r.dateTo);
		}
		[self.contentView addSubview:residView];
		if (i == _userInfo.residencyArray.count - 1) {
			[self addGrayLine:0 marginRight:0];
		} else {
			[self addGrayLine:78 marginRight:0];
		}
	}

	[self addGroupTitle:@"Education"];

	if (_userInfo.educationArray == nil || _userInfo.educationArray.count == 0) {
		_userInfo.educationArray = @[[Education new]];
	}
	for (int i = 0; i < _userInfo.educationArray.count; ++i) {
		Education *edu = _userInfo.educationArray[i];
		IconTitleMsgDetailCell *v = [IconTitleMsgDetailCell new];
		v.imageView.imageName = @"school";
		if (edu.schoolName == nil || edu.schoolName.length == 0) {
			[v showEmpty:@"No education added yet."];
		} else {
			[v hideEmpty];
			v.titleLabel.text = edu.schoolName;
			v.msgLabel.text = edu.major;
			if ([v.msgLabel.text isEqualToString:@"-"]) {
				v.msgLabel.text = @"";
			}
			v.detailLabel.text = [NSString stringWithFormat:@"%@",@(edu.toYear)];//strBuild(edu.dateFrom, @"-", edu.dateTo);
		}
		[self.contentView addSubview:v];
		if (i == _userInfo.educationArray.count - 1) {
			[self addGrayLine:0 marginRight:0];
		} else {
			[self addGrayLine:78 marginRight:0];
		}
	}

	[self addGroupTitle:@"Contact"];

	IconTitleMsgCell *pCell = [IconTitleMsgCell new];
	pCell.imageView.imageName = @"icon-99";
	pCell.titleLabel.text = @"Practice Address";
	pCell.msgLabel.text = _userInfo.practiceAddress.detailAddress;
	[self.contentView addSubview:pCell];

	CGSize sz = [pCell.msgLabel sizeThatFits:makeSize(300, 1000)];
	if (sz.height > 24) {
		pCell.layoutParam.height = pCell.layoutParam.height - 24 + sz.height;
	}


	[self addGrayLine:78 marginRight:0];

	IconTitleMsgCell *phoneCell = [IconTitleMsgCell new];
	phoneCell.imageView.imageName = @"phone";
	phoneCell.titleLabel.text = @"Mobile Number";
	phoneCell.msgLabel.text = _userInfo.phone.textAddPhoneNor;
	[self.contentView addSubview:phoneCell];

	[self addGrayLine:78 marginRight:0];

	IconTitleMsgCell *emailCell = [IconTitleMsgCell new];
	emailCell.imageView.imageName = @"menu-msg";
	emailCell.titleLabel.text = @"Preferred Email Address";
	emailCell.msgLabel.text = _userInfo.emailContact;
	[self.contentView addSubview:emailCell];
}


@end
