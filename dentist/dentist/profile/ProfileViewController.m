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


@interface ProfileViewController () <UITableViewDelegate, UITableViewDataSource> {
	UITableView *myTable;
	NSMutableArray *_profileArray;

}

@end


@implementation ProfileViewController

- (void)onClickEdit:(id)sender {
	backTask(^() {
//		[Proto register:@"entaoyang@126.com" pwd:@"Yang2008" name:@"Entao Yang"];
		[Proto login:@"entaoyang@126.com" pwd:@"Yang2018"];
//		[Proto sendEmailCode:@"entaoyang@126.com"];
	});

	EditProfileViewController *edit = [EditProfileViewController new];
	[self.navigationController pushViewController:edit animated:YES];
}

- (void)onClickMenu:(id)sender {
	backTask(^() {
//		[Proto register:@"entaoyang@126.com" pwd:@"Yang2008" name:@"Entao Yang"];
		[Proto login:@"entaoyang@126.com" pwd:@"Yang2018"];
//		[Proto sendEmailCode:@"entaoyang@126.com"];
	});

	EditProfileViewController *edit = [EditProfileViewController new];
	[self.navigationController pushViewController:edit animated:YES];
}

- (void)viewDidLoad {
	[super viewDidLoad];

	UINavigationItem *item = self.navigationItem;
	item.title = @"PROFILE";
	item.rightBarButtonItems = @[
			[self navBarImage:@"edit" target:self action:@selector(onClickEdit:)],
			[self navBarText:@"Edit" target:self action:@selector(onClickEdit:)]
	];

	myTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
	myTable.delegate = self;
	myTable.dataSource = self;
	myTable.separatorStyle = UITableViewCellSeparatorStyleNone;

//    myTable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;


	[self.view addSubview:myTable];
	[[[[[myTable.layoutMaker leftParent:0] rightParent:0] topParent:65] bottomParent:0] install];

	[self initData];
}

- (void)initData {
	Profile *p1 = [Profile new];
	p1.name = @"Edward Norton";
	p1.specialityTitle = @"Speciality";
	p1.speciality = @"Orthodontics";

	ProfileGroup *pGroup1 = [ProfileGroup new];
	pGroup1.groupName = nil;
	pGroup1.profiles = [NSMutableArray arrayWithObjects:p1, nil];

	Profile *p2 = [Profile new];
	p2.name = @"Residency";
	p2.specialityTitle = @"Boston Hospital";
	p2.speciality = @"September 2015 - Present";
	p2.avataName = @"residency";


	ProfileGroup *pGroup2 = [ProfileGroup new];
	pGroup2.groupName = @"Residency";
	pGroup2.profiles = [NSMutableArray arrayWithObjects:p2, nil];


	Profile *p3 = [Profile new];
	p3.name = @"California Dental School";
	p3.specialityTitle = @"Certificate, Advanced Periodontology";
	p3.speciality = @"September 2014 - March 2015";
	p3.avataName = @"edu";
	p3.lineType = 1;


	Profile *p4 = [Profile new];
	p4.name = @"Arizona Dental School";
	p4.specialityTitle = @"Doctorate of Dental Medicine (DMD)";
	p4.speciality = @"September 2010 - August 2014";
	p4.avataName = @"school";


	ProfileGroup *pGroup3 = [ProfileGroup new];
	pGroup3.groupName = @"Education";
	pGroup3.profiles = [NSMutableArray arrayWithObjects:p3, p4, nil];


	Profile *p5 = [Profile new];
	p5.specialityTitle = @"Mobile Number";
	p5.speciality = @"207-782-8410";
	p5.avataName = @"phone";
	p5.lineType = 1;


	Profile *p6 = [Profile new];
	p6.specialityTitle = @"Preferred Email Address";
	p6.speciality = @"edward.norton@cads.edu";
	p6.avataName = @"mail";

	ProfileGroup *pGroup4 = [ProfileGroup new];
	pGroup4.groupName = @"Contact";
	pGroup4.profiles = [NSMutableArray arrayWithObjects:p5, p6, nil];

	_profileArray = [NSMutableArray arrayWithObjects:pGroup1, pGroup2, pGroup3, pGroup4, nil];


}

#pragma mark UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return _profileArray.count;
}

#pragma mark UITableViewDatasource

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	if (section == 0) {
		return nil;
	}
	UILabel *lb = [UILabel new];
	ProfileGroup *pGroup = _profileArray[section];
	lb.text = [NSString stringWithFormat:@"%s%@", "     ", pGroup.groupName];
	lb.font = [Fonts regular:12];
	lb.textColor = Colors.textAlternate;
	lb.backgroundColor = UIColor.whiteColor;


	return lb;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
	return nil;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	ProfileGroup *pGroup = _profileArray[section];
	return pGroup.profiles.count;
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
		return 0;
	}
	return 24;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
	return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {

	ProfileGroup *pGroup = _profileArray[section];
	return pGroup.groupName;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSUInteger section = (NSUInteger) indexPath.section;
	ProfileGroup *pGroup = _profileArray[section];
	if (section == 0) {
		static NSString *brand_region_Cell = @"userCell";

		ProfileHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:brand_region_Cell];

		if (cell == nil) {
			cell = [[ProfileHeaderTableViewCell alloc]
					initWithStyle:UITableViewCellStyleDefault
				  reuseIdentifier:brand_region_Cell];
		}
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		[cell setData:pGroup.profiles[(NSUInteger) indexPath.row]];
		return cell;

	} else if (section == pGroup.profiles.count - 1) {
		static NSString *brand_region_Cell = @"tailCell";

		ProfileTailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:brand_region_Cell];

		if (cell == nil) {
			cell = [[ProfileTailTableViewCell alloc]
					initWithStyle:UITableViewCellStyleDefault
				  reuseIdentifier:brand_region_Cell];
		}
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		[cell setData:pGroup.profiles[(NSUInteger) indexPath.row]];
		return cell;

	} else {
		static NSString *brand_region_Cell = @"normalCell";

		ProfileNormalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:brand_region_Cell];

		if (cell == nil) {
			cell = [[ProfileNormalTableViewCell alloc]
					initWithStyle:UITableViewCellStyleDefault
				  reuseIdentifier:brand_region_Cell];
		}
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		[cell setData:pGroup.profiles[(NSUInteger) indexPath.row]];
		return cell;
	}
}

@end
