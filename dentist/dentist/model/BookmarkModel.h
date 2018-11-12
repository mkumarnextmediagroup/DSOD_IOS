//
//  BookmarkModel.h
//  dentist
//
//  Created by feng zhenrong on 2018/10/26.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface BookmarkModel : JSONModel
@property NSString <Optional>*_id;
@property NSString <Optional>*email;
@property NSString <Optional>*url;
@property NSString <Optional>*title;
@property NSString <Optional>*postId;
@property NSString <Optional>*create_time;
@property NSString <Optional>*categoryId;
@property NSString <Optional>*categoryName;
@property NSString <Optional>*contentTypeId;
@property NSString <Optional>*contentTypeName;
@property NSString <Optional>*coverUrl;
@property NSString <Optional>*coverthumbnailUrl;
@end

NS_ASSUME_NONNULL_END
