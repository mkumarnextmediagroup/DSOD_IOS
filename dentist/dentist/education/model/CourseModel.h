//
//  CourseModel.h
//  dentist
//
//  Created by Shirley on 2019/2/15.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "JSONAPi.h"
#import "DateTime.h"
#import "LMSLessonModel.h"
#import "LMSResourceModel.h"

NS_ASSUME_NONNULL_BEGIN

//    0:未注册 1:注册未开课 2:已开课 3:已完成
//    0:not enroll 1:not start 2:in progress 3:complete

typedef NS_ENUM(NSInteger, CourseStatus) {
    NotEnroll = 0,
    NotStart,
    InProgress,
    complete
};

@interface CourseModel : JSONModel
@property NSString <Optional>*id;
@property NSString <Optional>*image;
@property NSString <Optional>*sponsoredId;

@property NSString <Optional>*name;
@property float price;
@property NSString <Optional>*level;//1.beginner，2.intermediate，3.advanced，4.expert
@property float rating;
@property NSString <Optional>* timeRequired;
@property NSString <Optional>*courseDescription;
@property BOOL isBookmark;
@property BOOL hasCertificate;
@property BOOL mustPay;
@property BOOL free;

@property NSArray <Optional>*authorIds;
@property NSArray <LMSLessonModel,Optional>*lessons;
@property NSArray <LMSResourceModel,Optional>*resources;





//not use property
@property BOOL featured;
@property NSString <Optional>*notes;
@property NSInteger expireType;// 0.none  1.date 2.duration
@property NSString <Optional>*ownerId;
@property NSString <Optional>*ownerName;
@property float testPassingScore;
@property NSString <Optional>*oldVersionCourseId;
@property NSInteger expireDuration;
@property NSInteger activeStatus;
@property NSString <Optional>* curriculumId;
@property NSString <Optional>* categoryId;
@property DateTime <Optional>*expiryDate;
@property DateTime <Optional>*accessDate;
@property NSArray <Optional>*courseEnrollments;//TODO
@property NSArray <Optional>*tests;//TODO


//local property
@property (nonatomic,strong) NSString <Ignore>*levelString;
/**
 根据注册情况和开课情况总结状态
 Summarize the course status according to the registration and class opening
 */
@property (nonatomic,assign) CourseStatus courseStatus;

@end

NS_ASSUME_NONNULL_END
