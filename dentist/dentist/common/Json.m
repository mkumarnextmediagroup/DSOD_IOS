//
// Created by entaoyang on 2018/8/30.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "Json.h"
#import "Common.h"
#import "NSData+myextend.h"

NSString *jsonBuild(id obj) {
	if (obj == nil) {
		return nil;
	}
	NSError *err;
	NSData *data = [NSJSONSerialization dataWithJSONObject:obj options:NSJSONWritingSortedKeys error:&err];
	if (err || !data) {
		return nil;
	}
	return data.stringUTF8;
}

NSDictionary *jsonParse(NSString *s) {

	if (s == nil) {
		return nil;
	}
	NSData *data = s.dataUTF8;
	NSError *err;
	NSDictionary *d = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&err];
	if (err) {
		return nil;
	}
	return d;
}

id jsonParseObject(NSString *s) {
    
    if (s == nil) {
        return nil;
    }
    NSData *data = s.dataUTF8;
    NSError *err;
    id obj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&err];
    if (err) {
        return nil;
    }
    return obj;
}
