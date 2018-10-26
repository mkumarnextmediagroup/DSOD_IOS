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
#import "CMSModel.h"
#import "StateCity.h"
#import "DiscussInfo.h"
#import "DetailModel.h"

//测试模拟数据
#define CMSARTICLELIST @"CMSBOOKMARKLIST"
#define CMSBOOKMARKLIST @"CMSBOOKMARKLIST"
#define CMSDOWNLOADLIST @"CMSDOWNLOADLIST"
@implementation Proto {
	NSString *SERVER;
}

+ (NSArray *)listArticle {
	Article *a = [Article new];
	a.id = 1;
	a.isSponsor = NO;
	a.publishDate = @"May 15,2018";
	a.gskString = @"  Sponsored content brought to you by GSK";
	a.type = @"ORTHODONTICS";
	a.authAccount = @"tom@gmail.com";
	a.authName = @"Dr.Sandra Tai";
	a.authAdd = @"Vancouver, BC";
	a.title = @"Mastering the art of Dental Surgery  - Mastering the art of Dental Surgery - Mastering the art of Dental Surgery ";
	a.content = @"Attachments are a critical part of treating patients with the Invisalign system. Proper placement of attachments helps ensure that the tooth movements occur as shown in the ClinCheck treatment plan and is an essential step in achieving the treatment outcomes you expect. \n\n"
	            "Taking care to place attachments properly at the outset of treatment will minimize bond failure and helps to reduce unnecessary costs to both doctors and patient as a result of lost attachments. Like all dental procedures, take time to show the patient where and how attachments will be placed and delay any concerns they may have.\n\n"
	            "Once you have completed the expectations with the patient the first step is to test the attachment template and the first aligner. This is an expert thinking process for you.";
	a.subContent = @"Please be sure to thoroughly dry the attachments template after testing for fit. Generally, it is recommended that when placing attachments, you work in one arch of the patients' mouth at a time.\n\n"
	               "If you have more than four attachments per quadrant, then you may decide to bond the attachments one quadrant at a time. If bonding one quadrant at a time, do not cut the attachment template.Instead, just fill one side of the attachment template with composite material.\n\n"
	               "Carefully apply the bonding agent and leave undistrubed for 10 seconds. If needed, use a cotton roll to prevent excess bonding agent from flowing unto interproximal spaces or tissue.Air dry within maximum pressure for 5 seconds until a thin adhesive film layer forms.";
    a.resImage = @"https://wp.dsodentist.com/wp-content/uploads/2018/09/CA_INVI_D5_T_IOSIM_APAC_0029_rt2_HR_RGB_1280-e1537471186604.jpg";//@"http://app800.cn/i/d.png";
	a.resType = @"image";
    a.categoryName=@"LATEST";

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
	b.id = 2;
	b.isSponsor = NO;
	b.publishDate = @"May 15,2018";
	b.gskString = @"  Sponsored content brought to you by GSK";
	b.type = @"DSOs";
	b.authAccount = @"tom@gmail.com";
	b.authName = @"Dr.Sandra Tai";
	b.authAdd = @"Vancouver, BC";
	b.title = @"Be a Leader in Your DSO-Supported Practice ";
    b.content = @"Being the boss is not always easy, but it is rewarding once you become an effective leader. There are certain principles to good leadership, and if you follow them diligently, you will reach your full potential. This blog post features five recommendations for being a leader in your DSO-supported practice.\nYou are the CEO in your practice. Dentists, whether they are seasoned professionals or new grads, are ultimately responsible for the success of their practice. This is a huge responsibility. You are now responsible for the overall quality of care, patient satisfaction, and the livelihood of employees who are trying to provide for their families. Many dentists today are delegating some of the day-to-day responsibilities to a Dental Support Organization (DSO), but without you, the practice would grind to a halt.\nBeing an effective CEO in a DSO-supported practice is similar to being a general contractor for building a house. The following are typical responsibilities that must be addressed by a CEO.";
    b.resImage = @"https://wp.dsodentist.com/wp-content/uploads/2018/09/bigstock-126488318-e1539282816569.jpg";//@"http://app800.cn/i/d.png";
	b.resType = @"image";
    b.categoryName=@"LATEST";

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
    
    //
    NSInteger articleid3=3;
    NSString *title3=@"Immediate Dentures - Mastering the art of Dental Surgery - Mastering the art of Dental Surgery  ";
    NSString *content3=@"Patients will generally experience up to a 32% horizontal decrease of their alveolar hard tissue within 3 months of tooth extraction.¹ Further, after a tooth extraction, bone resorption is generally hastened, and the soft tissues may undergo changes as well. This is relevant to the patient receiving immediate dentures because any changes in the underpinning upon which the dentures are fitted will lead to diminished retention, and therefore rebasing.²\nAdvantages of immediate dentures:\nThe dental professional and the patient have the opportunity to first match the color, size, and shape of the soon-to-be dentures to the existing teeth";
    NSString *subContent3=@"Please be sure to thoroughly dry the attachments template after testing for fit. Generally, it is recommended that when placing attachments, you work in one arch of the patients' mouth at a time.\n\n"
    "If you have more than four attachments per quadrant, then you may decide to bond the attachments one quadrant at a time. If bonding one quadrant at a time, do not cut the attachment template.Instead, just fill one side of the attachment template with composite material.\n\n"
    "Carefully apply the bonding agent and leave undistrubed for 10 seconds. If needed, use a cotton roll to prevent excess bonding agent from flowing unto interproximal spaces or tissue.Air dry within maximum pressure for 5 seconds until a thin adhesive film layer forms.";
    
    NSString *publishDate3=@"May 02,2018";
    NSString *category3=@"LATEST";
    NSString *type3=@"General Dentistry";
    NSString *resImage3=@"https://wp.dsodentist.com/wp-content/uploads/2018/09/Endentulous-E3-Lead-Image-e1537458427743.jpg";
    Article *a3=[self setNewArtcle:articleid3 title:title3 content:content3 subContent:subContent3 publishDate:publishDate3 category:category3 type:type3 resImage:resImage3];
    
    NSInteger articleid4=4;
    NSString *title4=@"Interproximal Reduction (IPR) - Mastering the art of Dental Surgery";
    NSString *content4=@"DSOD Staff- Interproximal Reduction, also abbreviated as IPR, is a spacing technique that removes the interproximal enamel to reduce the mesial-distal size of teeth. It strives to create space so teeth can move into their proper positions while preserving the natural shape of each tooth. Doctors can visualize IPR through the ClinCheck® software to ensure treatment is progressing as desired and make adjustments before and during Invisalign® treatment.  ";
    NSString *subContent4=@"Please be sure to thoroughly dry the attachments template after testing for fit. Generally, it is recommended that when placing attachments, you work in one arch of the patients' mouth at a time.\n\n"
    "If you have more than four attachments per quadrant, then you may decide to bond the attachments one quadrant at a time. If bonding one quadrant at a time, do not cut the attachment template.Instead, just fill one side of the attachment template with composite material.\n\n"
    "Carefully apply the bonding agent and leave undistrubed for 10 seconds. If needed, use a cotton roll to prevent excess bonding agent from flowing unto interproximal spaces or tissue.Air dry within maximum pressure for 5 seconds until a thin adhesive film layer forms.";
    
    NSString *publishDate4=@"Oct 02,2018";
    NSString *category4=@"VIDEOS";
    NSString *type4=@"ORTHODONTICS";
    NSString *resImage4=@"https://wp.dsodentist.com/wp-content/uploads/2018/09/EruptionCompensationFeatures_CloseUp_Gray_RGB_640-e1539635942274.jpg";
    Article *a4=[self setNewArtcle:articleid4 title:title4 content:content4 subContent:subContent4 publishDate:publishDate4 category:category4 type:type4 resImage:resImage4];
    
    NSInteger articleid5=5;
    NSString *title5=@"Platelet-Rich Fibrin: The 411";
    NSString *content5=@" - Platelet-rich fibrin, or PRF, was introduced in oral surgery almost 20 years ago as a wound-healing enhancer. PRF is a mixture of fibrin matrix, cells (platelets, red blood cells, and leukocytes), and bioactive molecules (growth factors and cytokines), that are released to stimulate repair and regeneration. It is obtained from the patient’s own blood, collected before the surgical procedure, and centrifuged under specific conditions. PRF has been further developed into advanced (a-PRF) and injectable (i-PRF) forms by changing the preparation protocol to incorporate more monocytes.";
    NSString *subContent5=@"Please be sure to thoroughly dry the attachments template after testing for fit. Generally, it is recommended that when placing attachments, you work in one arch of the patients' mouth at a time.\n\n"
    "If you have more than four attachments per quadrant, then you may decide to bond the attachments one quadrant at a time. If bonding one quadrant at a time, do not cut the attachment template.Instead, just fill one side of the attachment template with composite material.\n\n"
    "Carefully apply the bonding agent and leave undistrubed for 10 seconds. If needed, use a cotton roll to prevent excess bonding agent from flowing unto interproximal spaces or tissue.Air dry within maximum pressure for 5 seconds until a thin adhesive film layer forms.";
    
    NSString *publishDate5=@"Oct 12,2018";
    NSString *category5=@"ARTICLES";
    NSString *type5=@"IMPLANT DENTISTRY";
    NSString *resImage5=@"https://wp.dsodentist.com/wp-content/uploads/2018/09/iStock-852114758.jpg";
    Article *a5=[self setNewArtcle:articleid5 title:title5 content:content5 subContent:subContent5 publishDate:publishDate5 category:category5 type:type5 resImage:resImage5];
    
	NSArray *arr = @[a, b,a3,a4,a5];
	return arr;
}


