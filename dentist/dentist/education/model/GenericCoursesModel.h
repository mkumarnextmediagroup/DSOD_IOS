//
//  GenericCoursesModel.h
//  dentist
//
//  Created by feng zhenrong on 2019/2/15.
//  Copyright © 2019年 thenextmediagroup.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "AuthorModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface GenericCoursesModel : JSONModel
//ID
@property NSString *id;
//name
@property NSString *name;
//Course category ID
@property NSString *curriculumId;
//category ID
@property NSString *categoryId;
//description
@property NSString <Optional>*descriptions;
@property NSString <Optional>*notes;
@property NSInteger expireType;
@property NSInteger expireDuration;
//@property NSTimeInterval expiryDate;//收藏列表接口字段类型与其他接口不一致，这个会报错，这个字段现在没有用，先注释掉，--wanglibo 20190221
//@property NSTimeInterval accessDate;//收藏列表接口字段类型与其他接口不一致，这个会报错，这个字段现在没有用，先注释掉，--wanglibo 20190221
@property NSInteger activeStatus;
@property double price;
@property BOOL free;
@property BOOL testPassingScore;
@property BOOL mustPay;
@property NSString <Optional>*ownerId;
@property NSString <Optional>*ownerName;
@property NSString <Optional>*timeRequired;
@property double rating;
@property NSString <Optional>*image;
@property NSString <Optional>*oldVersionCourseID;
@property NSArray <Optional>*authorIds;
@property NSArray <Optional>*authors;
@property NSString <Optional>*sponsoredId;
@property BOOL isBookmark;
@property NSString <Optional>*level;//1.beginner，2.intermediate，3.advanced，4.expert
@end

NS_ASSUME_NONNULL_END
