//
// Created by entaoyang on 2018/9/6.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "Residency.h"
#import "Common.h"


@implementation Residency {

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
	}
	return strBuild(nameOfMonth(_toMonth), @" ", [@(_toYear) description]);
}
@end