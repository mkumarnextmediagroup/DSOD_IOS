//
// Created by entaoyang on 2018/8/30.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "Proto.h"
#import "UserInfo.h"
#import "JSONModel+myextend.h"
#import "Article.h"
#import "ArticleComment.h"
#import "IdName.h"
#import "StateCity.h"
#import "DiscussInfo.h"

@implementation Proto {
	NSString *SERVER;
}

+ (NSArray *)listArticle {
	Article *a = [Article new];
	a.id = 1;
	a.isSponsor = NO;
	a.publishDate = @"May 15,2018";
	a.gskString = @"  Sponsored content brought to you by GSK";
	a.type = @"orthodontics";
	a.authAccount = @"tom@gmail.com";
	a.authName = @"Dr.Sandra Tai";
	a.authAdd = @"Vancouver, BC";
	a.title = @"Mastering the art of Dental Surgery  - Mastering the art of Dental Surgery - Mastering the art of Dental Surgery  ";
	a.content = @"Attachments are a critical part of treating patients with the Invisalign system. Proper placement of attachments helps ensure that the tooth movements occur as shown in the ClinCheck treatment plan and is an essential step in achieving the treatment outcomes you expect. \n\n"
	            "Taking care to place attachments properly at the outset of treatment will minimize bond failure and helps to reduce unnecessary costs to both doctors and patient as a result of lost attachments. Like all dental procedures, take time to show the patient where and how attachments will be placed and delay any concerns they may have.\n\n"
	            "Once you have completed the expectations with the patient the first step is to test the attachment template and the first aligner. This is an expert thinking process for you.";
	a.subContent = @"Please be sure to thoroughly dry the attachments template after testing for fit. Generally, it is recommended that when placing attachments, you work in on e arch of the patients' mouth at a time.\n\n"
	               "If you have more than four attachments per quadrant, then you may decide to bond the attachments one quadrant at a time. If bonding one quadrant at a time, do not cut the attachment template.Instead, just fill one side of the attachment template with composite material.\n\n"
	               "Carefully apply the bonding agent and leave undistrubed for 10 seconds. If needed, use a cotton roll to prevent excess bonding agent from flowing unto interproximal spaces or tissue.Air dry within maximum pressure for 5 second until a thin adhesive film layer forms.";
	a.resImage = @"http://app800.cn/i/d.png";
	a.resType = @"image";

    DiscussInfo *dis = [DiscussInfo new];
    dis.disImg = @"http://app800.cn/i/p.png";
    dis.name = @"Matt Heafy rated it";
    dis.starCount = 4;
    dis.disDate = @"3 Jul,2017";
    dis.content = @"A wonderful experence reading up on the new trends of dental health.";
    
    DiscussInfo *dis2 = [DiscussInfo new];
    dis2.disImg = @"http://app800.cn/i/p.png";
    dis2.name = @"Amanda Brown rated it";
    dis2.starCount = 4;
    dis2.disDate = @"15 May,2017";
    dis2.content = @"A nice read! Will be sure to recommend this magazine to others.";
    
    DiscussInfo *dis3 = [DiscussInfo new];
    dis3.disImg = @"http://app800.cn/i/p.png";
    dis3.name = @"Gareth Bale rated it";
    dis3.starCount = 4;
    dis3.disDate = @"23 Apr,2017";
    dis3.content = @"Best dental health magazine I have read in my life. Would recommend reading it with something else to do dles make the aeddef";
    a.discussInfo = @[dis,dis2,dis3];
    
	ArticleComment *c = [ArticleComment new];
	c.articleId = 100;
	c.authAccount = @"peter@gmail.com";
	c.authName = @"Peter";
	c.authPortrait = @"http://app800.cn/i/p.png";
	c.rate = 3;
	c.content = @"Good !";
	c.publishDate = @"Sep 16, 2018";

	a.comments = @[c];


	Article *b = [Article new];
	b.id = 1;
	b.isSponsor = NO;
	b.publishDate = @"May 15,2018";
	b.gskString = @"  Sponsored content brought to you by GSK";
	b.type = @"orthodontics";
	b.authAccount = @"tom@gmail.com";
	b.authName = @"Dr.Sandra Tai";
	b.authAdd = @"Vancouver, BC";
	b.title = @"Mastering the art of Dental Surgery";
	b.content = @"Attachments are a critical part of treating patients with the Invisalign system. Proper placement of attachments helps ensure that the tooth movements occur as shown in the ClinCheck treatment plan and is an essential step in achieving the treatment outcomes you expect. \n"
	            "Taking care to place attachments properly at the outset of treatment will minimize bond failure and helps to reduce unnecessary costs to both doctors and patient as a result of lost attachments. Like all dental procedures, take time to show the patient where and how attachments will be placed and delay any concerns they may have.\n"
	            "Once you have completed the expectations with the patient the first step is to test the attachment template and the first aligner. This is an expert thinking process for you.";
	b.resImage = @"http://app800.cn/i/d.png";
	b.resType = @"image";

    DiscussInfo *disb = [DiscussInfo new];
    disb.disImg = @"http://app800.cn/i/p.png";
    disb.name = @"Matt Heafy rated it";
    disb.starCount = 4;
    disb.disDate = @"3 Jul,2017";
    disb.content = @"A wonderful experence reading up on the new trends of dental health.";
    
    DiscussInfo *disb2 = [DiscussInfo new];
    disb2.disImg = @"http://app800.cn/i/p.png";
    disb2.name = @"Amanda Brown rated it";
    disb2.starCount = 4;
    disb2.disDate = @"15 May,2017";
    disb2.content = @"A nice read! Will be sure to recommend this magazine to others.";
    
    DiscussInfo *disb3 = [DiscussInfo new];
    disb3.disImg = @"http://app800.cn/i/p.png";
    disb3.name = @"Gareth Bale rated it";
    disb3.starCount = 4;
    disb3.disDate = @"23 Apr,2017";
    disb3.content = @"Best dental health magazine I have read in my life. Would recommend reading it with something else to do dles make the aeddef";
    b.discussInfo = @[disb,disb2,disb3];
    
	ArticleComment *bc = [ArticleComment new];
	bc.articleId = 100;
	bc.authAccount = @"peter@gmail.com";
	bc.authName = @"Peter";
	bc.authPortrait = @"http://app800.cn/i/p.png";
	bc.rate = 3;
	bc.content = @"Good !";
	bc.publishDate = @"Sep 16, 2018";

	b.comments = @[bc];

	NSArray *arr = @[a, b];
	return arr;
}


