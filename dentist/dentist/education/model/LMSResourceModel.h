//
//  LMSResourceModel.h
//  dentist
//
//  Created by Shirley on 2019/2/28.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "DateTime.h"
#import "DentistDownloadModel.h"


@protocol  LMSResourceModel<NSObject>

@end

@interface LMSResourceModel : JSONModel


@property NSString <Optional>*id;
@property NSString <Optional>*courseId;
@property BOOL uploadScormCloud;
@property NSInteger resourceType;
@property NSString <Optional>*fileSize;
@property NSString <Optional>*version;
@property NSString <Optional>*name;
@property NSString <Optional>*lessonId;
@property NSString <Optional>*timeRequired;
@property NSString <Optional>*scormCourseID;
@property NSString <Optional>*resource;
@property DateTime <Optional>*publishDate;


//local property
@property (nonatomic,strong) DentistDownloadModel *downloadModel;

@end

