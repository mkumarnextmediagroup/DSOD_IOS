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
    
@end

NS_ASSUME_NONNULL_END
