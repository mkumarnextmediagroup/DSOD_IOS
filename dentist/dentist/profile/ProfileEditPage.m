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


@implementation ProfileEditPage {
	UserInfo *userInfo;
	EditUserView *userView;
	TitleEditView *nameView;
	TitleMsgArrowView *specView;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	userInfo = [Proto lastUserInfo];

	userView = [EditUserView new];
	userView.layoutParam.height = 200;
	[self.contentView addSubview:userView];

	[self addGrayLine:0 marginRight:0];

	[self addGroupTitle:@"Personal Info"].layoutParam.marginTop = 30;

	nameView = [TitleEditView new];
	nameView.layoutParam.height = 78;
	nameView.label.text = @"Full name";
	[self.contentView addSubview:nameView];

	[self addGrayLine:0 marginRight:0];

	specView = [TitleMsgArrowView new];
	specView.layoutParam.height = 78;
	specView.titleLabel.text = @"Speciality";
	[self.contentView addSubview:specView];

	[self addGrayLine:0 marginRight:0];


	[self layoutLinearVertical];


	[self bindData];
}

- (UILabel *)addGroupTitle:(NSString *)title {
	UILabel *lb = self.contentView.addLabel;
	[lb textColorSecondary];
	lb.font = [Fonts regular:12];
	lb.backgroundColor = UIColor.clearColor;
	lb.layoutParam.height = 16;
	lb.layoutParam.marginLeft = 16;
	lb.text = title;
	return lb;
}

- (void)bindData {
	nameView.edit.text = userInfo.fullName;
	specView.msgLabel.text = userInfo.specialityLabel;
}
@end