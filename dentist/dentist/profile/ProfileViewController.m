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

#define GROUP_BASE @"base"
#define GROUP_RESIDENCY @"Residency"
#define GROUP_EDUCATION @"Education"
#define GROUP_CONTACT @"Contact"
#define GROUP_EXP @"Experience"


@interface ProfileViewController () <UITableViewDelegate, UITableViewDataSource> {
	UITableView *myTable;
	UserInfo *userInfo;

	NSMutableArray<GroupItem *> *groupArray;
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
	groupArray = [NSMutableArray arrayWithCapacity:16];


	UINavigationItem *item = self.navigationItem;
	item.title = @"PROFILE";
	item.rightBarButtonItems = @[
			[self navBarImage:@"edit" target:self action:@selector(onClickEdit:)],
			[self navBarText:@"Edit" target:self action:@selector(onClickEdit:)]
	];

	myTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
	myTable.sectionFooterHeight = 0;
	myTable.delegate = self;
	myTable.dataSource = self;
//	myTable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
	myTable.separatorStyle = UITableViewCellSeparatorStyleNone;
	myTable.separatorColor = Colors.strokes;
	myTable.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
	myTable.tableFooterView = [UIView new];
	myTable.sectionFooterHeight = 0;



	[self.view addSubview:myTable];
	[[[[[myTable.layoutMaker leftParent:0] rightParent:0] topParent:0] bottomParent:0] install];

	[self initData];
}

- (void)initData {
	GroupItem *baseGroup = [GroupItem new];
	baseGroup.title = GROUP_BASE;
	[baseGroup.children addObject:@"base"];

	GroupItem *residencyGroup = [GroupItem new];
	residencyGroup.title = GROUP_RESIDENCY;
	if (userInfo.residencyArray != nil) {
		for (Residency *r in userInfo.residencyArray) {
			[residencyGroup.children addObject:r];
		}
	} else {
		[residencyGroup.children addObject:@""];
	}

	GroupItem *eduGroup = [GroupItem new];
	eduGroup.title = GROUP_EDUCATION;
	if (userInfo.educationArray != nil) {
		for (Education *e in userInfo.educationArray) {
			[eduGroup.children addObject:e];
		}
	} else {
		[eduGroup.children addObject:@""];
	}


	GroupItem *expGroup = [GroupItem new];
	expGroup.title = GROUP_EXP;
	if (userInfo.experienceArray != nil) {
		for (Experience *e in userInfo.experienceArray) {
			[expGroup.children addObject:e];
		}
	} else {
		[expGroup.children addObject:@""];
	}
	GroupItem *contactGroup = [GroupItem new];
	contactGroup.title = GROUP_CONTACT;
	[contactGroup.children addObject:@"address"];
	[contactGroup.children addObject:@"phone"];
	[contactGroup.children addObject:@"email"];

	[groupArray addObjectsFromArray:@[baseGroup, expGroup, residencyGroup, eduGroup, contactGroup]];
}

#pragma mark UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return groupArray.count;
}

