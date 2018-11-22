//
//  UploadResumeItemView.h
//  dentist
//
//  Created by Shirley on 2018/11/18.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "BaseItemView.h"

NS_ASSUME_NONNULL_BEGIN

@interface UploadResumeItemView : BaseItemView

@property (nonatomic,assign) UIViewController *vc;

@property (nonatomic,strong) NSDictionary *resumeDataDic;

-(NSString*)getUploadedResumeName;

-(void)showWithLastResumeUrl:(NSString*)resumeUrl fileName:(NSString*)resumeName resumeDic:(NSDictionary* _Nullable)dic;

@end

NS_ASSUME_NONNULL_END
