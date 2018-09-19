//
// Created by entaoyang on 2018/9/6.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "UserInfo.h"
#import "Common.h"
#import "IdName.h"


@implementation UserInfo {

}
- (instancetype)init {
	self = [super init];
	self.isLinkedinUser = NO;
	self.isStudent = NO;
	_dic = [NSMutableDictionary dictionaryWithCapacity:24];
	return self;
}

- (NSString *)userId {
	id v = _dic[@"id"];
	if (v == NSNull.null) {
		return nil;
	}
	return v;
}

- (void)setUserId:(NSString *)uid {
	_dic[@"id"] = uid;
}

- (NSString *)email {
	id v = _dic[@"email"];
	if (v == NSNull.null) {
		return nil;
	}
	return v;
}

- (void)setEmail:(NSString *)email {
	_dic[@"email"] = email;
}

- (NSString *)fullName {
	id v = _dic[@"full_name"];
	if (v == NSNull.null) {
		return nil;
	}
	return v;
}

- (void)setFullName:(NSString *)email {
	_dic[@"full_name"] = email;
}

- (NSString *)phone {
	id v = _dic[@"phone"];
	if (v == NSNull.null) {
		return nil;
	}
	return v;
}

- (void)setPhone:(NSString *)email {
	_dic[@"phone"] = email;
}

- (BOOL)isStudent {
	NSNumber *num = _dic[@"is_student"];
	if (num && num != NSNull.null) {
		return num.boolValue;
	}
	return NO;
}

- (void)setIsStudent:(BOOL)student {
	_dic[@"is_student"] = @(student);
}

- (BOOL)isLinkedinUser {
	NSNumber *num = _dic[@"is_linkedin"];
	if (num && num != NSNull.null) {
		return num.boolValue;
	}
	return NO;
}

- (void)setIsLinkedinUser:(BOOL)linkedIn {
	_dic[@"is_linkedin"] = @(linkedIn);
}


- (NSString *)portraitUrlFull {
	NSString *u = self.portraitUrl;
	if (u == nil) {
		return nil;
	}
	return strBuild(@"http://dsod.aikontec.com/profile-service/v1/photoDownload?", u);
}

- (NSString *)portraitUrl {
	id v = _dic[@"photo_url"];
	if (v == NSNull.null) {
		return nil;
	}
	return v;
}

- (void)setPortraitUrl:(NSString *)url {
	_dic[@"photo_url"] = url;
}


- (IdName *)speciality {
	IdName *item = [IdName new];
	item.id = @"";
	item.name = @"";
	id v = _dic[@"specialty"];
	if (v && v != NSNull.null) {
		item.id = v[@"id"];
		item.name = v[@"name"];
	}
	return item;
}


- (void)setSpeciality:(IdName *)value {
	if (value == nil) {
		_dic[@"specialty"] = nil;
	} else {
		_dic[@"specialty"] = @{@"id": value.id, @"name": value.name};
	}
}

- (Address *)practiceAddress {
	id v = _dic[@"practiceAddress"];
	if (v == NSNull.null) {
		return nil;
	}
	Address *a = [Address new];
	NSDictionary *d = v;
	a.address1 = d[@"address1"];
	a.address2 = d[@"address2"];
	a.city = d[@"city"];
	a.stateLabel = d[@"states"];
	a.zipCode = d[@"zipCode"];
	return a;
}

- (void)setPracticeAddress:(Address *)address {
	if (address == nil) {
		_dic[@"practiceAddress"] = nil;
		return;
	}
	_dic[@"practiceAddress"] = @{
			@"address1": address.address1,
			@"address2": address.address2,
			@"city": address.city,
			@"states": address.stateLabel,
			@"zipCode": address.zipCode,
	};
}

@end