#pragma mark UITableViewDatasource

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	if (section == 0) {
		return nil;
	}
	UILabel *lb = [UILabel new];
	lb.text = strBuild(@"     ", groupArray[(NSUInteger) section].title);
	lb.font = [Fonts regular:12];
	lb.textColor = Colors.textAlternate;
	lb.backgroundColor = UIColor.whiteColor;
	return lb;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return groupArray[(NSUInteger) section].children.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.section == 0) {
		return 95;
	} else {
		return 78;
	}

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	if (section == 0) {
		return 0.1;
	}
	return 24;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	if (section == 0) {
		return nil;
	}
	return groupArray[(NSUInteger) section].title;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSUInteger section = (NSUInteger) indexPath.section;
	GroupItem *group = groupArray[section];
	NSString *groupName = group.title;

	if ([groupName isEqualToString:GROUP_BASE]) {
		LineTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"userCell"];
		if (cell == nil) {
			cell = [[LineTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"userCell"];
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			UserCell *userCell = [UserCell new];
			[cell.contentView addSubview:userCell];
			[[[[[[userCell layoutMaker] leftParent:0] topParent:0] rightParent:0] heightEq:95] install];
		}
		UserCell *userCell = cell.contentView.subviews[0];
		[userCell.imageView sd_setImageWithURL:[NSURL URLWithString:userInfo.portraitUrl]
		                      placeholderImage:[UIImage imageNamed:@"default_avatar"]];
		userCell.nameLabel.text = userInfo.fullName;
		userCell.specTitleLabel.text = @"Speciality";
		userCell.specNameLabel.text = userInfo.specialityLabel;
		cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
		return cell;
	}
	if ([groupName isEqualToString:GROUP_CONTACT]) {
		LineTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"contact"];
		if (cell == nil) {
			cell = [[LineTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"contact"];
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			IconTitleMsgCell *c = [IconTitleMsgCell new];
			[cell.contentView addSubview:c];
			[[[[[[c layoutMaker] leftParent:0] topParent:0] rightParent:0] heightEq:78] install];
		}
		IconTitleMsgCell *cellView = cell.contentView.subviews[0];
		NSString *item = groupArray[section].children[(NSUInteger) indexPath.row];
		if ([item isEqualToString:@"phone"]) {
			cellView.imageView.imageName = @"phone";
			cellView.titleLabel.text = @"Mobile Number";
			cellView.msgLabel.text = userInfo.phone;
		} else if ([item isEqualToString:@"email"]) {
			cellView.imageView.imageName = @"mail";
			cellView.titleLabel.text = @"Preferred Email Address";
			cellView.msgLabel.text = userInfo.email;
		} else if ([item isEqualToString:@"address"]) {
			Address *addr = userInfo.practiceAddress;
			cellView.imageView.imageName = @"icon-99";
			cellView.titleLabel.text = @"Practice Address";
			cellView.msgLabel.text = strBuild(addr.address2, @",", addr.address1, @",", addr.city, @",", addr.stateLabel, @"-", addr.zipCode);
		}
		cell.separatorInset = UIEdgeInsetsMake(0, 78, 0, 0);

		return cell;
	}


	LineTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"normal"];
	if (cell == nil) {
		cell = [[LineTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"normal"];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		IconTitleMsgDetailCell *c = [IconTitleMsgDetailCell new];
		[cell.contentView addSubview:c];
		[[[[[[c layoutMaker] leftParent:0] topParent:0] rightParent:0] heightEq:78] install];
	}
	IconTitleMsgDetailCell *cellView = cell.contentView.subviews[0];
	NSObject *item = groupArray[section].children[(NSUInteger) indexPath.row];

	if ([groupName isEqualToString:GROUP_EXP]) {
		cellView.imageView.imageName = @"dental-blue";

		if ([item isKindOfClass:[NSString class]]) {
			cellView.msgLabel.text = @"-";
			cellView.detailLabel.text = @"-";
		} else {
			Experience *r = (Experience *) item;
			cellView.titleLabel.text = r.praticeType;
			cellView.msgLabel.text = r.dentalName;
			cellView.detailLabel.text = strBuild(r.dateFrom, @"-", r.dateTo);
		}
	}
	if ([groupName isEqualToString:GROUP_RESIDENCY]) {
		cellView.imageView.imageName = @"residency";
		cellView.titleLabel.text = @"Residency";
		if ([item isKindOfClass:[NSString class]]) {
			cellView.msgLabel.text = @"-";
			cellView.detailLabel.text = @"-";
		} else {
			Residency *r = (Residency *) item;
			cellView.msgLabel.text = r.place;
			cellView.detailLabel.text = strBuild(r.dateFrom, @"-", r.dateTo);
		}
	}
	if ([groupName isEqualToString:GROUP_EDUCATION]) {
		cellView.imageView.imageName = @"edu";
		if ([item isKindOfClass:[NSString class]]) {
			cellView.titleLabel.text = @"-";
			cellView.msgLabel.text = @"-";
			cellView.detailLabel.text = @"-";

		} else {
			Education *r = (Education *) item;
			cellView.titleLabel.text = r.schoolName;
			cellView.msgLabel.text = r.certificate;
			cellView.detailLabel.text = strBuild(r.dateFrom, @"-", r.dateTo);
		}
	}
	if (groupArray[section].children.count - 1 == indexPath.row) {
		cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
	} else {
		cell.separatorInset = UIEdgeInsetsMake(0, 78, 0, 0);
	}
	return cell;
}

@end
