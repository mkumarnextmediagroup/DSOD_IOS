//
//  CMSModelComment.h
//  dentist
//
//  Created by feng zhenrong on 2018/10/25.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface CMSModelComment : JSONModel
/**用户邮箱**/
@property NSString *email;
/**评论分数**/
@property NSString *commentRating;
/**评论内容**/
@property NSString *commentText;
/**创建时间**/
@property NSString *createTime;
@end

