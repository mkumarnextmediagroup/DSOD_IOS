//
// Created by yet on 2018/8/18.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "QueueLayout.h"
#import "QueueLayoutItem.h"
#import "Common.h"


@implementation QueueLayout {
	NSMutableArray *array;
}

- (instancetype)init {
	self = super.init;
	array = [[NSMutableArray alloc] initWithCapacity:12];
	self.edgeLeft = EDGE;
	self.edgeRight = EDGE;
	return self;
}

- (void)add:(UIView *)view height:(CGFloat)height marginTop:(CGFloat)marginTop {
	QueueLayoutItem *item = [QueueLayoutItem new];
	item.view = view;
	item.height = height;
	item.marginTop = marginTop;
	[array addObject:item];
}

- (void)install {

	QueueLayoutItem *preItem = nil;
	for (int i = 0; i < array.count; ++i) {
		QueueLayoutItem *item = array[i];
		UIView *view = item.view;
		MASConstraintMaker *m = view.layoutMaker;
		[m leftParent:self.edgeLeft];
		[m rightParent:-self.edgeRight];
		[m heightEq:item.height];
		if (preItem == nil) {
			[m topParent:item.marginTop];
		} else {
			[m below:preItem.view offset:item.marginTop];
		}
		[m install];
		preItem = item;
	}

}
@end