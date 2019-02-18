//
//  DateTime.h
//  dentist
//
//  Created by Shirley on 2019/2/18.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "JSONAPI.h"

NS_ASSUME_NONNULL_BEGIN

@interface DateTime : JSONModel

@property NSInteger year;
@property NSInteger month;
@property NSInteger day;
@property NSInteger hours;
@property NSInteger minutes;
@property NSInteger seconds;

@property NSInteger date;

@property NSInteger nanos;
@property NSInteger timezoneOffset;
@property long time;

@end

NS_ASSUME_NONNULL_END
