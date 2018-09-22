//
// Created by entaoyang on 2018/9/22.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "LinearVerView.h"
#import "Common.h"


@implementation LinearVerView {

}

- (instancetype)init {
	self = [super init];

	UILabel *lb = [self addLabel];
	lb.backgroundColor = UIColor.blueColor;
	lb.text = @"111=====================www=========wwwpp=====================================";
	lb.layoutParam.height = -1;

	[self grayLineHor:0 marginRight:0];

	UILabel *lb2 = [self addLabel];
	lb2.backgroundColor = UIColor.blueColor;
	lb2.text = @"222=====================www=========wwwpp=====================================";
	lb2.layoutParam.height = 30;


	[self grayLineHor:0 marginRight:0];


	return self;
}


- (void)layoutLinearVertical {
	NSArray *array = [self childrenVisiable];
	UIView *lastView = nil;
	for (NSInteger i = 0; i < array.count; ++i) {
		UIView *v = array[i];
		LayoutParam *p = v.layoutParam;
		MASConstraintMaker *m = [[[v layoutRemaker] leftParent:p.marginLeft] rightParent:-p.marginRight];
		if (lastView) {
			[m below:lastView offset:p.marginTop + lastView.layoutParam.marginBottom];
		} else {
			[m topParent:p.marginTop];
		}
		if (p.height < 0) {
			m.height.greaterThanOrEqualTo(@1);
		} else {
			[m heightEq:p.height];
		}


		if (i == array.count - 1) {
			if (self.layoutParam.height < 0) {
				MASConstraintMaker *mm = self.layoutRemaker;
				mm.bottom.equalTo(v.mas_bottom).offset(p.marginBottom).priority(200);
				[mm install];
			}
		}
		[m install];
		lastView = v;
	}
}
//- (void)layoutSubviews{
//
//}
//- (CGSize)sizeThatFits:(CGSize)size {
//	NSArray *array = [self childrenVisiable];
//	CGFloat maxW = 0;
//	CGFloat maxH = 0;
//
//	for (UIView *v in array) {
//		CGSize sz = [v sizeThatFits:size];
//		CGFloat w = sz.width + v.layoutParam.marginLeft + v.layoutParam.marginRight;
//		if (w > maxW) {
//			maxW = w;
//		}
//		maxH += sz.height + v.layoutParam.marginTop + v.layoutParam.marginBottom;
//	}
//	return makeSizeF(maxW, maxH);
//}

@end