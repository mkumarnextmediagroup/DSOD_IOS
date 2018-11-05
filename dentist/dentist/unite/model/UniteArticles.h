//
//  UniteArticles.h
//  dentist
//
//  Created by Jacksun on 2018/11/5.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface UniteArticles : JSONModel

@property NSString <Optional>*issueNum;
@property NSString <Optional>*issuePage;
@property NSString <Optional>*category;
@property NSString <Optional>*issueHeading;
@property NSString <Optional>*issueSubHeading;

@end

NS_ASSUME_NONNULL_END
