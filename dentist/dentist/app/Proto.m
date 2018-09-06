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
	NSString *s = jsonBuild(@{@"userName": email, @"password": pwd, @"email_token": code});
	return [self postBody:@"" body:s];
}


+ (HttpResult *)sendEmailCode:(NSString *)email {
	return [self get:@"emailtoken/sendEmail" key:@"email" param:email];
}

+ (HttpResult *)sendLinkedInInfo:(NSString *)access_token {
	return [self get:@"linkedInLogin" key:@"accessToken" param:access_token];
}


+ (NSString *)lastAccount {
	return getLastAccount();
}

+ (NSString *)lastToken {
	NSString *account = self.lastAccount;
	return getUserToken(account);
}

+ (HttpResult *)login:(NSString *)email pwd:(NSString *)pwd {
	NSString *s = jsonBuild(@{@"username": email, @"password": pwd});
	HttpResult *r = [self postBody:@"userAccount/login" body:s];
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
	NSString *s = jsonBuild(@{@"username": email, @"password": pwd, @"full_name": name, @"student": stu});
	return [self postBody:@"userAccount/register" body:s];
}

+ (HttpResult *)postBody:(NSString *)action
                    body:
		                    (NSString *)body {
	NSString *baseUrl = @"http://dsod.aikontec.com/profile-service/v1/";
	Http *h = [Http new];
	h.url = strBuild(baseUrl, action);
	[h contentTypeJson];

	NSDictionary *d = jsonParse(body);
	NSMutableDictionary *md = [NSMutableDictionary dictionaryWithDictionary:d];
	md[@"client_id"] = @"fooClientIdPassword";
	NSString *s = jsonBuild(md);
	HttpResult *r = [h postRaw:s.dataUTF8];
	return r;
}

+ (HttpResult *)get:(NSString *)action
                key:
		                (NSString *)key
              param:
		              (NSString *)param {
	NSString *baseUrl = @"http://dsod.aikontec.com/profile-service/v1/";
	Http *h = [Http new];
	h.url = strBuild(baseUrl, action, @"/", param.urlEncoded, @"/", @"fooClientIdPassword");
//	h.url = strBuild(baseUrl, action);
//    [h arg:key value:param];
	HttpResult *r = [h get];
	return r;
}


@end
