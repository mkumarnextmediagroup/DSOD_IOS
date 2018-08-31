//
// Created by entaoyang on 2018/8/29.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <HealthKit/HealthKit.h>
#import "HttpResult.h"
#import "NSData+myextend.h"
#import "Json.h"


@implementation HttpResult {

}

- (instancetype)init {
	self = [super init];
	self.data = nil;
	self.response = nil;
	self.error = nil;


	return self;
}

- (int)httpCode {
	if (self.error != nil || self.response == nil) {
		return -1;
	}
	return (int) (self.response.statusCode);
}

- (BOOL)httpOK {
	int c = self.httpCode;
	return c >= 200 && c < 300;
}


- (NSString *)strBody {
	if (self.data == nil) {
		return nil;
	}
	return self.data.stringUTF8;
}

- (NSDictionary *)jsonBody {
	NSString *s = self.strBody;
	if (s == nil) {
		return nil;
	}
	return jsonParse(s);
}

- (BOOL)OK {
	return self.httpOK && self.code == 0;
}

- (int)code {
	if ([self httpOK]) {
		NSDictionary *d = [self jsonBody];
		if (d != nil) {
			NSNumber *num = d[@"code"];
			return num.intValue;
		}
	}
	return -1;
}

- (NSString *)msg {
	if ([self httpOK]) {
		NSDictionary *d = [self jsonBody];
		if (d != nil) {
			NSString *s = d[@"msg"];
			return s;
		}
	}
	return nil;
}

- (NSDictionary *)resultMap {
	if ([self httpOK]) {
		NSDictionary *d = [self jsonBody];
		if (d != nil) {
			NSDictionary *d2 = d[@"resultMap"];
			return d2;
		}
	}
	return nil;
}

- (void)dump {
	if (self.response != nil) {
		NSLog(@"Http Status Code: %d", self.response.statusCode);
	}
	NSLog(@"Error: %@", self.error);
	if (self.data != nil) {
		NSLog(@"Size: %d", self.data.length);
	}
	NSLog(@"Response Body: %@", [self strBody]);
}


@end