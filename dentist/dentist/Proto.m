//
// Created by entaoyang on 2018/8/30.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "Proto.h"


@implementation Proto {
	NSString *SERVER;
}

+ (HttpResult *)resetPwd:(NSString *)email pwd:(NSString *)pwd code:(NSString *)code {
	NSString *s = jsonBuild(@{@"userName": email, @"password": pwd, @"email_token": code});
	return [self postBody:@"" body:s];
}


+ (HttpResult *)sendEmailCode:(NSString *)email {
	return [self get:@"emailtoken/sendEmail" key:@"email" param:email];
}


+ (HttpResult *)login:(NSString *)email pwd:(NSString *)pwd {
	NSString *s = jsonBuild(@{@"userName": email, @"password": pwd});
	return [self postBody:@"userAccount/login" body:s];
}

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
	h.url = strBuild(baseUrl, action, @"/", param.urlEncoded);
//	h.url = strBuild(baseUrl, action);
//	[h arg:key value:param];
	HttpResult *r = [h get];
	return r;
}


@end