+(Article *)setNewArtcle:(NSInteger)articleid title:(NSString *)title content:(NSString *)content subContent:(NSString *)subContent publishDate:(NSString *)publishDate category:(NSString *)category type:(NSString *)type resImage:(NSString *)resImage
{
    Article *a = [Article new];
    a.id = articleid;
    a.isSponsor = NO;
    a.publishDate = publishDate;
    a.gskString = @"  Sponsored content brought to you by GSK";
    a.type = type;
    a.authAccount = @"tom@gmail.com";
    a.authName = @"Dr.Sandra Tai";
    a.authAdd = @"Vancouver, BC";
    a.title = title;
    a.content =content;
    a.subContent = subContent;
    a.resImage = resImage;
    a.resType = @"image";
    a.categoryName=category;
    
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
    return a;
}


+ (Article *)getArticleInfo {
	Article *a = [Article new];
	a.id = 1;
	a.isSponsor = NO;
	a.publishDate = @"May 15,2018";

	a.gskString = @"Sponsored content brought to you by GSK";
	a.type = @"ORTHODONTICS";
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
    b.id = 2;
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
	return [self postBody:@"userAccount/resetPassWord" dic:@{@"username": email, @"password": pwd, @"email_token": code} modular:@"profile"];
}


+ (HttpResult *)sendEmailCode:(NSString *)email {
	return [self post:@"emailToken/sendEmail" dic:@{@"email": email} modular:@"profile"];
}