+ (Article *)getArticleInfo {
	Article *a = [Article new];
	a.id = 1;
	a.isSponsor = NO;
	a.publishDate = @"May 15,2018";

	a.gskString = @"Sponsored content brought to you by GSK";
	a.type = @"orthodontics";
	a.authAccount = @"tom@gmail.com";
	a.authName = @"Dr.Sandra Tai";
	a.title = @"Mastering the art of Dental Surgery  - Mastering the art of Dental Surgery - Mastering the art of Dental Surgery  ";
	a.content = @"Attachments are a critical part of treating patients with the Invisalign system. Proper placement of attachments helps ensure that the tooth movements occur as shown in the ClinCheck treatment plan and is an essential step in achieving the treatment outcomes you expect. \n"
	            "Taking care to place attachments properly at the outset of treatment will minimize bond failure and helps to reduce unnecessary costs to both doctors and patient as a result of lost attachments. Like all dental procedures, take time to show the patient where and how attachments will be placed and delay any concerns they may have.\n"
	            "Once you have completed the expectations with the patient the first step is to test the attachment template and the first aligner. This is an expert thinking process for you.";
	a.resImage = @"http://app800.cn/i/d.png";
	a.resType = @"image";

	ArticleComment *c = [ArticleComment new];
	c.articleId = 100;
	c.authAccount = @"peter@gmail.com";
	c.authName = @"Peter";
	c.authPortrait = @"http://app800.cn/i/p.png";
	c.rate = 3;
	c.content = @"Good !";
	c.publishDate = @"Sep 16, 2018";

	a.comments = @[c];

	return a;
}

