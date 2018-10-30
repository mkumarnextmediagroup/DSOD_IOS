//
//  DetailModel.h
//  dentist
//
//  Created by Jacksun on 2018/10/25.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "CommentModel.h"

NS_ASSUME_NONNULL_BEGIN


@interface DetailModel : JSONModel


@property NSString <Optional>*id;
@property NSString *email;
@property NSString *title;
@property NSString *content;
@property NSString <Optional>*authorId;
@property NSString *contentTypeId;
@property NSString *categoryId;
@property NSString *sponsorId;
@property NSString <Optional>*authorName;
@property NSString *contentTypeName;
@property NSString *categoryName;
@property NSString *sponsorName;
@property NSString *featuredMediaId;
@property NSArray  <Optional>*photos;
@property NSArray  <Optional>*videos;
@property NSArray  <Optional>*podcasts;
@property BOOL     isPrivate;
@property BOOL     isComplete;
@property BOOL     isPublishNow;
@property BOOL     isBookmark;
@property NSString <Optional>*nextContentId;
@property NSString <Optional>*previousContentId;
@property NSString <Optional>*countOfComment;
@property NSString <Optional>*avgCommentRating;
@property NSArray  <CommentModel>*comment;
@property NSArray  <Optional>*discussInfos;
@property NSString *publishDate;
@property NSString <Optional>*isFeatured;
@property NSInteger readNumber;

@end



NS_ASSUME_NONNULL_END
