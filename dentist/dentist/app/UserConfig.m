//
// Created by entaoyang on 2018/8/31.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <SAMKeychain/SAMKeychain.h>
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


void keychainPutPwd(NSString *account, NSString *pwd) {
	[SAMKeychain setPassword:pwd forService:@"dentistUser" account:account];
}

NSString *keychainGetPwd(NSString *account) {
	return [SAMKeychain passwordForService:@"dentistUser" account:account];
}

void putServerDomain(NSInteger value)
{
    NSUserDefaults *server = globalConfig();
    [server setObject:@(value) forKey:@"ServerDomain"];
    [server synchronize];
}

NSInteger getServerDomain() {
    NSUserDefaults *server = globalConfig();
    NSInteger value = [[server objectForKey:@"ServerDomain"] integerValue];
    return value;
}

