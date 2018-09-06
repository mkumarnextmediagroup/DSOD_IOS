//
// Created by entaoyang on 2018/8/30.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "Proto.h"


@implementation Proto {
	NSString *SERVER;
}

+ (BOOL)isLogined {
	return [self lastToken] != nil;
}

+ (void)logout {
	NSString *account = getLastAccount();
	if (account != nil) {
		putUserToken(account, nil);
	}
}

+ (HttpResult *)resetPwd:(NSString *)email pwd:(NSString *)pwd code:(NSString *)code {
	return [self postBody:@"userAccount/resetPassWord" dic:@{@"username": email, @"password": pwd, @"email_token": code}];
}


+ (HttpResult *)sendEmailCode:(NSString *)email {
	return [self post:@"emailToken/sendEmail" dic:@{@"email": email}];
}

+ (HttpResult *)sendLinkedInInfo:(NSString *)access_token {
	return [self post:@"linkedInLogin" dic:@{@"accessToken": access_token}];
}


+ (NSString *)lastAccount {
	return getLastAccount();
}

+ (NSString *)lastToken {
	NSString *account = self.lastAccount;
	return getUserToken(account);
}

+ (HttpResult *)login:(NSString *)email pwd:(NSString *)pwd {
	HttpResult *r = [self postBody:@"userAccount/login" dic:@{@"username": email, @"password": pwd}];
	if (r.OK) {
		NSDictionary *d = r.resultMap;
		if (d != nil) {
			NSString *token = d[@"accesstoken"];
			putUserToken(email, token);
			putLastAccount(email);
		}
	}
	return r;
}

+ (HttpResult *)register:(NSString *)email pwd:(NSString *)pwd name:(NSString *)name student:(BOOL)student {
	NSNumber *stu = @(student);
	NSDictionary *d = @{@"username": email, @"password": pwd, @"full_name": name, @"student": stu};
	HttpResult *r = [self postBody:@"userAccount/register" dic:d];
	if (r.OK) {
		NSDictionary *d = r.resultMap;
		if (d != nil) {
			NSString *token = d[@"accesstoken"];
			putUserToken(email, token);
			putLastAccount(email);
		}
	}


	return r;
}

+ (HttpResult *)postBody:(NSString *)action dic:(NSDictionary *)dic {
	NSString *baseUrl = @"http://dsod.aikontec.com/profile-service/v1/";
	Http *h = [Http new];
	h.url = strBuild(baseUrl, action);
	[h contentTypeJson];

	NSMutableDictionary *md = [NSMutableDictionary dictionaryWithDictionary:dic];
	md[@"client_id"] = @"fooClientIdPassword";
	NSString *s = jsonBuild(md);
	HttpResult *r = [h postRaw:s.dataUTF8];
	return r;
}

+ (HttpResult *)get:(NSString *)action dic:(NSDictionary *)dic {
	NSString *baseUrl = @"http://dsod.aikontec.com/profile-service/v1/";
	Http *h = [Http new];
	h.url = strBuild(baseUrl, action);
	[h arg:@"client_id" value:@"fooClientIdPassword"];
	[h args:dic];
	HttpResult *r = [h get];
	return r;
}

+ (HttpResult *)post:(NSString *)action dic:(NSDictionary *)dic {
	NSString *baseUrl = @"http://dsod.aikontec.com/profile-service/v1/";
	Http *h = [Http new];
	h.url = strBuild(baseUrl, action);
	[h arg:@"client_id" value:@"fooClientIdPassword"];
	[h args:dic];
	HttpResult *r = [h post];
	return r;
}

@end
