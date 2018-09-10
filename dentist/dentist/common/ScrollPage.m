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
	m.height.equalTo(_scrollView).with.priority(200);
	[m install];

	_contentView.backgroundColor = UIColor.whiteColor;

}

- (UIScrollView *)scrollView {
	return _scrollView;
}

- (UIView *)contentView {
	return _contentView;
}


- (void)layoutLinearVertical {
	CGFloat top = 0;
	UIView *lastView = nil;
	for (UIView *v in self.contentView.subviews) {
		LayoutParam *p = v.layoutParam;
		CGFloat y = top + p.marginTop;
		[[[[[[v layoutRemaker] leftParent:p.marginLeft] rightParent:-p.marginRight] topParent:y] heightEq:p.height] install];
		top = y + p.height;
		lastView = v;
	}
	if (lastView != nil) {
		[_contentView.layoutUpdate.bottom.greaterThanOrEqualTo(lastView) install];
	}
}

- (UIView *)addGrayLine:(CGFloat)marginLeft marginRight:(CGFloat)marginRight {
	UIView *v = [UIView new];
	v.layoutParam.height = 1;
	v.layoutParam.marginLeft = marginLeft;
	v.layoutParam.marginRight = marginRight;
	[self.contentView addSubview:v];
	v.backgroundColor = Colors.cellLineColor;
	return v;
}


@end