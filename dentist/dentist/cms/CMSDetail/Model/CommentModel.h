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

@protocol CommentModel
@end

@interface CommentModel : JSONModel

@property NSString *email;
@property NSString *comment_rating;
@property NSString *comment_text;
@property NSString *create_time;

    
@end

NS_ASSUME_NONNULL_END
