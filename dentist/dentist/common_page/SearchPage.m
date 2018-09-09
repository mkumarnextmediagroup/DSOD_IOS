//
// Created by entaoyang on 2018/9/10.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "SearchPage.h"
#import "Pair.h"
#import "LabelCheckView.h"
#import "Common.h"


@implementation SearchPage {

}

- (void)viewDidLoad {
	self.topOffset = 56;
	[super viewDidLoad];
	[self.table setSectionIndexBackgroundColor:rgb255(233, 233, 233)];
	[self.table setSectionIndexColor:rgb255(158, 174, 185)];

}

- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
	return @[@"A", @"C", @"Y"];
}
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
	return 0 ;
}

- (Class)viewClassOfItem:(NSObject *)item {
	return LabelCheckView.class;
}

- (CGFloat)heightOfItem:(NSObject *)item {
	return 44;
}

- (void)onBindItem:(NSObject *)item view:(UIView *)view {
	LabelCheckView *v = (LabelCheckView *) view;
	if ([item isKindOfClass:NSString.class]) {
		v.label.text = (NSString *) item;
	} else if ([item isKindOfClass:Pair.class]) {
		v.label.text = ((Pair *) item).value;
	} else {
		v.label.text = item.description;
	}
	v.selected = [item isEqual:self.checkedItem];
}

- (void)onClickItem:(NSObject *)item {
	NSLog(@"click item %@", item);
	self.checkedItem = item;
	[self.table reloadData];
}

@end