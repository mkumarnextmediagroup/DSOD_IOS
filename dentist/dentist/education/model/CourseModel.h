//
//  CourseModel.h
//  dentist
//
//  Created by Shirley on 2019/2/15.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "JSONAPi.h"

NS_ASSUME_NONNULL_BEGIN

@interface CourseModel : JSONModel
@property NSString <Optional>*id;
@property NSString <Optional>*image;
@property NSString <Optional>*sponsoredId;

@property NSString <Optional>*name;
@property float price;
@property NSString <Optional>*beginner;
@property float rating;
@property NSString <Optional>* timeRequired;
@property NSString <Optional>*courseDescription;



@property BOOL featured;
@property BOOL mustPay;
@property BOOL free;
@property NSString <Optional>*notes;
@property NSInteger *expireType;// 0.none  1.date 2.duration
@property NSString <Optional>*ownerId;
@property NSString <Optional>*ownerName;
@property NSInteger *testPassingScore;
@property NSString <Optional>*oldVersionCourseId;
@property NSInteger expireDuration;
@property NSInteger activeStatus;
@property NSString <Optional>* curriculumId;
@property NSString <Optional>* categoryId;

@property NSDictionary <Optional>*expiryDate;
@property NSDictionary <Optional>*accessDate;
@property NSArray <Optional>*courseEnrollments;//TODO
@property NSArray <Optional>*authorIds;//TODO
@property NSArray <Optional>*resources;//TODO
@property NSArray <Optional>*lessons;//TODO
@property NSArray <Optional>*tests;//TODO

@end

NS_ASSUME_NONNULL_END