+ (NSArray *)listBookmark {
    Article *a = [Article new];
    a.id = 1;
    a.isSponsor = NO;
    a.publishDate = @"May 15,2018";
    
    a.type = @"orthodontics";
    a.authAccount = @"tom@gmail.com";
    a.authName = @"Dr.Sandra Tai";
    a.title = @"Mastering the art of Dental Surgery  - Mastering the art of Dental Surgery - Mastering the art of Dental Surgery  ";
    a.content = @"Attachments are a critical part of treating patients with the Invisalign system. Proper placement of attachments helps ensure that the tooth movements occur as shown in the ClinCheck treatment plan and is an essential step in achieving the treatment outcomes you expect. \n"
    "Taking care to place attachments properly at the outset of treatment will minimize bond failure and helps to reduce unnecessary costs to both doctors and patient as a result of lost attachments. Like all dental procedures, take time to show the patient where and how attachments will be placed and delay any concerns they may have.\n"
    "Once you have completed the expectations with the patient the first step is to test the attachment template and the first aligner. This is an expert thinking process for you.";
    a.resImage = @"http://app800.cn/i/d.png";
    a.resType = @"image";
    
    ArticleComment *c = [ArticleComment new];
    c.articleId = 100;
    c.authAccount = @"peter@gmail.com";
    c.authName = @"Peter";
    c.authPortrait = @"http://app800.cn/i/p.png";
    c.rate = 3;
    c.content = @"Good !";
    c.publishDate = @"Sep 16, 2018";
    
    a.comments = @[c];
    
    
    Article *b = [Article new];
    b.id = 1;
    b.isSponsor = NO;
    b.publishDate = @"May 15,2018";
    
    b.type = @"orthodontics";
    b.authAccount = @"tom@gmail.com";
    b.authName = @"Dr.Sandra Tai";
    b.title = @"Mastering the art of Dental Surgery";
    b.content = @"Attachments are a critical part of treating patients with the Invisalign system. Proper placement of attachments helps ensure that the tooth movements occur as shown in the ClinCheck treatment plan and is an essential step in achieving the treatment outcomes you expect. \n"
    "Taking care to place attachments properly at the outset of treatment will minimize bond failure and helps to reduce unnecessary costs to both doctors and patient as a result of lost attachments. Like all dental procedures, take time to show the patient where and how attachments will be placed and delay any concerns they may have.\n"
    "Once you have completed the expectations with the patient the first step is to test the attachment template and the first aligner. This is an expert thinking process for you.";
    b.resImage = @"http://app800.cn/i/d.png";
    b.resType = @"image";
    
    ArticleComment *bc = [ArticleComment new];
    bc.articleId = 100;
    bc.authAccount = @"peter@gmail.com";
    bc.authName = @"Peter";
    bc.authPortrait = @"http://app800.cn/i/p.png";
    bc.rate = 3;
    bc.content = @"Good !";
    bc.publishDate = @"Sep 16, 2018";
    
    b.comments = @[bc];
    
    NSArray *arr = @[a, b];
    return arr;
}

+ (NSArray *)shortStates {
	return @[
			@"AL",
			@"AK",
			@"AZ",
			@"AR",
			@"CA",
			@"CO",
			@"CT",
			@"DE",
			@"FL",
			@"GA",
			@"HI",
			@"ID",
			@"IL",
			@"IN",
			@"IA",
			@"KS",
			@"KY",
			@"LA",
			@"ME",
			@"MD",
			@"MA",
			@"MI",
			@"MN",
			@"MS",
			@"MO",
			@"MT",
			@"NE",
			@"NV",
			@"NH",
			@"NJ",
			@"NM",
			@"NY",
			@"NC",
			@"ND",
			@"OH",
			@"OK",
			@"OR",
			@"PA",
			@"RI",
			@"SC",
			@"SD",
			@"TN",
			@"TX",
			@"UT",
			@"VT",
			@"VA",
			@"WA",
			@"WV",
			@"WI",
			@"WY",
	];
}

