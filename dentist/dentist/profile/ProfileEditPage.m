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


@implementation ProfileEditPage {
	UserInfo *userInfo;
	EditUserView *userView;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	userInfo = [Proto lastUserInfo];

	userView = [EditUserView new];
	[self.contentView addSubview:userView];
	userView.layoutParam.height = 200;
	[self addGrayLine:0 marginRight:0];

	[self addGroupTitle:@"Personal Info"].layoutParam.marginTop = 30;
	[self addGroupTitle:@"Full name"].layoutParam.marginTop = 20;


	[self layoutLinearVertical];

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
@end