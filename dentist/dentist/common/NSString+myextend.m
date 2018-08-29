//
// Created by yet on 2018/8/19.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "NSString+myextend.h"
#import "Common.h"


@implementation NSString (myextend)

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


NSString *addStr(NSString *value, ...) {
	va_list list;
	va_start(list, value);
	NSString *result = @"";
	while (YES) {
		NSString *s = va_arg(list, NSString*);
		if (!s) {
			break;
		}
		result = [result add:s];
	}
	va_end(list);
	return result;
}