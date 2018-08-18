//
// Created by yet on 2018/8/18.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "UIImageView+customed.h"
#import "TapGesture.h"
#import "Platform.h"


@implementation UIImageView (customed)


- (NSString *)imageName {
	return @"";
}

- (void)setImageName:(NSString *)name {
	self.image = [UIImage imageNamed:name];
}


- (void)onClick:(id)target action:(SEL)action {
	self.userInteractionEnabled = YES;
	TapGesture *t = [[TapGesture alloc] initWithTarget:self action:@selector(_onClickLabel:)];
	t.target = target;
	t.action = action;
	[self addGestureRecognizer:t];
}

- (void)_onClickLabel:(UITapGestureRecognizer *)recognizer {
	TapGesture *t = (TapGesture *) recognizer;
	objcSendMsg(t.target, t.action, t.view);
}


@end