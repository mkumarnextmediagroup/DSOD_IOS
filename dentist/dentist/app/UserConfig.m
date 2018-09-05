//
// Created by entaoyang on 2018/8/31.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "UserConfig.h"
#import "Common.h"


NSUserDefaults *globalConfig() {
	return [NSUserDefaults standardUserDefaults];
}

NSUserDefaults *userConfig(NSString *userAccount) {
	if (userAccount == nil) {
		return globalConfig();
	}
	return [[NSUserDefaults alloc] initWithSuiteName:[userAccount base64Encoded]];
}

void putLastAccount(NSString *account) {
	NSUserDefaults *gd = globalConfig();
	[gd setObject:account forKey:@"lastAccount"];
}

NSString *getLastAccount() {
	NSUserDefaults *gd = globalConfig();
	NSString *s = [gd objectForKey:@"lastAccount"];
	return s;
}

NSString *getUserToken(NSString *account) {
	if (account == nil) {
		return nil;
	}
	NSUserDefaults *ud = userConfig(account);
	NSString *token = [ud objectForKey:@"token"];
	return token;
}

void putUserToken(NSString *account, NSString *token) {
	NSUserDefaults *ud = userConfig(account);
	[ud setObject:token forKey:@"token"];
}