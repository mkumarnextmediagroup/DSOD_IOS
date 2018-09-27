//
// Created by entaoyang on 2018/9/6.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "UserInfo.h"
#import "Common.h"
#import "IdName.h"
#import "NSDate+myextend.h"


@implementation UserInfo {

}


- (void)fromDic:(NSDictionary *)dic {
	_userId = [dic strValue:@"id"];
	_email = [dic strValue:@"email"];
	_emailContact = [dic strValue:@"contact_email"];
	_fullName = [dic strValue:@"full_name"];
	_phone = [dic strValue:@"phone"];
	_isStudent = [dic boolValue:@"is_student"];
	_isLinkedin = [dic boolValue:@"is_linkedin"];
	_photo_url = [dic strValue:@"photo_url"];
	_speciality = [IdName new];
	_speciality.id = nil;
	_speciality.name = nil;
	id v = dic[@"specialty"];
	if (v && v != NSNull.null) {
		_speciality.id = [v strValue:@"id"];
		_speciality.name = [v strValue:@"name"];
	}

	_practiceAddress = [Address new];
	id v2 = dic[@"practiceAddress"];
	if (v2 && v2 != NSNull.null) {
		NSDictionary *d = v2;
		_practiceAddress.address1 = [d strValue:@"address1"];
		_practiceAddress.address2 = [d strValue:@"address2"];
		_practiceAddress.city = [d strValue:@"city"];
		_practiceAddress.stateLabel = [d strValue:@"states"];
		_practiceAddress.zipCode = [d strValue:@"zipCode"];
	}
	self.residencyArray = [NSMutableArray arrayWithCapacity:8];

	id arrRes = dic[@"profileResidency"];
	if (arrRes && arrRes != NSNull.null) {
		for (NSDictionary *d in arrRes) {
			Residency *r = [Residency new];

			NSNumber *startTime = d[@"start_time"];
			NSDate *fromDate = [NSDate dateWithTimeIntervalSince1970:startTime.doubleValue / 1000];
			r.fromYear = fromDate.year;
			r.fromMonth = fromDate.month;

			NSNumber *endTime = d[@"end_time"];
			NSDate *endDate = [NSDate dateWithTimeIntervalSince1970:endTime.doubleValue / 1000];
			r.toYear = endDate.year;
			r.toMonth = endDate.month;
			NSDictionary *ddd = d[@"residency_school"];
			r.schoolName = ddd[@"name"];
			r.schoolId = ddd[@"id"];
			[self.residencyArray addObject:r];
		}
	}

	self.educationArray = [NSMutableArray arrayWithCapacity:8];
	id eduArr = dic[@"educations"];
	if (eduArr && eduArr != NSNull.null) {
		for (NSDictionary *d in eduArr) {
			Education *edu = [Education new];
			[self.educationArray addObject:edu];

			edu.schoolInUS = [@"1" isEqualToString:d[@"types"]];
			if (edu.schoolInUS) {
				edu.schoolId = d[@"dental_school"][@"id"];
				edu.schoolName = d[@"dental_school"][@"name"];

			} else {
				edu.schoolId = nil;
				edu.schoolName = d[@"school_name"];
			}

			edu.major = d[@"major"];

			NSNumber *startTime = d[@"start_time"];
			NSDate *fromDate = [NSDate dateWithTimeIntervalSince1970:startTime.doubleValue / 1000];
			edu.fromYear = fromDate.year;
			edu.fromMonth = fromDate.month;

			NSNumber *endTime = d[@"end_time"];
			NSDate *endDate = [NSDate dateWithTimeIntervalSince1970:endTime.doubleValue / 1000];
			edu.toYear = endDate.year;
			edu.toMonth = endDate.month;
		}
	}

	self.experienceArray = [NSMutableArray arrayWithCapacity:8];
	id expArr = dic[@"experiences"];
	if (expArr && expArr != NSNull.null) {
		for (NSDictionary *d in expArr) {
			Experience *e = [Experience new];
			[self.experienceArray addObject:e];
			e.pracName = [d strValue:@"practice_name"];
			e.praticeTypeId = d[@"practice_Type"][@"id"];
			e.praticeType = d[@"practice_Type"][@"name"];
			e.roleAtPraticeId = d[@"practice_Role"][@"id"];
			e.roleAtPratice = d[@"practice_Role"][@"name"];

			NSDictionary *dsoDic = d[@"practice_DSO"];
			if (dsoDic && dsoDic != NSNull.null) {
				e.dsoId = dsoDic[@"id"];
				e.dsoName = dsoDic[@"name"];
			} else {
				e.dsoId = nil;
				e.dsoName = nil;
			}


			NSNumber *startTime = d[@"start_time"];
			NSDate *fromDate = [NSDate dateWithTimeIntervalSince1970:startTime.doubleValue / 1000];
			e.fromYear = fromDate.year;
			e.fromMonth = fromDate.month;

			NSNumber *endTime = d[@"end_time"];
			NSDate *endDate = [NSDate dateWithTimeIntervalSince1970:endTime.doubleValue / 1000];
			e.toYear = endDate.year;
			e.toMonth = endDate.month;


		}
	}


}


- (NSString *)portraitUrlFull {
	NSString *u = self.photo_url;
	if (u == nil) {
		return nil;
	}
	return strBuild(@"http://dsod.aikontec.com/profile-service/v1/photoDownload?", u);
}


@end
