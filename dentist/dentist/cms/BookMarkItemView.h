//
//  BookMarkItemView.h
//  dentist
//
//  Created by cstLBY on 2018/9/19.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Article;
@class BookmarkModel;
@protocol BookMarkItemViewDelegate <NSObject>

@optional
- (void)BookMarkAction:(NSInteger)articleid;
- (void)BookMarkActionModel:(BookmarkModel*)model;
@end
@interface BookMarkItemView : UIView
@property (nonatomic,weak) id<BookMarkItemViewDelegate>delegate;
@property (strong, nonatomic) Article *model;
@property (strong, nonatomic) BookmarkModel *bookmarkmodel;
-(void) bind:(Article*)item ;
-(void)bindCMS:(BookmarkModel *)item;
-(void)markAction:(UIButton *)sender;
@end
