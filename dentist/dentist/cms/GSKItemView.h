//
//  GSKItemView.h
//  dentist
//
//  Created by 孙兴国 on 2018/10/13.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Article.h"

@class CMSModel;
@protocol GSKItemViewViewDelegate <NSObject>

@optional
- (void)GSKCategoryPickerSelectAction:(NSString *)result;
- (void)articleMoreAction:(NSInteger)articleid;
- (void)articleMarkAction:(NSInteger)articleid;
- (void)articleMarkActionView:(NSObject *)item view:(UIView *)view;
@end
@interface GSKItemView : UIView

@property (strong, nonatomic) UIButton *moreButton;
@property (nonatomic,weak) id<GSKItemViewViewDelegate>delegate;
@property (strong, nonatomic) Article *model;
@property (strong, nonatomic) CMSModel *cmsmodel;

-(void) bind:(Article*)item ;
-(void) bindCMS:(CMSModel*)item;
-(void) updateBookmarkStatus:(BOOL)ismark;

@end
