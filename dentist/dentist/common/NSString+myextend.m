//
// Created by yet on 2018/8/19.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "NSString+myextend.h"
#import "Common.h"


@implementation NSString (myextend)

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
@end