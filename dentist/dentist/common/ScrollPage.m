//
// Created by entaoyang on 2018/9/8.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "ScrollPage.h"
#import "Common.h"


@implementation ScrollPage {
	UIScrollView *_scrollView;
	UIView *_contentView;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	_scrollView = [UIScrollView new];
	[self.view addSubview:_scrollView];
	MASConstraintMaker *sm = [[[_scrollView layoutMaker] leftParent:0] rightParent:0];
	if (self.navigationController == nil) {
		[sm topParent:0];
	} else {
		[sm topParent:65];
	}
	if (self.tabBarController == nil) {
		[sm bottomParent:0];
	} else {
		[sm bottomParent:-49];
	}
	[sm install];


	_contentView = [UIView new];
	[_scrollView addSubview:_contentView];
	MASConstraintMaker *m = [_contentView layoutMaker];
	m.edges.equalTo(_scrollView);
	m.width.equalTo(_scrollView);
	m.height.equalTo(_scrollView).priority(200);
	[m install];

	_contentView.backgroundColor = UIColor.whiteColor;

	UIView *bottomView = [self onCreateContent];
	if (bottomView != nil) {
		[[_contentView layoutMaker].bottom.greaterThanOrEqualTo(bottomView) install];
	}
}

- (UIScrollView *)scrollView {
	return _scrollView;
}

- (UIView *)contentView {
	return _contentView;
}

- (UIView *)onCreateContent {
	return nil;
}


@end