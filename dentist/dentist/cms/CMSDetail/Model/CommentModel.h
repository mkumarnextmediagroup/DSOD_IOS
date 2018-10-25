//
//  CommentModel.h
//  dentist
//
//  Created by Jacksun on 2018/10/25.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CommentModel : JSONModel

@property NSString *email;
@property NSString *commentRating;
@property NSString *commentText;
@property NSString *createTime;

@end

NS_ASSUME_NONNULL_END