+ (NSArray *)listStates {
	return @[
			@"Alabama",
			@"Alaska",
			@"Arizona",
			@"Arkansas",
			@"Califonia",
			@"Colorado",
			@"Connecticut",
			@"Delaware",
			@"Florida",
			@"Georigia",
			@"Hawaii",
			@"Idaho",
			@"Illinois",
			@"Indiana",
			@"Iowa",
			@"Kansas",
			@"Kentucky",
			@"Louisiana",
			@"Maine",
			@"Maryland",
			@"Massachusetts",
			@"Michigan",
			@"Minnesota",
			@"Mississippi",
			@"Missouri",
			@"Montana",
			@"Nebraska",
			@"Nevada",
			@"New Hampshire",
			@"New Jersey",
			@"New Mexico",
			@"New York",
			@"North Carolina",
			@"North Dakota",
			@"Ohio",
			@"Oklahoma",
			@"Oregon",
			@"Pennsylvania",
			@"Rhode Island",
			@"South Carolina",
			@"South Dakota",
			@"Tennessee",
			@"Texas",
			@"Utah",
			@"Vermont",
			@"Virginia",
			@"Washington",
			@"West Virginia",
			@"Wisconsin",
			@"Wyoming",
	];
}


+ (UserInfo *)userInfo:(nonnull NSString *)email {
	UserInfo *ui = [UserInfo new];
	NSString *json = [self userInfoLocal:email];
	if (json != nil) {
		NSDictionary *d = [NSMutableDictionary dictionaryWithDictionary:jsonParse(json)];
		[ui fromDic:d];
	} else {
		[ui fromDic:@{}];
	}
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

+ (UserInfo *)lastUserInfo {
	return [self userInfo:[self lastAccount]];
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
	NSString *url = [NSString stringWithFormat:@"linkedInLogin/%@/fooClientIdPassword", access_token];
	return [self get:url dic:nil];
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
			NSLog(@"Login Success: lastAccount = %@ lastToken:= %@ ", getLastAccount(), [self lastToken]);
		}
	}
	return r;
}

+ (void)linkedinLogin:(NSString *)token userid:(NSString *)userid {
	putUserToken(userid, token);
	putLastAccount(userid);
}

