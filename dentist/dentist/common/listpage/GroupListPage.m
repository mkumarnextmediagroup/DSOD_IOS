//
// Created by entaoyang on 2018/9/10.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "GroupListPage.h"
#import "Common.h"

@interface GroupListPage () <UITableViewDataSource, UITableViewDelegate> {

}
@end

@implementation GroupListPage {
	UITableView *_table;
	NSArray<GroupItem *> *_items;
	NSArray<GroupItem *> *_itemsRaw;
}

- (instancetype)init {
	self = [super init];
	_table = nil;
	_items = @[];
	_itemsRaw = nil;
	_displayBlock = nil;
	_filterBlock = nil;
	self.withIndexBar = YES;
	self.withGroupLabel = YES;
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	CGFloat _topBarH = 0;
	CGFloat _bottomBarH = 0;
	if (self.navigationController != nil) {
		_topBarH = NAVHEIGHT;
	}
	if (self.tabBarController != nil) {
		_bottomBarH = TABLEBAR_HEIGHT;
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

- (void)filterBy:(NSString *)text {
	if (text == nil || text.length == 0) {
		if (_itemsRaw != nil) {
			_items = _itemsRaw;
			_itemsRaw = nil;
		}
		[_table reloadData];
		return;
	}
	NSString *lowText = [text lowercaseString];
	if (_itemsRaw == nil) {
		_itemsRaw = _items;
	}
	NSMutableArray<GroupItem *> *newItems = [NSMutableArray arrayWithCapacity:_itemsRaw.count];
	for (GroupItem *group in _itemsRaw) {
		GroupItem *newGroup = [GroupItem new];
		newGroup.title = group.title;
		newGroup.argN = group.argN;
		newGroup.argObj = group.argObj;
		newGroup.argS = group.argS;
		for (NSObject *item in group.children) {
			if ([self _accept:item text:lowText]) {
				[newGroup.children addObject:item];
			}
		}
		if (newGroup.children.count > 0) {
			[newItems addObject:newGroup];
		}
	}
	_items = newItems;
	[_table reloadData];
}

- (BOOL)_accept:(NSObject *)item text:(NSString *)lowerText {
	if (_filterBlock != nil) {
		return _filterBlock(item, lowerText);
	}
	NSString *s = [[self _labelOf:item] lowercaseString];
	return [s containsString:lowerText];
}

- (NSString *)_labelOf:(NSObject *)item {
	if (_displayBlock != nil) {
		return _displayBlock(item);
	}
	if ([item isKindOfClass:[NSString class]]) {
		return (NSString *) item;
	}
	return [item description];
}


- (UITableView *)table {
	return _table;
};

- (NSArray *)items {
	return _items;
}

- (void)setItemsPlain:(NSArray *)arr displayBlock:(DisplayBlock)displayBlock {
	if (arr == nil) {
		self.items = @[];
	} else {
		_displayBlock = displayBlock;
		NSArray *arrSoted = [arr sortedArrayUsingComparator:^NSComparisonResult(NSObject *left, NSObject *right) {
			NSString *s1 = [self _labelOf:left];
			NSString *s2 = [self _labelOf:right];
			return [s1 compare:s2];
		}];
		NSMutableArray *allItems = [NSMutableArray arrayWithCapacity:arr.count / 8 + 1];
		GroupItem *group = nil;
		for (NSObject *item in arrSoted) {
			NSString *displayLabel = [self _labelOf:item];
			NSString *firstChar = @"#";
			if (displayLabel != nil && displayLabel.length > 0) {
				firstChar = [[displayLabel substringToIndex:1] uppercaseString];
			}
			if (group != nil && [group.title isEqualToString:firstChar]) {
				[group.children addObject:item];
			} else {
				group = [GroupItem new];
				group.title = firstChar;
				[group.children addObject:item];
				[allItems addObject:group];
			}
		}
		self.items = allItems;
	}
}

- (void)setItems:(NSArray *)items {
	if (items == nil) {
		_items = @[];
	} else {
		_items = items;
	}
	if (_table != nil) {
		[_table reloadData];
	}
}

- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
	if (self.withIndexBar) {
		NSMutableArray *arr = [NSMutableArray arrayWithCapacity:self.items.count + 1];
		for (GroupItem *g in self.items) {
			[arr addObject:[g.title substringToIndex:1]];
		}
		return arr;
	} else {
		return nil;
	}
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
	return index;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return _items.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return _items[(NSUInteger) section].children.count;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	if (self.withGroupLabel) {
		GroupItem *g = _items[(NSUInteger) section];
		return g.title;
	} else {
		return nil;
	}
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSObject *item = _items[(NSUInteger) indexPath.section].children[(NSUInteger) indexPath.row];
	UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
	[self onClickItem3:item cell:cell indexPath:indexPath];
	[self onClickItem:item];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSObject *item = _items[(NSUInteger) indexPath.section].children[(NSUInteger) indexPath.row];
	return [self heightOfItem:item];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSObject *item = _items[(NSUInteger) indexPath.section].children[(NSUInteger) indexPath.row];
	Class viewCls = [self viewClassOfItem:item];
	NSString *viewClsName = NSStringFromClass(viewCls);
	UITableViewCell *cell = [_table dequeueReusableCellWithIdentifier:viewClsName];
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:viewClsName];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		UIView *v = (UIView *) [[viewCls alloc] init];
		[cell.contentView addSubview:v];
		[[[[[[v layoutMaker] leftParent:0] rightParent:0] topParent:0] bottomParent:0] install];
		[self onConfigCell:item cell:cell];
	}

	UIView *itemView = cell.contentView.subviews[0];
	[self onBindItem3:item view:itemView cell:cell];
	[self onBindItem:item view:itemView];
	return cell;
}


- (Class)viewClassOfItem:(NSObject *)item {
	return UILabel.class;
}

- (CGFloat)heightOfItem:(NSObject *)item {
	return 48;
}

- (void)onBindItem:(NSObject *)item view:(UIView *)view {
	if ([view isKindOfClass:UILabel.class]) {
		((UILabel *) view).text = [self _labelOf:item];
	}
}

- (void)onBindItem3:(NSObject *)item view:(UIView *)view cell:(UITableViewCell *)cell {

}


- (void)onConfigCell:(NSObject *)item cell:(UITableViewCell *)cell {

}

- (void)onClickItem:(NSObject *)item {
}

- (void)onClickItem3:(NSObject *)item cell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath {

}
@end