+ (HttpResult *)sendLinkedInInfo:(NSString *)access_token {
	NSString *url = [NSString stringWithFormat:@"linkedInLogin/%@/fooClientIdPassword", access_token];
	return [self get:url dic:nil modular:@"profile"];
}


+ (NSString *)lastAccount {
	return getLastAccount();
}

+ (NSString *)lastToken {
	NSString *account = self.lastAccount;
	return getUserToken(account);
}

+ (HttpResult *)login:(NSString *)email pwd:(NSString *)pwd {
	HttpResult *r = [self postBody:@"userAccount/login" dic:@{@"username": email, @"password": pwd} modular:@"profile"];
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
	HttpResult *r = [self postBody:@"userAccount/register" dic:d modular:@"profile"];
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
	HttpResult *r = [self postBody:@"userProfile/save" dic:dic modular:@"profile"];
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
	HttpResult *r = [self post2:@"userProfile/findOneByEmail" dic:@{@"email": getLastAccount()} modular:@"profile"];
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
	HttpResult *r = [self post2:@"usZipSv/findAllusZipSvByZip" dic:@{@"zip": zipCode} modular:@"profile"];
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
	HttpResult *r = [self post2:@"residencySpecialty/findAllSpecialty" dic:@{} modular:@"profile"];
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
	HttpResult *r = [self post2:@"dentalSchool/getAll" dic:@{@"name": @""} modular:@"profile"];
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
	HttpResult *r = [self post2:@"experience/findAllPracticeDSO" dic:@{@"name": name} modular:@"profile"];

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
	HttpResult *r = [self post2:@"experience/findAllPracticeRole" dic:@{@"name": name} modular:@"profile"];

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
	HttpResult *r = [self post2:@"experience/findAllPracticeType" dic:@{@"name": @""} modular:@"profile"];

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
    
	HttpResult *r = [self upload:@"photoUpload" localFilePath:localFilePath modular:@"profile"];
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

#pragma mark CMS Modular

+ (DetailModel *)queryForDetailPage:(NSString *)contentId
{
    HttpResult *r = [self post:@"content/findOneContents" dic:@{@"id": contentId} modular:@"cms"];
    
    if (r.OK) {
        NSDictionary *dic = r.resultMap[@"data"];
        DetailModel *detail = [[DetailModel alloc] initWithJson:jsonBuild(dic)];
        return detail;
    }
    return nil;
}

//search API（CMS_001_11-A/CMS_001_12）
+ (NSArray<CMSModel *> *)querySearchResults:(NSString *)serachValue {
    HttpResult *r = [self post:@"content/findAllBySearch" dic:@{@"searchValue": serachValue} modular:@"cms"];
    
    NSMutableArray *resultArray = [NSMutableArray array];
    if (r.OK) {
        NSArray *arr = r.resultMap[@"data"];
        for (NSDictionary *d in arr) {
            CMSModel *item = [[CMSModel alloc] initWithJson:jsonBuild(d)];
            if (item) {
                [resultArray addObject:item];
            }
            
        }
    }
    return resultArray;
}

//MARK:查询媒体列表（CMS_001_01\CMS_001_10）
+ (NSArray<CMSModel *> *)queryAllContents:(NSString *)email contentTypeId:(NSString *)contentTypeId categoryId:(NSString *)categoryId sponserId:(NSString *)sponserId pageNumber:(NSInteger)pageNumber authorId:(NSString *)authorId {
    NSInteger skip=0;
    NSInteger limit=20;//分页数默认20条
    if(pageNumber>=1)
    {
        skip=(pageNumber-1)*limit;
    }
    NSMutableDictionary *paradic=[NSMutableDictionary dictionary];
    [paradic setObject:[NSNumber numberWithInteger:skip] forKey:@"skip"];
    [paradic setObject:[NSNumber numberWithInteger:limit] forKey:@"limit"];
    if (email) {
        [paradic setObject:email forKey:@"email"];
    }
    if (contentTypeId) {
        [paradic setObject:contentTypeId forKey:@"contentTypeId"];
    }
    if (categoryId) {
        [paradic setObject:categoryId forKey:@"categoryId"];
    }
    if (sponserId) {
        [paradic setObject:sponserId forKey:@"sponserId"];
    }
    if (authorId) {
        [paradic setObject:email forKey:@"authorId"];
    }
    HttpResult *r = [self post3:@"content/findAllContents" dic:paradic modular:@"cms"];
    NSMutableArray *resultArray = [NSMutableArray array];
    if (r.OK) {
        NSArray *arr = r.resultMap[@"data"];
        for (NSDictionary *d in arr) {
            CMSModel *item = [[CMSModel alloc] initWithJson:jsonBuild(d)];
            if (item) {
                [resultArray addObject:item];
            }
            
        }
    }
    return resultArray;
}
//MARK:根据内容分类查询媒体列表（CMS_001_01\CMS_001_10）
+ (NSArray<CMSModel *> *)queryAllContentsBycontentType:(NSString *)contentTypeId pageNumber:(NSInteger)pageNumber
{
    return [self queryAllContents:nil contentTypeId:contentTypeId categoryId:nil sponserId:nil pageNumber:pageNumber authorId:nil];
}

//MARK:查询媒体详情（CMS_002_01/CMS_002_02）
+ (NSArray<CMSModel *> *)queryOneContentsByConentId:(NSString *)contentId {
    HttpResult *r = [self post3:@"category/findOneContents" dic:@{@"contentId": contentId} modular:@"cms"];
    
    NSMutableArray *resultArray = [NSMutableArray array];
    if (r.OK) {
        NSArray *arr = r.resultMap[@"data"];
        for (NSDictionary *d in arr) {
            CMSModel *item = [[CMSModel alloc] initWithJson:jsonBuild(d)];
            [resultArray addObject:item];
        }
    }
    return resultArray;
}

//MARK:查询Category（CMS_001_15
+ (NSArray<IdName *> *)queryCategoryTypes {
    HttpResult *r = [self post3:@"category/findAllCategory" dic:nil modular:@"cms"];
    
    NSMutableArray *resultArray = [NSMutableArray array];
    if (r.OK) {
        NSArray *arr = r.resultMap[@"data"];
        for (NSDictionary *d in arr) {
            IdName *item = [[IdName alloc] initWithJson:jsonBuild(d)];
            [resultArray addObject:item];
        }
    }
    return resultArray;
}

//MARK:查询Content Type（CMS_004_03）
+ (NSArray<IdName *> *)queryContentTypes {
    HttpResult *r = [self post3:@"category/findAllContentType" dic:nil modular:@"cms"];
    
    NSMutableArray *resultArray = [NSMutableArray array];
    if (r.OK) {
        NSArray *arr = r.resultMap[@"data"];
        for (NSDictionary *d in arr) {
            IdName *item = [[IdName alloc] initWithJson:jsonBuild(d)];
            [resultArray addObject:item];
        }
    }
    return resultArray;
}

//MARK:添加评论（CMS_002_06）
+(BOOL)addComment:(NSString *)email contentId:(NSString *)contentId commentText:(NSString *)commentText commentRating:(NSString *)commentRating
{
    BOOL result=NO;
    HttpResult *r = [self post3:@"comment/findAllContentType" dic:@{@"email": email,@"contentId": contentId,@"contentId": commentText,@"commentRating": commentRating} modular:@"cms"];
    if (r.OK) {
        result=YES;
    }
    return result;
}

//MARK:查询整个文章的评论（CMS_003_04）
+ (NSArray<CMSModelComment *> *)queryAllCommentByConent:(NSString *)contentId {
    HttpResult *r = [self post3:@"comment/findAllByContent" dic:@{@"contentId": contentId} modular:@"cms"];
    
    NSMutableArray *resultArray = [NSMutableArray array];
    if (r.OK) {
        NSArray *arr = r.resultMap[@"data"];
        for (NSDictionary *d in arr) {
            CMSModelComment *item = [[CMSModelComment alloc] initWithJson:jsonBuild(d)];
            [resultArray addObject:item];
        }
    }
    return resultArray;
}

//MARK:查询收藏列表
+ (NSArray<CMSModel *> *)queryBookmarksByEmail:(NSString *)email {
    HttpResult *r = [self post3:@"bookmark/findAllByEmail" dic:@{@"email": email} modular:@"cms"];
    
    NSMutableArray *resultArray = [NSMutableArray array];
    if (r.OK) {
        NSArray *arr = r.resultMap[@"data"];
        for (NSDictionary *d in arr) {
            CMSModel *item = [[CMSModel alloc] initWithJson:jsonBuild(d)];
            [resultArray addObject:item];
        }
    }
    return resultArray;
}

//MARK:删除收藏
+(BOOL)deleteBookmark:(NSString *)bookmarkid
{
    BOOL result=NO;
    HttpResult *r = [self post3:@"bookmark/deleteOneById" dic:@{@"id": bookmarkid} modular:@"cms"];
    if (r.OK) {
        result=YES;
    }
    return result;
}

//MARK:添加收藏
+(BOOL)addBookmark:(NSString *)email postId:(NSString *)postId title:(NSString *)title url:(NSString *)url
{
    BOOL result=NO;
    HttpResult *r = [self post3:@"bookmark/save" dic:@{@"email": email,@"postId": postId,@"title": title,@"url": url} modular:@"cms"];
    if (r.OK) {
        result=YES;
    }
    return result;
}

+(NSString *)baseDomain
{
    NSInteger value = getServerDomain();
    if (value==1) {
        return @"https://devupapi1.dsodentist.com/";
    }else{
        return @"http://dsod.aikontec.com/";
    }
}


+ (HttpResult *)postBody:(NSString *)action dic:(NSDictionary *)dic modular:(NSString *)modular {
	NSString *baseUrl = [self configUrl:modular];
	Http *h = [Http new];
	h.url = strBuild([self baseDomain],baseUrl, action);
    NSLog(@"requesturl=%@", h.url);
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

+ (HttpResult *)get:(NSString *)action dic:(NSDictionary *)dic modular:(NSString *)modular {
	NSString *baseUrl = [self configUrl:modular];
	Http *h = [Http new];
	h.url = strBuild([self baseDomain],baseUrl, action);
    NSLog(@"requesturl=%@", h.url);
	[h arg:@"client_id" value:@"fooClientIdPassword"];
	[h args:dic];
	NSString *token = [self lastToken];
	if (token != nil) {
		[h header:@"Authorization" value:strBuild(@"Bearer ", token)];
	}
	HttpResult *r = [h get];
	return r;
}

+ (HttpResult *)post:(NSString *)action dic:(NSDictionary *)dic modular:(NSString *)modular {
	NSString *baseUrl = [self configUrl:modular];
	Http *h = [Http new];
	h.url = strBuild([self baseDomain],baseUrl, action);
    NSLog(@"requesturl=%@", h.url);
	[h arg:@"client_id" value:@"fooClientIdPassword"];
	[h args:dic];
	NSString *token = [self lastToken];
	if (token != nil) {
		[h header:@"Authorization" value:strBuild(@"Bearer ", token)];
	}
	HttpResult *r = [h post];
	return r;
}


+ (HttpResult *)post2:(NSString *)action dic:(NSDictionary *)dic modular:(NSString *)modular{
    NSString *baseUrl = [self configUrl:modular];
	Http *h = [Http new];
	h.url = strBuild([self baseDomain],baseUrl, action);
    NSLog(@"requesturl=%@", h.url);
	NSString *token = [self lastToken];
	if (token != nil) {
		[h header:@"Authorization" value:strBuild(@"Bearer ", token)];
	}
	[h arg:@"client_id" value:@"fooClientIdPassword"];
	[h args:dic];
	HttpResult *r = [h multipart];
	return r;
}

+ (HttpResult *)post3:(NSString *)action dic:(NSDictionary *)dic modular:(NSString *)modular{
    NSString *baseUrl = [self configUrl:modular];
    Http *h = [Http new];
    h.url = strBuild([self baseDomain],baseUrl, action);
    NSLog(@"requesturl=%@", h.url);
    NSString *token = [self lastToken];
    if (token != nil) {
        [h header:@"Authorization" value:strBuild(@"Bearer ", token)];
        [h header:@"Content-Type" value:@"application/json"];
    }
    NSString *jsondic=jsonBuild(dic);
    NSData *datadic=[jsondic dataUsingEncoding:NSUTF8StringEncoding];
    HttpResult *r = [h postRaw:datadic];
    return r;
}

+ (HttpResult *)upload:(NSString *)action localFilePath:(NSString *)localFilePath modular:(NSString *)modular {
	NSString *baseUrl = [self configUrl:modular];
	Http *h = [Http new];
	h.timeout = 20;
	h.url = strBuild([self baseDomain],baseUrl, action);
    NSLog(@"requesturl=%@", h.url);
	NSString *token = [self lastToken];
	if (token != nil) {
		[h header:@"Authorization" value:strBuild(@"Bearer ", token)];
	}
	[h arg:@"client_id" value:@"fooClientIdPassword"];
	[h file:@"file" value:localFilePath];
	HttpResult *r = [h multipart];
	return r;
}

+ (NSString *)configUrl:(NSString *)modular
{
    NSString *baseUrl = nil;
    if ([modular isEqualToString:@"profile"]) {
        baseUrl = @"profile-service/v1/";
    }
    else if ([modular isEqualToString:@"cms"])
    {
        baseUrl = @"content-service/v1/";
    }
    return baseUrl;
}

//MARK:模拟

+(BOOL)isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    string=[NSString stringWithFormat:@"%@",string];
    if ([string isEqualToString:@"(null)"]) {
        return YES;
    }
    if ([string isEqualToString:@"<null>"]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

+(BOOL)archiveActicleArr
{
    if(getIsActicleArchive()==0){
        NSArray *ls=[self listArticle];
       return [self saveArticleArr:ls];
    }else{
        return YES;
    }
    
}

+ (NSString*)getFilePath:(NSString *)aFileName {
    if (aFileName) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        return [documentsDirectory stringByAppendingString:[NSString stringWithFormat:@"/%@.archive", aFileName]];
    }
    return nil;
}
//MARK:保存文章列表
+ (BOOL)saveArticleArr:(NSArray *)articleArr {
    NSString *fileNameWithPath = [self getFilePath:CMSARTICLELIST];
    return [NSKeyedArchiver archiveRootObject:articleArr toFile:fileNameWithPath];
}

//MARK:获取Article列表
+(NSArray *)getArticleList
{
    NSString *fileNameWithPath = [self getFilePath:CMSARTICLELIST];
    NSArray *arr=[NSKeyedUnarchiver unarchiveObjectWithFile:fileNameWithPath];
    return arr;
}

//MARK:根据author获取Article列表
+(NSArray *)getArticleListByAuthor:(NSString *)author category:(NSString *)category  type:(NSString *)type
{
    NSString *fileNameWithPath = [self getFilePath:CMSARTICLELIST];
    NSArray *arr=[NSKeyedUnarchiver unarchiveObjectWithFile:fileNameWithPath];
    NSMutableArray *newDataArr = [NSMutableArray array];
    [arr enumerateObjectsUsingBlock:^(Article* model, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([[model.authName lowercaseString] isEqualToString:[author lowercaseString]] ) {
            if(![self isBlankString:category] && ![self isBlankString:type]){
                if ([[model.categoryName lowercaseString] isEqualToString:[category lowercaseString]] && [[model.type lowercaseString] isEqualToString:[type lowercaseString]]) {
                    [newDataArr addObject:model];
                }
            }else if (![self isBlankString:category] && [self isBlankString:type]){
                if ([[model.categoryName lowercaseString] isEqualToString:[category lowercaseString]]) {
                    [newDataArr addObject:model];
                }
            }else if ([self isBlankString:category] && ![self isBlankString:type] ){
                if ([[model.type lowercaseString] isEqualToString:[type lowercaseString]]) {
                    [newDataArr addObject:model];
                }
            }else{
                [newDataArr addObject:model];
            }
        }
    }];
    return newDataArr;
}

//MARK:根据category获取Article列表
+(NSArray *)getArticleListByCategory:(NSString *)category
{
    NSString *fileNameWithPath = [self getFilePath:CMSARTICLELIST];
    NSArray *arr=[NSKeyedUnarchiver unarchiveObjectWithFile:fileNameWithPath];
    NSMutableArray *newDataArr = [NSMutableArray array];
    [arr enumerateObjectsUsingBlock:^(Article* model, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([[model.categoryName lowercaseString] isEqualToString:[category lowercaseString]] ) {
            [newDataArr addObject:model];
        }
    }];
    return newDataArr;
}

//MARK:根据type获取Article列表
+(NSArray *)getArticleListByType:(NSString *)type
{
    NSString *fileNameWithPath = [self getFilePath:CMSARTICLELIST];
    NSArray *arr=[NSKeyedUnarchiver unarchiveObjectWithFile:fileNameWithPath];
    NSMutableArray *newDataArr = [NSMutableArray array];
    [arr enumerateObjectsUsingBlock:^(Article* model, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([[model.type lowercaseString] isEqualToString:[type lowercaseString]] ) {
            [newDataArr addObject:model];
        }
    }];
    return newDataArr;
}

//MARK:根据categoryh跟type获取Article列表
+(NSArray *)getArticleListByCategory:(NSString *)category type:(NSString *)type
{
    NSString *fileNameWithPath = [self getFilePath:CMSARTICLELIST];
    NSArray *arr=[NSKeyedUnarchiver unarchiveObjectWithFile:fileNameWithPath];
    NSMutableArray *newDataArr = [NSMutableArray array];
    [arr enumerateObjectsUsingBlock:^(Article* model, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if(![self isBlankString:category] && ![self isBlankString:type]){
            if ([[model.categoryName lowercaseString] isEqualToString:[category lowercaseString]] && [[model.type lowercaseString] isEqualToString:[type lowercaseString]]) {
                [newDataArr addObject:model];
            }
        }else if (![self isBlankString:category] && [self isBlankString:type]){
            if ([[model.categoryName lowercaseString] isEqualToString:[category lowercaseString]]) {
                [newDataArr addObject:model];
            }
        }else if ([self isBlankString:category] && ![self isBlankString:type] ){
            if ([[model.type lowercaseString] isEqualToString:[type lowercaseString]]) {
                [newDataArr addObject:model];
            }
        }else{
            [newDataArr addObject:model];
        }
        
    }];
    
    return newDataArr;
}

//MARK:根据keywords获取Article列表
+(NSArray *)getArticleListByKeywords:(NSString *)keywords
{
    NSString *fileNameWithPath = [self getFilePath:CMSARTICLELIST];
    NSArray *arr=[NSKeyedUnarchiver unarchiveObjectWithFile:fileNameWithPath];
    NSMutableArray *newDataArr = [NSMutableArray array];
    if (![self isBlankString:keywords]) {
        [arr enumerateObjectsUsingBlock:^(Article* model, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if([[model.title lowercaseString] containsString:[keywords lowercaseString]] || [[model.content lowercaseString] containsString:[keywords lowercaseString]] || [[model.type lowercaseString] containsString:[keywords lowercaseString]] || [[model.categoryName lowercaseString] containsString:[keywords lowercaseString]] || [[model.authName lowercaseString] containsString:[keywords lowercaseString]]){
                [newDataArr addObject:model];//authName
            }
        }];
    }
   
    return newDataArr;
}

//MARK:根据keywords and type获取Article列表
+(NSArray *)getArticleListByKeywords:(NSString *)keywords type:(NSString *)type
{
    NSString *fileNameWithPath = [self getFilePath:CMSARTICLELIST];
    NSArray *arr=[NSKeyedUnarchiver unarchiveObjectWithFile:fileNameWithPath];
    NSMutableArray *newDataArr = [NSMutableArray array];
    if (![self isBlankString:keywords]) {
        [arr enumerateObjectsUsingBlock:^(Article* model, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if([[model.title lowercaseString] containsString:[keywords lowercaseString]] || [[model.content lowercaseString] containsString:[keywords lowercaseString]] || [[model.type lowercaseString] containsString:[keywords lowercaseString]] || [[model.categoryName lowercaseString] containsString:[keywords lowercaseString]] || [[model.authName lowercaseString] containsString:[keywords lowercaseString]]){
                if (![self isBlankString:type] ){
                    if ([[model.type lowercaseString] isEqualToString:[type lowercaseString]]) {
                        [newDataArr addObject:model];
                    }
                }else{
                    [newDataArr addObject:model];
                }
                
            }
        }];
    }
    
    return newDataArr;
}

//MARK:获取bookmark列表
+(NSArray *)getBookmarksList
{
    NSString *fileNameWithPath = [self getFilePath:CMSARTICLELIST];
    NSArray *arr=[NSKeyedUnarchiver unarchiveObjectWithFile:fileNameWithPath];
    NSMutableArray *bookmarkDataArr = [NSMutableArray array];
    [arr enumerateObjectsUsingBlock:^(Article* model, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (model.isBookmark) {
            [bookmarkDataArr addObject:model];
        }
    }];
    return bookmarkDataArr;
}

//MARK:根据Bookmarks跟type获取Article列表
+(NSArray *)getBookmarksListByCategory:(NSString *)category type:(NSString *)type
{
    NSString *fileNameWithPath = [self getFilePath:CMSARTICLELIST];
    NSArray *arr=[NSKeyedUnarchiver unarchiveObjectWithFile:fileNameWithPath];
    NSMutableArray *newDataArr = [NSMutableArray array];
    [arr enumerateObjectsUsingBlock:^(Article* model, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (model.isBookmark) {
            if(![self isBlankString:category] && ![self isBlankString:type]){
                if ([[model.categoryName lowercaseString] isEqualToString:[category lowercaseString]] && [[model.type lowercaseString] isEqualToString:[type lowercaseString]]) {
                    [newDataArr addObject:model];
                }
            }else if (![self isBlankString:category] && [self isBlankString:type] ){
                if ([[model.categoryName lowercaseString] isEqualToString:[category lowercaseString]]) {
                    [newDataArr addObject:model];
                }
            }else if ([self isBlankString:category] && ![self isBlankString:type] ){
                if ([[model.type lowercaseString] isEqualToString:[type lowercaseString]]) {
                    [newDataArr addObject:model];
                }
            }else{
                [newDataArr addObject:model];
            }
        }
        
    }];
    
    return newDataArr;
}

//MARK:获取download列表
+(NSArray *)getDownloadList
{
    NSString *fileNameWithPath = [self getFilePath:CMSARTICLELIST];
    NSArray *arr=[NSKeyedUnarchiver unarchiveObjectWithFile:fileNameWithPath];
    NSMutableArray *downloadDataArr = [NSMutableArray array];
    [arr enumerateObjectsUsingBlock:^(Article* model, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (model.isDownload) {
            [downloadDataArr addObject:model];
        }
    }];
    return downloadDataArr;
}

//MARK:根据DownloadList跟type获取Article列表
+(NSArray *)getDownloadListByCategory:(NSString *)category type:(NSString *)type
{
    NSString *fileNameWithPath = [self getFilePath:CMSARTICLELIST];
    NSArray *arr=[NSKeyedUnarchiver unarchiveObjectWithFile:fileNameWithPath];
    NSMutableArray *newDataArr = [NSMutableArray array];
    [arr enumerateObjectsUsingBlock:^(Article* model, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (model.isDownload) {
            if(![self isBlankString:category] && ![self isBlankString:type]){
                if ([[model.categoryName lowercaseString] isEqualToString:[category lowercaseString]] && [[model.type lowercaseString] isEqualToString:[type lowercaseString]]) {
                    [newDataArr addObject:model];
                }
            }else if (![self isBlankString:category] && [self isBlankString:type] ){
                if ([[model.categoryName lowercaseString] isEqualToString:[category lowercaseString]]) {
                    [newDataArr addObject:model];
                }
            }else if ([self isBlankString:category] && ![self isBlankString:type] ){
                if ([[model.type lowercaseString] isEqualToString:[type lowercaseString]]) {
                    [newDataArr addObject:model];
                }
            }else{
                [newDataArr addObject:model];
            }
        }
        
    }];
    
    return newDataArr;
}

//MARK:检测是否bookmark
+(BOOL)checkIsBookmarkByArticle:(NSInteger)articleid
{
    NSString *fileNameWithPath = [self getFilePath:CMSARTICLELIST];
    NSArray *arr=[NSKeyedUnarchiver unarchiveObjectWithFile:fileNameWithPath];
    NSIndexSet *indexSet = [arr indexesOfObjectsWithOptions:NSEnumerationReverse passingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop){
        Article *model = obj;
        if (model.id==articleid && model.isBookmark)
        {
            *stop = YES;
            return YES;
        }
        return NO;
    }];
    
    if (indexSet.count) {
        //存在该记录 更新
        return YES;
    }else{
        //不存在该记录 添加
        return NO;
    }
}

//MARK:检测是否添加到下载
+(BOOL)checkIsDownloadByArticle:(NSInteger)articleid
{
    NSString *fileNameWithPath = [self getFilePath:CMSARTICLELIST];
    NSArray *arr=[NSKeyedUnarchiver unarchiveObjectWithFile:fileNameWithPath];
    NSIndexSet *indexSet = [arr indexesOfObjectsWithOptions:NSEnumerationReverse passingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop){
        Article *model = obj;
        if (model.id==articleid && model.isDownload)
        {
            *stop = YES;
            return YES;
        }
        return NO;
    }];
    
    if (indexSet.count) {
        //存在该记录 更新
        return YES;
    }else{
        //不存在该记录 添加
        return NO;
    }
}