+ (HttpResult *)register:(NSString *)email pwd:(NSString *)pwd name:(NSString *)name student:(BOOL)student {
	NSString *stu = @"0";
	if (student) {
		stu = @"1";
	}

	NSDictionary *d = @{@"username": email, @"password": pwd, @"full_name": name, @"is_student": stu, @"is_linkedin": @"0"};
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

+ (HttpResult *)saveProfileInfo:(NSDictionary *)dic {
	HttpResult *r = [self postBody:@"userProfile/save" dic:dic];
	if (r.OK) {
		[self getProfileInfo];
	}
	return r;
}

//{
//	"code": 0,
//			"msg": "success",
//			"resultMap": {
//		"data": {
//			"id": "bd0612c7a2dc46b1a6189c66e4030ee2",
//					"full_name": "Entao Yang",
//					"email": "entaoyang@163.com",
//					"photo_url": null,
//					"resume_url": null,
//					"phone": null,
//					"sex": null,
//					"street_address": null,
//					"city": null,
//					"state": null,
//					"zip": null,
//					"create_time": 1535619710731,
//					"status": null,
//					"residency_id": null,
//					"dental_school_id": null,
//					"is_student": null,
//					"is_linkedin": null,
//					"educations": [],
//					"experiences": [],
//					"profileResidency": [],
//					"practiceAddress": null,
//					"photo_album": null,
//					"document_library": null
//		}
//	}
//}
+ (NSDictionary *)getProfileInfo {
	HttpResult *r = [self post2:@"userProfile/findOneByEmail" dic:@{@"email": getLastAccount()}];
	if (r.OK) {
		NSDictionary *d = r.resultMap[@"data"];
		if (d) {
			[self saveUserInfoLocal:[self lastAccount] info:jsonBuild(d)];
		}
		return d;
	}
	return nil;
}


+ (nullable StateCity *)getStateAndCity:(NSString *)zipCode {
	HttpResult *r = [self post2:@"usZipSv/findAllusZipSvByZip" dic:@{@"zip": zipCode}];
	if (r.OK) {
		NSDictionary *d = r.resultMap;
		if (d) {
			NSArray *arr = d[@"data"];
			if (arr && arr.count > 0) {
				NSDictionary *dd = arr[0];
				StateCity *item = [StateCity new];
				item.state = dd[@"state"];
				item.city = dd[@"city"];
				return item;
			}
		}
	}
	return nil;
}

+ (NSMutableArray <IdName *> *)querySpecialty {
	HttpResult *r = [self post2:@"residencySpecialty/findAllSpecialty" dic:@{}];
	NSMutableArray <IdName *> *items = [NSMutableArray arrayWithCapacity:32];
	if (r.OK) {
		NSDictionary *m = r.resultMap;
		if (m) {
			NSArray *arr = m[@"data"];
			for (NSDictionary *d in arr) {
				IdName *item = [[IdName alloc] initWithJson:jsonBuild(d)];
				[items addObject:item];
			}
		}
	}
	return items;
}


+ (NSMutableArray <IdName *> *)queryDentalSchool {
	HttpResult *r = [self post2:@"dentalSchool/getAll" dic:@{@"name": @""}];
	NSMutableArray <IdName *> *items = [NSMutableArray arrayWithCapacity:32];
	if (r.OK) {
		NSDictionary *m = r.resultMap;
		if (m) {
			NSArray *arr = m[@"data"];
			for (NSDictionary *d in arr) {
				IdName *item = [[IdName alloc] initWithJson:jsonBuild(d)];
				[items addObject:item];
			}
		}
	}
	return items;
}

//{"code":0,"msg":"success","resultMap":{"data":[{"id":"1","name":"Allied Dental"},{"id":"10","name":"InterDent"},{"id":"11","name":"Katsur Management Group"},{"id":"2","name":"American Dental Partners"},{"id":"3","name":"Aspen Dental Practice"},{"id":"4","name":"Birner Dental"},{"id":"5","name":"Dental Care Alliance"},{"id":"6","name":"Dental One Partners"},{"id":"7","name":"Dental Practice Solutions"},{"id":"8","name":"Freat Expressions Dental"},{"id":"9","name":"Heartland Dental Care"}]}}
+ (NSArray<IdName *> *)queryPracticeDSO:(NSString *)name {
	HttpResult *r = [self post2:@"experience/findAllPracticeDSO" dic:@{@"name": name}];

	NSMutableArray *resultArray = [NSMutableArray arrayWithCapacity:30];
	if (r.OK) {
		NSArray *arr = r.resultMap[@"data"];
		for (NSDictionary *d in arr) {
			IdName *item = [[IdName alloc] initWithJson:jsonBuild(d)];
			[resultArray addObject:item];
		}
	}
	return resultArray;
}

//{"code":0,"msg":"success","resultMap":{"data":[{"id":"1","name":"Owner Dentist"},{"id":"2","name":"Associate Dentist"},{"id":"3","name":"Dental Hygienist"},{"id":"4","name":"Dental Assistant"},{"id":"5","name":"Treatment Coordinator"},{"id":"6","name":"Office Staff / Nonclinical"}]}}
+ (NSArray<IdName *> *)queryPracticeRoles:(NSString *)name {
	HttpResult *r = [self post2:@"experience/findAllPracticeRole" dic:@{@"name": name}];

	NSMutableArray *resultArray = [NSMutableArray arrayWithCapacity:30];
	if (r.OK) {
		NSArray *arr = r.resultMap[@"data"];
		for (NSDictionary *d in arr) {
			IdName *item = [[IdName alloc] initWithJson:jsonBuild(d)];
			[resultArray addObject:item];
		}
	}
	return resultArray;
}


+ (NSArray<IdName *> *)queryPracticeTypes {
	HttpResult *r = [self post2:@"experience/findAllPracticeType" dic:@{@"name": @""}];

	NSMutableArray *resultArray = [NSMutableArray arrayWithCapacity:30];
	if (r.OK) {
		NSArray *arr = r.resultMap[@"data"];
		for (NSDictionary *d in arr) {
			IdName *item = [[IdName alloc] initWithJson:jsonBuild(d)];
			[resultArray addObject:item];
		}
	}
	return resultArray;
}

+ (NSString *)uploadHeaderImage:(NSString *)localFilePath {
	HttpResult *r = [self upload:@"photoUpload" localFilePath:localFilePath];
	if (r.OK) {
		//{"photoName":"5d7a4a76219e4c78b2b4656cf4bc80f2_test.png"}
		id v = r.resultMap[@"photoName"];
		if (v == nil || v == NSNull.null) {
			return nil;
		}
		return v;
	}
	return nil;
}


+ (HttpResult *)postBody:(NSString *)action dic:(NSDictionary *)dic {
	NSString *baseUrl = @"http://dsod.aikontec.com/profile-service/v1/";
	Http *h = [Http new];
	h.url = strBuild(baseUrl, action);
	[h contentTypeJson];
	NSString *token = [self lastToken];
	if (token != nil) {
		[h header:@"Authorization" value:strBuild(@"Bearer ", token)];
	}

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
	NSString *token = [self lastToken];
	if (token != nil) {
		[h header:@"Authorization" value:strBuild(@"Bearer ", token)];
	}
	HttpResult *r = [h get];
	return r;
}

+ (HttpResult *)post:(NSString *)action dic:(NSDictionary *)dic {
	NSString *baseUrl = @"http://dsod.aikontec.com/profile-service/v1/";
	Http *h = [Http new];
	h.url = strBuild(baseUrl, action);
	[h arg:@"client_id" value:@"fooClientIdPassword"];
	[h args:dic];
	NSString *token = [self lastToken];
	if (token != nil) {
		[h header:@"Authorization" value:strBuild(@"Bearer ", token)];
	}
	HttpResult *r = [h post];
	return r;
}


+ (HttpResult *)post2:(NSString *)action dic:(NSDictionary *)dic {
	NSString *baseUrl = @"http://dsod.aikontec.com/profile-service/v1/";
	Http *h = [Http new];
	h.url = strBuild(baseUrl, action);
	NSString *token = [self lastToken];
	if (token != nil) {
		[h header:@"Authorization" value:strBuild(@"Bearer ", token)];
	}
	[h arg:@"client_id" value:@"fooClientIdPassword"];
	[h args:dic];
	HttpResult *r = [h multipart];
	return r;
}

+ (HttpResult *)upload:(NSString *)action localFilePath:(NSString *)localFilePath {
	NSString *baseUrl = @"http://dsod.aikontec.com/profile-service/v1/";
	Http *h = [Http new];
	h.timeout = 20;
	h.url = strBuild(baseUrl, action);
	NSString *token = [self lastToken];
	if (token != nil) {
		[h header:@"Authorization" value:strBuild(@"Bearer ", token)];
	}
	[h arg:@"client_id" value:@"fooClientIdPassword"];
	[h file:@"file" value:localFilePath];
	HttpResult *r = [h multipart];
	return r;
}

@end
