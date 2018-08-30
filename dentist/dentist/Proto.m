//
// Created by entaoyang on 2018/8/30.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "Proto.h"


@implementation Proto {
	NSString *SERVER;
}

+ (HttpResult *)register:(NSString *)email pwd:(NSString *)pwd name:(NSString *)name {
	NSString *s = jsonBuild(@{@"full_name": name, @"password": pwd, @"username": email});
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


@end