//MARK:根据id获取文章实体
+(Article *)getArticleById:(NSInteger)articleid
{
    NSString *fileNameWithPath = [self getFilePath:CMSARTICLELIST];
    NSArray *arr=[NSKeyedUnarchiver unarchiveObjectWithFile:fileNameWithPath];
    Article *articlemodel;
    NSIndexSet *indexSet = [arr indexesOfObjectsWithOptions:NSEnumerationReverse passingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop){
        Article *model = obj;
        if (model.id==articleid)
        {
            *stop = YES;
            return YES;
        }
        return NO;
    }];
    
    if (indexSet.count) {
        //存在该记录
        articlemodel=[arr objectAtIndex:indexSet.firstIndex];
    }
    return articlemodel;
}

//MARK:添加bookmark
+(BOOL)addBookmarks:(NSInteger)articleid
{
    NSString *fileNameWithPath = [self getFilePath:CMSARTICLELIST];
    NSArray *arr=[NSKeyedUnarchiver unarchiveObjectWithFile:fileNameWithPath];
    [arr enumerateObjectsUsingBlock:^(Article* model, NSUInteger idx, BOOL * _Nonnull stop) {
        if (model.id==articleid) {
            model.isBookmark=YES;
        }
    }];
    return [self saveArticleArr:arr];
}

