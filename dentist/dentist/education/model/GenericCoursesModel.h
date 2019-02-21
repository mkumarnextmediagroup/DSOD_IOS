//
//  GenericCoursesModel.h
//  dentist
//
//  Created by feng zhenrong on 2019/2/15.
//  Copyright © 2019年 thenextmediagroup.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface GenericCoursesModel : JSONModel
//ID
@property NSString *id;
//name
@property NSString *name;
//Course category ID
@property NSString *curriculumId;
//category ID
@property NSString *categoryID;
//description
@property NSString *descriptions;
@property NSString *notes;
@property NSString *accessDate;
@property NSInteger expireType;
@property NSInteger expireDuration;
@property NSTimeInterval expiryDate;
@property NSInteger activeStatus;
@property double price;
@property BOOL free;
@property BOOL testPassingScore;
@property BOOL mustPay;
@property NSString *ownerId;
@property NSString *ownerName;
@property NSString *timeRequired;
@property NSString *beginner;
@property double rating;
@property NSString *image;
@property NSString *oldVersionCourseID;
@property NSArray *authorIds;
@property NSArray *authors;
@property NSString *sponsoredId;
@property BOOL isBookmark;
@end

NS_ASSUME_NONNULL_END
