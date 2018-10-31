//
//  CmsArticleCategoryPage.h
//  dentist
//
//  Created by feng zhenrong on 2018/10/30.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "ListPage.h"

NS_ASSUME_NONNULL_BEGIN

@interface CmsArticleCategoryPage : ListPage
@property (nonatomic,strong) NSString *categoryId;
@property (nonatomic,strong) NSString *categoryName;
@end

NS_ASSUME_NONNULL_END
