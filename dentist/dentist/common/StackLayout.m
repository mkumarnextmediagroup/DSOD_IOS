//
// Created by yet on 2018/8/18.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "StackLayout.h"
#import "StackLayoutItem.h"
#import "Common.h"
#import "Masonry.h"
#import "UIView+customed.h"


@implementation StackLayout {
	NSMutableArray *array;
}

@synthesize edge;

- (instancetype)init {
	self = super.init;
	array = [[NSMutableArray alloc] initWithCapacity:12];
	self.edge = EDGE;
	return self;
}

- (void)push:(UIView *)view height:(CGFloat)height marginBottom:(CGFloat)marginBottom {
	StackLayoutItem *item = [StackLayoutItem new];
	item.view = view;
	item.height = height;
	item.marginBottom = marginBottom;
	[array addObject:item];
}

- (void)install {

	StackLayoutItem *preItem = nil;
	for (int i = 0; i < array.count; ++i) {
		StackLayoutItem *item = array[i];
		UIView *view = item.view;

		[view makeLayout:^(MASConstraintMaker *m) {
			m.left.equalTo(view.superview.mas_left).offset(self.edge);
			m.right.equalTo(view.superview.mas_right).offset(-self.edge);
			m.height.mas_equalTo(item.height);
			if (preItem == nil) {
				m.bottom.equalTo(view.superview.mas_bottom).offset(-item.marginBottom);
			} else {
				m.bottom.equalTo(preItem.view.mas_top).offset(-item.marginBottom);
			}
		}];
		preItem = item;
	}


}
@end