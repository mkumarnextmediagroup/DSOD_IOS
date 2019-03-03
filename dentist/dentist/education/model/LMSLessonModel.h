//
//  LMSLessonsModel.h
//  dentist
//
//  Created by Shirley on 2019/2/28.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "DateTime.h"
#import "LMSResourceModel.h"
#import "DentistDownloadModel.h"

NS_ASSUME_NONNULL_BEGIN
@protocol  LMSLessonModel<NSObject>

@end

@interface LMSLessonModel : JSONModel

@property NSString <Optional>*id;
@property NSString <Optional>*courseId;
@property float weight;
@property float passingScore;
@property NSString <Optional>*name;
@property NSString <Optional>*timeRequired;
@property NSString <Optional>*notes;
@property NSString <Optional>*lessonDescription;
@property DateTime <Optional>*createTime;

@property NSArray <LMSResourceModel,Optional>*resources;
@property NSArray <Optional>*tests;//TODO



@end

NS_ASSUME_NONNULL_END