//MARK:删除bookmark
+(BOOL)deleteBookmarks:(NSInteger)articleid
{
    NSString *fileNameWithPath = [self getFilePath:CMSARTICLELIST];
    NSArray *arr=[NSKeyedUnarchiver unarchiveObjectWithFile:fileNameWithPath];
    [arr enumerateObjectsUsingBlock:^(Article* model, NSUInteger idx, BOOL * _Nonnull stop) {
        if (model.id==articleid) {
            model.isBookmark=NO;
        }
    }];
    return [self saveArticleArr:arr];
}

//MARK:添加download
+(BOOL)addDownload:(NSInteger)articleid
{
    NSString *fileNameWithPath = [self getFilePath:CMSARTICLELIST];
    NSArray *arr=[NSKeyedUnarchiver unarchiveObjectWithFile:fileNameWithPath];
    [arr enumerateObjectsUsingBlock:^(Article* model, NSUInteger idx, BOOL * _Nonnull stop) {
        if (model.id==articleid) {
            model.isDownload=YES;
        }
    }];
    return [self saveArticleArr:arr];
    
}

//MARK:删除download
+(BOOL)deleteDownload:(NSInteger)articleid
{
    NSString *fileNameWithPath = [self getFilePath:CMSARTICLELIST];
    NSArray *arr=[NSKeyedUnarchiver unarchiveObjectWithFile:fileNameWithPath];
    [arr enumerateObjectsUsingBlock:^(Article* model, NSUInteger idx, BOOL * _Nonnull stop) {
        if (model.id==articleid) {
            model.isDownload=NO;
        }
    }];
    return [self saveArticleArr:arr];
}

@end
