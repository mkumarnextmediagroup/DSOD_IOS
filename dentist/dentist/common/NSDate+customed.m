//
//  NSDate+customed.m
//  dentist
//
//  Created by wanglibo on 2018/11/12.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "NSDate+customed.h"
#import "NSString+myextend.h"

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

+(NSString*)USDateTimeLongFormatWithStringTimestamp:(NSString*)timestamp{
    if (timestamp.length>=13) {
        timestamp=[timestamp substringToIndex:10];
    }
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    NSDate *date= [NSDate dateWithTimeIntervalSince1970:[timestamp longLongValue]];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-DD HH:MM:SS"];
    [formatter setLocale:usLocale];
    NSString *dateString  = [formatter stringFromDate: date];
    return dateString;
}

+(BOOL)compareDatetimeIn30:(NSString *)timestamp
{
    if (![NSString isBlankString:timestamp]) {
        if (timestamp.length>=13) {
            timestamp=[timestamp substringToIndex:10];
        }
        NSTimeInterval comparetime=[timestamp longLongValue];
        BOOL result=NO;
        NSTimeInterval datetimenow=[[NSDate date] timeIntervalSince1970];
        if (datetimenow-comparetime<=(30*24*60*60)) {
            result=YES;
        }
        return result;
    }else{
        return NO;
    }
    
}

+(NSInteger)getDifferenceByTimestamp:(NSString *)timestamp {
    if (![NSString isBlankString:timestamp]) {
        if (timestamp.length>=13) {
            timestamp=[timestamp substringToIndex:10];
        }
        NSDate *endDate= [NSDate dateWithTimeIntervalSince1970:[timestamp longLongValue]];
        //创建两个日期
        NSDate *startDate = [NSDate date];
        //利用NSCalendar比较日期的差异
        NSCalendar *calendar = [NSCalendar currentCalendar];
        /**
         * 要比较的时间单位,常用如下,可以同时传：
         *    NSCalendarUnitDay : 天
         *    NSCalendarUnitYear : 年
         *    NSCalendarUnitMonth : 月
         *    NSCalendarUnitHour : 时
         *    NSCalendarUnitMinute : 分
         *    NSCalendarUnitSecond : 秒
         */
        NSCalendarUnit unit = NSCalendarUnitDay;//只比较天数差异
        //比较的结果是NSDateComponents类对象
        NSDateComponents *delta = [calendar components:unit fromDate:startDate toDate:endDate options:0];
        //打印
        NSLog(@"%@",delta);
        //获取其中的"天"
        NSLog(@"%ld",delta.day);
        return delta.day;
    }else{
        return -1;
    }
    
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
