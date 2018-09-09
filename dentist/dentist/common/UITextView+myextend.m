//
// Created by entaoyang on 2018/9/9.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "UITextView+myextend.h"
#import "Colors.h"


@implementation UITextView (myextend)


- (void)textColorWhite {
	self.textColor = UIColor.whiteColor;
}

- (void)textColorBlack {
	self.textColor = UIColor.blackColor;
}

- (void)textColorMain {
	self.textColor = Colors.textMain;
}


- (void)textColorPrimary {
	self.textColor = Colors.primary;
}

- (void)textColorSecondary {
	self.textColor = Colors.secondary;
}


@end