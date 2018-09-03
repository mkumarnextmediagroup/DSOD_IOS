//
// Created by entaoyang on 2018/8/31.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "UserConfig.h"


@implementation UserConfig {

}

+ (NSUserDefaults *)account:(NSString *)account {
	return [[NSUserDefaults alloc] initWithSuiteName:account];
}

+ (NSUserDefaults *)standard:(NSString *)account {
	return [NSUserDefaults standardUserDefaults];
}
@end