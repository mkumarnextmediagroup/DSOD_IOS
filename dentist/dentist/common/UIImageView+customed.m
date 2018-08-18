//
// Created by yet on 2018/8/18.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "UIImageView+customed.h"


@implementation UIImageView (customed)


- (NSString *)imageName {
	return @"";
}

- (void)setImageName:(NSString *)name {
	self.image = [UIImage imageNamed:name];
}

@end