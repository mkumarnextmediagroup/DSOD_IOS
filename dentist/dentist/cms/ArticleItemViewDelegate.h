//
//  ArticleItemViewDelegate.h
//  dentist
//
//  Created by feng zhenrong on 2018/10/30.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CMSModel;
NS_ASSUME_NONNULL_BEGIN

@protocol ArticleItemViewDelegate <NSObject>
@optional
- (void)CategoryPickerSelectAction:(NSString *)result;
- (void)ArticleMoreAction:(NSInteger)articleid;
- (void)ArticleMarkAction:(NSInteger)articleid;
- (void)ArticleMarkActionModel:(CMSModel*)model;
@end

NS_ASSUME_NONNULL_END
