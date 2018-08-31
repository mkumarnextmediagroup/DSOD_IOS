//
// Created by entaoyang on 2018/8/30.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "Proto.h"
#import "UserConfig.h"

#define CLIENT_ID @"fooClientIdPassword"


@implementation Proto {
}


//BAD  need old pwd
+ (HttpResult *)changePwd:(NSString *)email pwd:(NSString *)pwd {
	NSString *s = jsonBuild(@{@"userName": email, @"password": pwd, @"client_id": CLIENT_ID});
	return [self postBody:@"userAccount/updatePasswordByUserName" body:s];
}

//OK
+ (HttpResult *)resetPwd:(NSString *)email pwd:(NSString *)pwd code:(NSString *)code {
	NSString *s = jsonBuild(@{@"userName": email, @"password": pwd, @"email_token": code});
	return [self postBody:@"userAccount/resetPassWord" body:s];
}

//OK
+ (HttpResult *)sendEmailCode:(NSString *)email {
	NSString *s = strBuild(@"emailToken/sendEmail/", @"{email}".urlEncoded);
	return [self get:s key:@"email" param:email];
}

//OK
+ (HttpResult *)login:(NSString *)email pwd:(NSString *)pwd {
	NSString *s = jsonBuild(@{@"userName": email, @"password": pwd, @"client_id": CLIENT_ID});
	HttpResult *r = [self postBody:@"userAccount/login" body:s];
	if (r.OK) {
		NSDictionary *d = r.resultMap;
		if (d != nil) {
			NSUserDefaults *ud = [UserConfig account:email];
			NSString *token = d[@"accesstoken"];
			if (token != nil) {
				[ud setObject:token forKey:@"token"];
			} else {
				NSLog(@"ERROR : token is null on login success");
			}
		}
	}
	return r;
}

//OK
+ (HttpResult *)register:(NSString *)email pwd:(NSString *)pwd name:(NSString *)name {
	NSString *s = jsonBuild(@{@"username": email, @"password": pwd, @"full_name": name});
	return [self postBody:@"userAccount/register" body:s];
}

+ (HttpResult *)postBody:(NSString *)action body:(NSString *)body {
	NSString *baseUrl = @"http://dsod.aikontec.com/profile-service/v1/";
	Http *h = [Http new];
	h.url = strBuild(baseUrl, action);
	[h contentTypeJson];
	HttpResult *r = [h postRaw:body.dataUTF8];
	return r;
}

+ (HttpResult *)get:(NSString *)action key:(NSString *)key param:(NSString *)param {
	NSString *baseUrl = @"http://dsod.aikontec.com/profile-service/v1/";
	Http *h = [Http new];
//	h.url = strBuild(baseUrl, action, @"/", param.urlEncoded);
	h.url = strBuild(baseUrl, action);
	[h arg:key value:param];
	HttpResult *r = [h get];
	return r;
}


@end