//
//  NSDate+customed.h
//  dentist
//
//  Created by wanglibo on 2018/11/12.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (customed)

+(NSString*)USDateShortFormatWithStringTimestamp:(NSString*)timestamp;

+(NSString*)USDateLongFormatWithStringTimestamp:(NSString*)timestamp;

+(NSString*)USDateShortFormatWithTimestamp:(long long)timestamp;

+(NSString*)USDateLongFormatWithTimestamp:(long long)timestamp;
+(NSString*)UTCDateTimeLongFormatWithStringTimestamp:(NSString*)timestamp;
+(BOOL)compareDatetimeIn30:(NSString *)timestamp;
+(NSInteger)getDifferenceByTimestamp:(NSString *)timestamp;

+(NSString*)USDateFormat:(NSString*)dateFormat  timestamp:(long long)timestamp;
// 时间转换为时间戳
+ (NSInteger)getTimeStampWithDate:(NSDate *)date;

// 时间戳转换为时间
+ (NSDate *)getDateWithTimeStamp:(NSInteger)timeStamp;
// 一个时间戳与当前时间的间隔（s）
+ (NSInteger)getIntervalsWithTimeStamp:(NSInteger)timeStamp;
    
@end

NS_ASSUME_NONNULL_END
