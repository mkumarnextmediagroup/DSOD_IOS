//
//  CMSModel.h
//  dentist
//
//  Created by Jacksun on 2018/10/24.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CMSModel : JSONModel

@property NSString *content;
@property NSString *categoryId;
@property NSString *contentTypeId;
@property NSString *sponserId;
@property NSString *authorId;
@property NSString *categoryName;
@property NSString *sponserName;
@property NSString *authorName;
@property NSString *email;
@property NSString *featuredMediaId;
@property NSString *isComplete;
@property NSString *isPrivate;
@property NSString *isPublishNow;
@property NSArray  *photos;
@property NSArray  *podcasts;
@property NSString *title;
@property NSArray  *videos;

@end

NS_ASSUME_NONNULL_END
