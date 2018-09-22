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
	self.translatesAutoresizingMaskIntoConstraints = NO;
	self.autoresizesSubviews = NO;

	return self;
}


- (void)layoutSubviews {
	Log(@"layout Subviews", @(self.tag));

	CGRect rect = [self bounds];
	NSArray *array = [self childrenVisiable];
	UIView *preView = nil;
	CGFloat preY = rect.origin.y;
	for (UIView *v in array) {
		LayoutParam *lp = v.layoutParam;
		CGRect childFrame = CGRectZero;
		childFrame.origin.x = rect.origin.x + lp.marginLeft;
		childFrame.size.width = rect.size.width - lp.marginLeft - lp.marginRight;

		preY += lp.marginTop;
		childFrame.origin.y = preY;

		if (lp.height >= 0) {
			Log(@"child view: ", @(v.tag));
			childFrame.size.height = lp.height;
		} else if (lp.height == LP_WRAP) {
			if (v.subviews.count == 0
					|| [v isKindOfClass:[UILabel class]]
					|| [v isKindOfClass:[UITextView class]]
					|| [v isKindOfClass:[UITextField class]]
					|| [v isKindOfClass:[UIButton class]]
					|| [v isKindOfClass:[UISwitch class]]
					|| [v isKindOfClass:[UIActivityIndicatorView class]]
					) {
				CGSize a = makeSizeF(rect.size.width - lp.marginLeft - lp.marginRight, rect.size.height);
//				CGSize a = makeSizeF(rect.size.width - lp.marginLeft - lp.marginRight, 1000);
				CGSize sz = [v sizeThatFits:a];
				childFrame.size.height = sz.height;
			} else {
				v.frame = childFrame;
				[v layoutIfNeeded];
				NSArray *ls = v.childrenVisiable;
				CGRect b = v.bounds;
				CGFloat maxY = b.origin.y;
				for (UIView *v2 in ls) {
					CGRect vf = v2.frame;
					if (vf.origin.y + vf.size.height > maxY) {
						maxY = vf.origin.y + vf.size.height + v2.layoutParam.marginTop + v2.layoutParam.marginBottom;
					}
				}
				childFrame.size.height = maxY - b.origin.y;

			}

		} else if (lp.height == LP_FILL) {
			[v layoutIfNeeded];
		}

		preY += childFrame.size.height + lp.marginBottom;

		Log(@(v.tag), @"==", @(childFrame.origin.x), @(childFrame.origin.y), @(childFrame.size.width), @(childFrame.size.height));
		v.frame = childFrame;
	}
}
//- (CGSize)sizeThatFits:(CGSize)size {
//	CGRect b = self.bounds;
//	CGFloat maxY = b.origin.y;
//	for (UIView *v2 in  self.childrenVisiable) {
//		CGRect vf = v2.frame;
//		if (vf.origin.y + vf.size.height > maxY) {
//			maxY = vf.origin.y + vf.size.height + v2.layoutParam.marginTop + v2.layoutParam.marginBottom;
//		}
//	}
//
//
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


- (void)didAddSubview:(UIView *)subview {
	[super didAddSubview:subview];
	if ([subview isKindOfClass:UILabel.class]
			|| [subview isKindOfClass:UITextView.class]
			|| [subview isKindOfClass:UITextField.class]) {
		[subview addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
	}
}

- (void)willRemoveSubview:(UIView *)subview {
	[super willRemoveSubview:subview];
	if ([subview isKindOfClass:UILabel.class]
			|| [subview isKindOfClass:UITextView.class]
			|| [subview isKindOfClass:UITextField.class]) {
		[subview removeObserver:self forKeyPath:@"text"];
	}
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	Log(@"value changed: ", keyPath, object);
	if ([keyPath isEqualToString:@"text"]) {
		if ([object isKindOfClass:UILabel.class]
				|| [object isKindOfClass:UITextView.class]
				|| [object isKindOfClass:UITextField.class]) {
			[self setNeedsLayout];
			return;
		}
	}
	[super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
}
@end