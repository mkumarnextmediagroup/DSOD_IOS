//
// Created by yet on 2018/8/17.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "UIControl+customed.h"


@implementation UIControl (customed)


- (void)onClick:(id)target action:(SEL)action {
	[self addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}
@end