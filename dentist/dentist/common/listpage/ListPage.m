//
// Created by entaoyang on 2018/9/8.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "ListPage.h"
#import "Common.h"


@interface ListPage () <UITableViewDataSource, UITableViewDelegate> {

}
@end

@implementation ListPage {
	UITableView *_table;
	NSArray *_items;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	CGFloat _topBarH = 0;
	CGFloat _bottomBarH = 0;
	if (self.navigationController != nil) {
		_topBarH = 65;
	}
	if (self.tabBarController != nil) {
		_bottomBarH = 49;
	}
	_table = [UITableView new];
	[self.view addSubview:_table];
	_table.dataSource = self;
	_table.delegate = self;
	_table.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
	_table.tableFooterView = [UIView new];
	_table.tableHeaderView = nil;
	[[[[[[_table layoutMaker] leftParent:0] rightParent:0] topParent:self.topOffset + _topBarH] bottomParent:-(self.bottomOffset + _bottomBarH)] install];

}

- (UITableView *)table {
	return _table;
};

- (NSArray *)items {
	return _items;
}

- (void)setItems:(NSArray *)items {
	_items = items;
	if (_table != nil) {
		[_table reloadData];
	}
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSObject *item = _items[(NSUInteger) indexPath.row];
	[self.listDelegate onClickItem:item];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSObject *item = _items[(NSUInteger) indexPath.row];
	return [self.listDelegate heightOfItem:item];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if (_items == nil) {
		return 0;
	}
	return _items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSObject *item = _items[(NSUInteger) indexPath.row];
	Class viewCls = [self.listDelegate viewClassOfItem:item];
	NSString *viewClsName = NSStringFromClass(viewCls);
	UITableViewCell *cell = [_table dequeueReusableCellWithIdentifier:viewClsName];
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:viewClsName];
		UIView *v = (UIView *) [[viewCls alloc] init];
		[cell.contentView addSubview:v];
		[[[[[[v layoutMaker] leftParent:20] rightParent:0] topParent:0] bottomParent:0] install];
		if ([self.listDelegate respondsToSelector:@selector(onConfigCell:cell:)]) {
			[self.listDelegate onConfigCell:item cell:cell];
		}
	}

	UIView *itemView = cell.contentView.subviews[0];
	if ([self.listDelegate respondsToSelector:@selector(onBindItem3:view:cell:)]) {
		[self.listDelegate onBindItem3:item view:itemView cell:cell];
	} else {
		[self.listDelegate onBindItem:item view:itemView];
	}
	return cell;
}
@end