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


@implementation Proto {
	NSString *SERVER;
}

+ (NSArray *)listArticle {
	Article *a = [Article new];
	a.id = 1;
	a.isSponsor = NO;
	a.publishDate = @"May 15,2018";
	a.gskString = @"Sponsored content brought to you by GSK";
	a.type = @"orthodontics";
	a.authAccount = @"tom@gmail.com";
	a.authName = @"Dr.Sandra Tai";
	a.authAdd = @"Vancouver, BC";
	a.title = @"Mastering the art of Dental Surgery  - Mastering the art of Dental Surgery - Mastering the art of Dental Surgery  ";
	a.content = @"Attachments are a critical part of treating patients with the Invisalign system. Proper placement of attachments helps ensure that the tooth movements occur as shown in the ClinCheck treatment plan and is an essential step in achieving the treatment outcomes you expect. \n"
	            "Taking care to place attachments properly at the outset of treatment will minimize bond failure and helps to reduce unnecessary costs to both doctors and patient as a result of lost attachments. Like all dental procedures, take time to show the patient where and how attachments will be placed and delay any concerns they may have.\n"
	            "Once you have completed the expectations with the patient the first step is to test the attachment template and the first aligner. This is an expert thinking process for you.";
    a.subContent = @"Please be sure to thoroughly dry the attachments template after testing for fit. Generally, it is recommended that when placing attachments, you work in on e arch of the patients' mouth at a time.\n"
    "If you have more than four attachments per quadrant, then you may decide to bond the attachments one quadrant at a time. If bonding one quadrant at a time, do not cut the attachment template.Instead, just fill one side of the attachment template with composite material."
    "Carefully apply the bonding agent and leave undistrubed for 10 seconds. If needed, use a cotton roll to prevent excess bonding agent from flowing unto interproximal spaces or tissue.Air dry within maximum pressure for 5 second until a thin adhesive film layer forms.";
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
	b.gskString = @"Sponsored content brought to you by GSK";
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

+ (NSArray *)listResidency {
	return @[
			@"Creighton University School of Dentistry",
			@"Howard University College of Dentistry",
			@"Indiana University School of Dentistry",
			@"LECOM College of Dental Medicine",
			@"Marquette University School of Dentistry",
			@"Meharry Medical College School of Dentistry",
			@"Missouri School of Dentistry and Oral Health",
			@"New York University College of Dentistry",
			@"Ohio State University College of Dentistry",
			@"Rutgers School of Dental Medicine",
			@"Texas A&M University College of Dentistry",
			@"University of Kentucky College of Dentistry",
	];
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

+ (NSArray *)listDentalNames {
	return @[
			@"Allied Dental",
			@"American Dental Partners",
			@"Aspen Dental Practice",
			@"Birner Dental",
			@"Dental Care Alliance",
			@"DentalOne Partners",
			@"Dental Practice Solutions",
			@"Great Expressions Dental",
			@"Heartland Dental Care",
			@"InterDent",
			@"Katsur Management Group",
			@"MB2  Dental Solutions",
	];
}


+ (NSArray *)listRoleAtPractice {
	return @[
			@"Owner Dentist",
			@"Associate Dentist",
			@"Dental Hygienist",
			@"Dental Assistant",
			@"Treatment Coordinator",
			@"Office Staff / Nonclinical",
	];
}

+ (NSArray *)listPracticeType {
	return @[
			@"Solo Practice",
			@"Small Group Practice - Affiliated",
			@"Small Group Practice - Unaffiliated",
			@"Large Group Practice - Affiliated",
			@"Large Group Practice - Unaffiliated",
			@"Nonprofit"
	];
}

+ (NSArray *)listSpeciality {
	return @[
			@"General Practitioner",
			@"Dental Public Health",
			@"Endodontics",
			@"Oral & Maxillofacial Pathology",
			@"Oral & Maxillofacial Radiology",
			@"Oral & Maxillofacial Surgery",
			@"Orthodontics",
			@"Pediatric Dentistry",
			@"Periodontics",
			@"Prosthodontics"
	];
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
	ui.isStudent = NO;
	ui.isLinkedinUser = YES;
	ui.fullName = @"Entao Yang";
	ui.phone = @"15098760059";
	ui.portraitUrl = @"http://app800.cn/i/p.png";
	ui.specialityId = @"100";
	ui.specialityLabel = @"Orthodontics";

	Address *addr = [Address new];
	addr.stateLabel = @"MA";
	addr.city = @"Boston";
	addr.address1 = @"45th Street";
	addr.address2 = @"124 Park Avenue";
	addr.zipCode = @"20230";
	ui.practiceAddress = addr;

	Education *edu = [Education new];
	edu.schoolName = @"Peiking University";
	edu.certificate = @"Doctor of Dental Surgery";
	edu.fromMonth = 7;
	edu.fromYear = 2015;
	edu.toMonth = 1;
	edu.toYear = 2017;
	Education *edu2 = [Education new];
	edu2.schoolName = @"Tsinghua University";
	edu2.certificate = @"Doctor of Dental Surgery";
	edu2.fromMonth = 7;
	edu2.fromYear = 2015;
	edu2.toMonth = 2;
	edu2.toYear = 2017;
	ui.educationArray = @[edu, edu2];

	Experience *exp = [Experience new];
	exp.praticeType = @"Owner Dentist";
	exp.dentalName = @"Smile Dental";
	exp.fromMonth = 7;
	exp.fromYear = 2015;
	exp.toMonth = 1;
	exp.toYear = 2017;

	Experience *exp2 = [Experience new];
	exp2.praticeType = @"Associate Dentist";
	exp2.dentalName = @"Smile Dental";
	exp2.fromMonth = 7;
	exp2.fromYear = 2015;
	exp2.toMonth = 1;
	exp2.toYear = 2017;

	ui.experienceArray = @[exp, exp2];


	Residency *r = [Residency new];
	r.place = @"Boston Hospital";
	r.fromMonth = 7;
	r.fromYear = 2015;
	r.toMonth = 1;
	r.toYear = 2017;

	ui.residencyArray = @[r];


	PersonInfo *pe1 = [PersonInfo new];
	pe1.infoLabel = @"Full name";
	PersonInfo *pe2 = [PersonInfo new];
	pe2.infoLabel = @"Speciality";
	ui.personInfoArray = @[pe1, pe2];

	UploadData *up = [UploadData new];
	up.uploadName = localStr(@"upResume");
	up.detailLabel = localStr(@"professional");
	UploadData *up1 = [UploadData new];
	up1.uploadName = localStr(@"import");
	up1.detailLabel = localStr(@"information");
	ui.uploadDataArray = @[up, up1];

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

+ (UserInfo *)lastUserInfo {
	return [self userInfo:[self lastAccount]];
}

+ (void)saveLastUserInfo:(UserInfo *)info {
	NSString *s = [info toJSONString];
	NSUserDefaults *d = userConfig([self lastAccount]);
	[d setObject:s forKey:@"userInfo"];
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
+ (HttpResult *)getProfileInfo {
	HttpResult *r = [self post2:@"userProfile/findOneByEmail" dic:@{@"email": getLastAccount()}];
	if (r.OK) {
	}
	return r;
}

//{
//	"code": 0,
//			"msg": "success",
//			"resultMap": {
//		"data": [
//				{
//						"id": "1",
//				"zip": "00501",
//				"lat": null,
//				"lng": null,
//				"city": "Holtsville",
//				"state": "NY",
//				"zcta": null,
//				"parent_zcta": null,
//				"pop": null,
//				"county_fips": null,
//				"county_name": null,
//				"county_weight": null,
//				"all_county_weights": null,
//				"imprecise": null,
//				"military": null
//				}
//		]
//	}
//}
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

//{
//	"code": 0,
//			"msg": "success",
//			"resultMap": {
//		"data": [
//						{
//								"id": "1",
//						"name": "A.T. Still University Arizona School of Dentistry and Oral Health"
//						},
//						{
//								"id": "2",
//						"name": "Boston University Goldman School of Dental Medicine"
//						},
+ (NSMutableArray <IdName *> *)queryDentalSchool:(NSString *)name {
	HttpResult *r = [self post2:@"dentalSchool/getAll" dic:@{@"name": name}];
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

	for (IdName *item in items) {
		NSLog(@"%d %@", item.id, item.name);
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


+ (NSArray<IdName *> *)queryPracticeTypes:(NSString *)name {
	HttpResult *r = [self post2:@"experience/findAllPracticeType" dic:@{@"name": name}];

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

+ (HttpResult *)uploadHeaderImage:(NSURL *)imageUrl {
	NSDictionary *d = @{@"File": imageUrl};
	HttpResult *r = [self post2:@"photoUpload" dic:d];
	if (r.OK) {
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


+ (HttpResult *)post2:(NSString *)action dic:(NSDictionary *)dic {
	NSString *baseUrl = @"http://dsod.aikontec.com/profile-service/v1/";
	Http *h = [Http new];
	h.url = strBuild(baseUrl, action);
	[h header:@"Authorization" value:strBuild(@"Bearer ", [self lastToken])];
	[h arg:@"client_id" value:@"fooClientIdPassword"];
	[h args:dic];
	HttpResult *r = [h multipart];
	return r;
}

@end
