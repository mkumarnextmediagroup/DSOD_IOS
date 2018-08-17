//
// Created by yet on 2018/8/17.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "UIView+customed.h"
#import "Masonry.h"


@implementation UIView (customed)


- (NSArray *)makeLayout:(void(^)(MASConstraintMaker *))block {
	self.translatesAutoresizingMaskIntoConstraints = NO;
	MASConstraintMaker *constraintMaker = [[MASConstraintMaker alloc] initWithView:self];
	block(constraintMaker);
	return [constraintMaker install];
}
@end