//
// Created by entaoyang on 2018/9/6.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "UserInfo.h"
#import "Common.h"
#import "IdName.h"


@implementation UserInfo {

}


- (void)fromDic:(NSDictionary *)dic {
	_userId = [dic strValue:@"id"];
	_email = [dic strValue:@"email"];
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


}


- (NSString *)portraitUrlFull {
	NSString *u = self.photo_url;
	if (u == nil) {
		return nil;
	}
	return strBuild(@"http://dsod.aikontec.com/profile-service/v1/photoDownload?", u);
}


@end