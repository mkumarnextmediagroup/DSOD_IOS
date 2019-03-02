//
//  LMSEnrollmentModel.h
//  dentist
//
//  Created by Shirley on 2019/2/28.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "GenericCoursesModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LMSEnrollmentModel : JSONModel

@property NSString *id;
@property NSString *courseId;
@property NSInteger status;//enrollment status NotStarted 0    InProgress  1   Complete 2
@property float progress;
@property float score;
@property long timeSpent;
@property long dateStarted;
@property long dateCompleted;
@property long dateExpires;
@property long enrollTime;
@property NSString *userId;
@property NSString *enrollmentKeyId;
@property NSString *certificateId;
@property BOOL isActive;
@property NSInteger enrollmentSource;
@property long createDate;
@property GenericCoursesModel *course;


//以下接口反 app未使用
//"dateStarted": null,
//"dateCompleted": null,
//"dateExpires": null,
//"enrollTime": 1551323160424,
//"userId": "8d030e40a01c4de8ae021803ad55108a",
//"enrollmentKeyId": null,
//"certificateId": null,
//"isActive": true,
//"enrollmentSource": 0,
//"createDate": null

@end


NS_ASSUME_NONNULL_END

