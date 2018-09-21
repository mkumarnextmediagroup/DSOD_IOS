//
// Created by entaoyang on 2018/9/11.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "NSDate+myextend.h"


@implementation NSDate (myextend)


+ (NSDate *)dateBy:(NSInteger)year month:(NSInteger)month day:(NSInteger)day {
	NSCalendar *c = [NSCalendar currentCalendar];
	NSDateComponents *y = [NSDateComponents new];
	y.year = year;
	y.month = month;
	y.day = day;
	NSDate *date = [c dateFromComponents:y];
	return date;
}

- (NSString *)format:(NSString *)pattern {
	NSDateFormatter *fmt = [NSDateFormatter new];
	fmt.dateFormat = pattern;
	NSString *dateString = [fmt stringFromDate:self];
	return dateString;
}


- (NSInteger)year {
	NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:self];
	return [components year];
}

- (NSInteger)month {
	NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:self];
	return [components month];
}

- (NSInteger)day {
	NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDate:self];
	return [components day];
}

@end

extern long buildDateLong(NSInteger year, NSInteger month, NSInteger day) {
	NSCalendar *c = [NSCalendar currentCalendar];
	NSDateComponents *y = [NSDateComponents new];
	y.year = year;
	y.month = month;
	y.day = day;
	NSDate *date = [c dateFromComponents:y];
	NSTimeInterval tm = [date timeIntervalSince1970];
	return @(tm).longValue;
}