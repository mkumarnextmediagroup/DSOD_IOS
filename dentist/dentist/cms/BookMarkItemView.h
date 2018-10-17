//
//  BookMarkItemView.h
//  dentist
//
//  Created by cstLBY on 2018/9/19.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Article;
@protocol BookMarkItemViewDelegate <NSObject>

@optional
- (void)BookMarkAction:(NSInteger)articleid;;
@end
@interface BookMarkItemView : UIView
@property (nonatomic,weak) id<BookMarkItemViewDelegate>delegate;
@property (strong, nonatomic) Article *model;
-(void) bind:(Article*)item ;
@end
