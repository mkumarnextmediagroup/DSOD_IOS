//
//  NSDate+customed.m
//  dentist
//
//  Created by wanglibo on 2018/11/12.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "NSDate+customed.h"

@implementation NSDate (customed)


+(NSString*)USDateShortFormatWithStringTimestamp:(NSString*)timestamp{
    return [NSDate USDateShortFormatWithTimestamp:[timestamp longLongValue]];
}

+(NSString*)USDateLongFormatWithStringTimestamp:(NSString*)timestamp{
    return [NSDate USDateLongFormatWithTimestamp:[timestamp longLongValue]];
}

+(NSString*)USDateShortFormatWithTimestamp:(long long)timestamp{
    return [NSDate USDateFormat:@"MMM dd, yyyy" timestamp:timestamp];
}

+(NSString*)USDateLongFormatWithTimestamp:(long long)timestamp{
    return [NSDate USDateFormat:@"MMMM dd, yyyy" timestamp:timestamp];
}

+(NSString*)USDateFormat:(NSString*)dateFormat  timestamp:(long long)timestamp{
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:dateFormat];
    [formatter setLocale:usLocale];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:timestamp/ 1000.0];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}

@end
