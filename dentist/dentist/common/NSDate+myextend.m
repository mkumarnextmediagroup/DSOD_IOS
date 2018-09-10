//
// Created by entaoyang on 2018/9/11.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "NSDate+myextend.h"


@implementation NSDate (myextend)

- (NSInteger)year {
	NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:self];
	return [components year];
}

- (NSInteger)month {
	NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:self];
	return [components month];
}
@end