//
// Created by entaoyang on 2018/8/29.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <HealthKit/HealthKit.h>
#import "HttpResult.h"
#import "NSData+myextend.h"


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

- (BOOL)OK {
	int c = self.httpCode;
	return c >= 200 && c < 300;
}

- (NSString *)strBody {
	if (self.data == nil) {
		return nil;
	}
	return self.data.stringUTF8;
}

- (void)dump {
	if (self.response != nil) {
		NSLog(@"Http Status Code: %zd", self.response.statusCode);
	}
	NSLog(@"Error: %@", self.error);
	if (self.data != nil) {
		NSLog(@"Size: %tu", self.data.length);
	}
	NSLog(@"Response Body: %@", [self strBody]);
}


@end