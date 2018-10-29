//
// Created by yet on 2018/8/19.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "NSString+myextend.h"
#import "Common.h"


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

- (NSString *)textAddPhoneNor {
    NSMutableString *compStr = [[NSMutableString alloc] initWithCapacity:15];
    for (int i = 0; i < self.length; i++) {
        NSString *letter = [self substringWithRange:NSMakeRange(i,1)];
        if (i == 3 || i == 6) {
            [compStr appendString:@"-"];
        }
        [compStr appendString:letter];
    }
    return compStr;
}

+ (NSString *)timeWithTimeIntervalString:(NSString *)timeString
{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"America/Chicago"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"MMM dd,yyyy"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]/ 1000.0];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
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

-(BOOL)isBlankString {
    if (self == nil || self == NULL) {
        return YES;
    }
    if ([self isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([self isEqualToString:@"(null)"]) {
        return YES;
    }
    if ([self isEqualToString:@"<null>"]) {
        return YES;
    }
    if ([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}
@end


__attribute__((overloadable))   NSString *strBuild(NSString *value, NSString *v2) {
	if (value == nil) {
		return v2;
	}
	if (v2 == nil) {
		return value;
	}
	return [value stringByAppendingString:v2];
}

__attribute__((overloadable))   NSString *strBuild(NSString *value, NSString *v2, NSString *v3) {
	return strBuild(strBuild(value, v2), v3);
}

__attribute__((overloadable))   NSString *strBuild(NSString *value, NSString *v2, NSString *v3, NSString *v4) {
	return strBuild(strBuild(value, v2, v3), v4);
}

__attribute__((overloadable))   NSString *strBuild(NSString *value, NSString *v2, NSString *v3, NSString *v4, NSString *v5) {
	return strBuild(strBuild(value, v2, v3, v4), v5);
}

__attribute__((overloadable))   NSString *strBuild(NSString *value, NSString *v2, NSString *v3, NSString *v4, NSString *v5, NSString *v6) {
	return strBuild(strBuild(value, v2, v3, v4, v5), v6);
}

__attribute__((overloadable))   NSString *strBuild(NSString *value, NSString *v2, NSString *v3, NSString *v4, NSString *v5, NSString *v6, NSString *v7) {
	return strBuild(strBuild(value, v2, v3, v4, v5, v6), v7);
}

__attribute__((overloadable))   NSString *strBuild(NSString *value, NSString *v2, NSString *v3, NSString *v4, NSString *v5, NSString *v6, NSString *v7, NSString *v8) {
	return strBuild(strBuild(value, v2, v3, v4, v5, v6, v7), v8);
}

__attribute__((overloadable))   NSString *strBuild(NSString *value, NSString *v2, NSString *v3, NSString *v4, NSString *v5, NSString *v6, NSString *v7, NSString *v8, NSString *v9) {
	return strBuild(strBuild(value, v2, v3, v4, v5, v6, v7, v8), v9);
}

