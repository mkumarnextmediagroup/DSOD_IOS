//
// Created by entaoyang on 2018/9/6.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "Experience.h"
#import "Common.h"
#import "NSDate+myextend.h"


@implementation Experience {

}

- (BOOL)isOwnerDentist {
	return [@"Owner Dentist" isEqualToString:self.praticeType];
}

- (NSString *)dateFrom {
	if (_fromMonth == 0) {
		return @"";
	}
	return strBuild(nameOfMonth(_fromMonth), @" ", [@(_fromYear) description]);
}

- (NSString *)dateTo {
	if (_toMonth == 0) {
		return @"";
	} else if (_toYear > [[NSDate date] year]) {
		return @"Present";
	}
	return strBuild(nameOfMonth(_toMonth), @" ", [@(_toYear) description]);
}

- (BOOL)useDSO {
	return self.praticeType != nil && [self.praticeType hasSuffix:@"Affiliated"];
}


@end
