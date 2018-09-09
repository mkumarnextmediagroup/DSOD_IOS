//
//  UpdateViewController.m
//  dentist
//
//  Created by Jacksun on 2018/9/1.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "UpdateViewController.h"
#import "UpdateTableViewCell.h"
#import "UISearchBarView.h"

@interface UpdateViewController () <UITableViewDelegate, UITableViewDataSource, UISearchBarViewDelegate> {
	UISearchBarView *searchBar;
	UITableView *myTable;
	NSInteger indexPathRow;
	BOOL isSelectBoolean;
}
@property(strong, nonatomic) NSMutableArray *infoArr;
@end

@implementation UpdateViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	UINavigationItem *item = self.navigationItem;
	item.title = self.titleStr;
	item.leftBarButtonItem = [self navBarImage:@"back_arrow" target:self action:@selector(popBtnClick:)];


	searchBar = self.view.createSearchBar;
	searchBar.delegate = self;
	[searchBar layoutCenterXOffsetTop:SCREENWIDTH height:57 offset:NAVHEIGHT];
	self.infoArr = [[NSMutableArray alloc] init];
	self.dataList = [[NSMutableArray alloc] initWithObjects:@"General Practitioner",
	                                                        @"Dental Public Health",
	                                                        @"Endodontics",
	                                                        @"Oral & Maxillofacial Pathology",
	                                                        @"Oral & Maxillofacial Radiology",
	                                                        @"Oral & Maxillofacial Surgery",
	                                                        @"Orthodontics",
	                                                        @"Pediatric Dentistry",
	                                                        @"Periodontics",
	                                                        @"Prosthodontics", nil];
	for (NSString *str in self.dataList) {
		[self.infoArr addObject:str];
	}

	//judge the current select string
	if (self.selectStr != nil) {
		isSelectBoolean = YES;
		for (int i = 0; i < self.dataList.count; i++) {
			if ([self.selectStr isEqualToString:self.dataList[i]]) {
				indexPathRow = i;
			}
		}
	}

	myTable = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(searchBar.frame), SCREENWIDTH, SCREENHEIGHT - NAVHEIGHT - 60) style:UITableViewStylePlain];
	myTable.separatorInset = UIEdgeInsetsZero;
	myTable.delegate = self;
	myTable.dataSource = self;
	myTable.tableFooterView = [[UIView alloc] init];
	[self.view addSubview:myTable];

	// Do any additional setup after loading the view.
}

- (void)popBtnClick:(UIButton *)btn {
	[self.navigationController popViewControllerAnimated:YES];
}

#pragma mark UITableviewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *brand_region_Cell = @"Cell";

	UpdateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:brand_region_Cell];

	if (cell == nil) {
		cell = [[UpdateTableViewCell alloc]
				initWithStyle:UITableViewCellStyleDefault
			  reuseIdentifier:brand_region_Cell];
	}

	cell.textLabel.text = self.dataList[indexPath.row];

	[cell.selectBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];

	if (indexPathRow == indexPath.row && isSelectBoolean) {
		// 如果是当前cell
		[cell.selectBtn setImage:[UIImage imageNamed:@"select"] forState:UIControlStateNormal];

	} else {

		[cell.selectBtn setImage:[UIImage imageNamed:@"unSelect"] forState:UIControlStateNormal];

	}

	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

- (void)selectBtnClick:(UIButton *)btn {
	isSelectBoolean = YES;
	// 通过button计算出其所在的cell
	UpdateTableViewCell *cell = (UpdateTableViewCell *) [btn superview];
	NSIndexPath *path = [myTable indexPathForCell:cell];

	NSLog(@"the current cell label is :%@", cell.textLabel.text);

	// 刷新数据源方法
	[myTable reloadData];

	// 记录下当前的IndexPath.row
	indexPathRow = path.row;
	if (self.selctBtnClickBlock) {
		_selctBtnClickBlock(self.dataList[indexPathRow]);
	}
}

- (void)updateTheSearchText:(NSString *)fieldTest {
	NSLog(@"%@", fieldTest);

	[self.dataList removeAllObjects];
	for (NSString *str in self.infoArr) {
		if ([str hasPrefix:fieldTest]) {
			[self.dataList addObject:str];
		}
	}

	[myTable reloadData];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
