//
// Created by entaoyang on 2018/8/30.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "Proto.h"
#import "UserInfo.h"
#import "JSONModel+myextend.h"


@implementation Proto {
	NSString *SERVER;
}


+ (UserInfo *)addExperience:(nonnull NSString *)email exp:(Experience *)exp {
	UserInfo *u = [self userInfo:email];
	if (u.experienceArray == nil) {
		u.experienceArray = @[exp];
	} else {
		NSMutableArray *a = [NSMutableArray arrayWithArray:u.experienceArray];
		[a addObject:exp];
		u.experienceArray = a;
	}
	[self saveUserInfoLocal:email info:[u toJSONString]];
	return [self userInfo:email];
}

+ (UserInfo *)saveExperience:(nonnull NSString *)email index:(int)index exp:(Experience *)exp {
	UserInfo *u = [self userInfo:email];
	NSMutableArray *a = [NSMutableArray arrayWithArray:u.experienceArray];
	a[index] = exp;
	u.experienceArray = a;
	[self saveUserInfoLocal:email info:[u toJSONString]];
	return [self userInfo:email];
}

+ (UserInfo *)addResidency:(nonnull NSString *)email residency:(Residency *)residency {
	UserInfo *u = [self userInfo:email];
	if (u.residencyArray == nil) {
		u.residencyArray = @[residency];
	} else {
		NSMutableArray *a = [NSMutableArray arrayWithArray:u.residencyArray];
		[a addObject:residency];
		u.residencyArray = a;
	}
	[self saveUserInfoLocal:email info:[u toJSONString]];
	return [self userInfo:email];
}

+ (UserInfo *)saveResidency:(nonnull NSString *)email index:(int)index residency:(Residency *)residency {
	UserInfo *u = [self userInfo:email];
	NSMutableArray *a = [NSMutableArray arrayWithArray:u.residencyArray];
	a[index] = residency;
	u.residencyArray = a;
	[self saveUserInfoLocal:email info:[u toJSONString]];
	return [self userInfo:email];
}

+ (UserInfo *)addEducation:(nonnull NSString *)email edu:(Education *)edu {
	UserInfo *u = [self userInfo:email];
	if (u.educationArray == nil) {
		u.educationArray = @[edu];
	} else {
		NSMutableArray *a = [NSMutableArray arrayWithArray:u.educationArray];
		[a addObject:edu];
		u.educationArray = a;
	}
	[self saveUserInfoLocal:email info:[u toJSONString]];
	return [self userInfo:email];
}

+ (UserInfo *)saveEducation:(nonnull NSString *)email index:(int)index edu:(Education *)edu {
	UserInfo *u = [self userInfo:email];
	NSMutableArray *a = [NSMutableArray arrayWithArray:u.educationArray];
	a[index] = edu;
	u.educationArray = a;
	[self saveUserInfoLocal:email info:[u toJSONString]];
	return [self userInfo:email];
}

+ (UserInfo *)savePractice:(nonnull NSString *)email address:(Address *)address {
	UserInfo *u = [self userInfo:email];
	u.practiceAddress = address;
	[self saveUserInfoLocal:email info:[u toJSONString]];
	return [self userInfo:email];
}

+ (UserInfo *)userInfo:(nonnull NSString *)email {

	NSString *json = [self userInfoLocal:email];
	if (json != nil) {
		return [[UserInfo alloc] initWithJson:json];
	}

	UserInfo *ui = [UserInfo alloc];
	ui.email = email;
	ui.fullName = @"Entao Yang";
	ui.phone = @"15098760059";
	ui.portraitUrl = nil;
	ui.specialityId = @"100";
	ui.specialityLabel = @"Orthodontics";

	Address *addr = [Address new];
	ui.practiceAddress = addr;

	addr.stateId = @"100";
	addr.stateLabel = @"New York";
	addr.city = @"New York";
	addr.address1 = @"XXX Street XXX ";
	addr.address2 = nil;

	Education *edu = [Education new];
	edu.schoolName = @"Peiking University";
	Education *edu2 = [Education new];
	edu2.schoolName = @"Tsinghua University";
	ui.educationArray = @[edu, edu2];

	NSString *s = [ui toJSONString];

	[self saveUserInfoLocal:email info:s];

	return ui;
}

+ (NSString *)userInfoLocal:(NSString *)email {
	NSUserDefaults *d = userConfig(email);
	NSString *json = [d objectForKey:@"userInfo"];
	return json;
};

+ (void)saveUserInfoLocal:(NSString *)email info:(NSString *)info {
	NSUserDefaults *d = userConfig(email);
	[d setObject:info forKey:@"userInfo"];
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
