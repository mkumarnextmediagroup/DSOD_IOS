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
#import "Author.h"
#import "MagazineModel.h"

NS_ASSUME_NONNULL_BEGIN


@interface DetailModel : JSONModel


@property NSString <Optional>*id;
@property NSString <Optional>*email;
@property NSString <Optional>*title;
@property NSString <Optional>*content;
@property NSString <Optional>*authorId;
@property NSString <Optional>*contentTypeId;
@property NSString <Optional>*categoryId;
@property NSString <Optional>*sponsorId;
@property NSString <Optional>*authorPhotoUrl;
@property Author   <Optional>*author;
@property NSString <Optional>*contentTypeName;
@property NSString <Optional>*categoryName;
@property NSString <Optional>*sponsorName;
@property NSString <Optional>*featuredMediaId;
@property NSArray  <Optional>*photoUrls;
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
@property NSArray  <CommentModel *><Optional> *comment;
@property NSArray  <Optional>*discussInfos;
@property NSString <Optional>*publishDate;
@property NSString <Optional>*isFeatured;
@property NSInteger readNumber;
@property NSDictionary <Optional>*featuredMedia;
@property NSArray <Optional>*relativeTopicList;
@property NSString <Optional>*uniteid;
@property MagazineModel <Optional> *magazineModel;


@end



NS_ASSUME_NONNULL_END
