//
// Created by yet on 2018/8/19.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "NSString+myextend.h"
#import "Common.h"
#import "NSData+myextend.h"


@implementation NSString (myextend)

- (NSString *)base64Encoded {
	NSData *d = self.dataUTF8;
	return [d base64EncodedStringWithOptions:0];
}

- (NSString *)base64Decoded {
	NSData *d = [[NSData alloc] initWithBase64EncodedString:self options:0];
	return d.stringUTF8;
}


- (BOOL)containsChar:(unichar)ch {
	for (int i = 0; i < self.length; ++i) {
		if (ch == [self characterAtIndex:i]) {
			return YES;
		}
	}
	return NO;
}

- (unichar)lastChar {
	if (self.length == 0) {
		return 0;
	}
	return [self characterAtIndex:self.length - 1];
}


- (NSString *)urlEncoded {
	return [self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

- (NSData *)dataUTF8 {
	return [self dataUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)trimed {
	return [self stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
}

- (BOOL)match:(NSString *)reg {
	NSPredicate *p = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", reg];
	return [p evaluateWithObject:self];
}

- (BOOL)matchEmail {
	return [self match:REG_EMAIL];
}

- (BOOL)matchPassword {
	return [self match:MATCH_PWD];
}

- (NSString *)add:(NSString *)s {
	return [self stringByAppendingString:s];
}
@end


__attribute__((overloadable))   NSString *strBuild(NSString *value, NSString *v2) {
	if (v2 == nil) {
		return value;
	}
	return [value add:v2];
}

__attribute__((overloadable))   NSString *strBuild(NSString *value, NSString *v2, NSString *v3) {
	return strBuild(strBuild(value, v2), v3);
}

__attribute__((overloadable))   NSString *strBuild(NSString *value, NSString *v2, NSString *v3, NSString *v4) {
	return strBuild(strBuild(strBuild(value, v2), v3), v4);
}

__attribute__((overloadable))   NSString *strBuild(NSString *value, NSString *v2, NSString *v3, NSString *v4, NSString *v5) {
	return strBuild(strBuild(strBuild(strBuild(value, v2), v3), v4), v5);
}

__attribute__((overloadable))   NSString *strBuild(NSString *value, NSString *v2, NSString *v3, NSString *v4, NSString *v5, NSString *v6) {
	return strBuild(strBuild(strBuild(strBuild(strBuild(value, v2), v3), v4), v5), v6);
}