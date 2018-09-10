//
// Created by entaoyang on 2018/9/10.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "SearchPage.h"
#import "Pair.h"
#import "LabelCheckView.h"
#import "Common.h"


@implementation SearchPage {
	UITextField *searchEdit;
}

- (instancetype)init {
	self = [super init];
	self.topOffset = 56;
	self.withGroupLabel = NO;
	self.withIndexBar = YES;
	self.titleText = @"Select";
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	[self.table setSectionIndexBackgroundColor:rgb255(233, 233, 233)];
	[self.table setSectionIndexColor:rgb255(158, 174, 185)];
	[self.table setSectionIndexTrackingBackgroundColor:rgb255(220, 220, 220)];

	UINavigationItem *navItem = self.navigationItem;
	navItem.leftBarButtonItem = [self navBarBack:self action:@selector(clickBack:)];
	navItem.title = self.titleText;
	navItem.rightBarButtonItem = [self navBarText:localStr(@"ok") target:self action:@selector(onClickOK:)];

	searchEdit = [self.view addEditSearch];
	searchEdit.delegate = self;

	[[[[[searchEdit.layoutMaker leftParent:16] rightParent:-16] topParent:65 + 10] heightEq:EDIT_HEIGHT] install];
	UIView *lineView = [self.view addView];
	lineView.backgroundColor = Colors.cellLineColor;
	[[[[[lineView.layoutMaker heightEq:1] leftParent:0] rightParent:0] below:searchEdit offset:10] install];

}

- (void)onClickOK:(id)sender {
	if (self.checkedItem == nil) {
		return;
	}
	if (self.onResult != nil) {
		[self popPage];
		self.onResult(self.checkedItem);
	}
}

- (void)onTextFieldDone:(UITextField *)textField {
	NSString *s = textField.textTrimed;
	[self filterBy:s];
}

- (void)clickBack:(id)sender {
	[self popPage];
}


- (Class)viewClassOfItem:(NSObject *)item {
	return LabelCheckView.class;
}

- (CGFloat)heightOfItem:(NSObject *)item {
	return 44;
}

- (void)onBindItem:(NSObject *)item view:(UIView *)view {
	LabelCheckView *v = (LabelCheckView *) view;
	if (self.displayBlock != nil) {
		v.label.text = self.displayBlock(item);
	} else if ([item isKindOfClass:NSString.class]) {
		v.label.text = (NSString *) item;
	} else if ([item isKindOfClass:Pair.class]) {
		v.label.text = ((Pair *) item).value;
	} else {
		v.label.text = item.description;
	}
	v.checkButton.selected = [item isEqual:self.checkedItem];
}

- (void)onClickItem:(NSObject *)item {
	NSLog(@"click item %@", item);
	self.checkedItem = item;
	[self.table reloadData];
}

@end