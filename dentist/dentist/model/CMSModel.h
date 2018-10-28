//
//  CMSModel.h
//  dentist
//
//  Created by Jacksun on 2018/10/24.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "CMSModelComment.h"

NS_ASSUME_NONNULL_BEGIN

@interface CMSModel : JSONModel
@property NSString <Optional>*id;
@property NSString <Optional>*content;
@property NSString <Optional>*categoryId;
@property NSString <Optional>*contentTypeId;
@property NSString <Optional>*sponserId;
@property NSString <Optional>*authorId;
@property NSString <Optional>*categoryName;
@property NSString <Optional>*sponserName;
@property NSString <Optional>*authorName;
@property NSString <Optional>*email;
@property NSString <Optional>*featuredMediaId;
@property NSInteger isComplete;
@property NSInteger isPrivate;
@property NSInteger isPublishNow;
@property NSInteger isBookmark;
@property NSArray  <Optional>*photos;
@property NSArray  <Optional>*podcasts;
@property NSString <Optional>*title;
@property NSArray  <Optional>*videos;
@property NSString  <Optional>*nextContentId;
@property NSString  <Optional>*previousContentId;
@property NSString  <Optional>*countOfComment;
@property NSString  <Optional>*avgCommentRating;
@property NSString  <Optional>*publishDate;
@property NSString  <Optional>*readNumber;
@property NSArray   <CMSModelComment*><Optional> *comment;

@end

NS_ASSUME_NONNULL_END
