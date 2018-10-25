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

@property NSString *id;
@property NSString *title;
@property NSString *author;
@property NSString *content;
@property NSString *releaseTime;
@property NSString *createTime;
@property NSString *contentTypeId;
@property NSString *contentTypeName;
@property NSString *categoryId;
@property NSString *categoryName;
@property NSString *sponserId;
@property NSString *authorId;
@property NSString *sponserName;
@property NSString *authorName;
@property BOOL     isBookmark;
@property NSString *contentUrl;
@property NSString *commentRating;
@property NSString *countOfComment;
@property NSString *featuredMediaId;
@property NSArray  *photos;
@property NSArray  *videos;
@property NSArray  *podcasts;
@property NSArray<CommentModel *> *comment;

@end

NS_ASSUME_NONNULL_END
