//
//  UniteThumCollectionViewCell.h
//  dentist
//
//  Created by feng zhenrong on 2018/11/6.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailModel.h"

@protocol UniteThumCollectionViewCellDelegate <NSObject>

@optional
- (void)UniteThumCollectionViewCellScroview:(CGFloat)offsety;

- (void)hideNavBar:(BOOL)hide;
@end
NS_ASSUME_NONNULL_BEGIN

@interface UniteThumCollectionViewCell : UICollectionViewCell
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,weak) id<UniteThumCollectionViewCellDelegate> delegate;
@property (nonatomic,assign) CGFloat cellcontentInsetTop;

-(void)bind:(DetailModel*)model;
-(instancetype)initWithFrame:(CGRect)frame;
-(void)buildView;
-(void)buildTitleView;
-(void)buildSwipeView;
-(void)showAD:(MagazineModel*)model;
-(void)showCover:(MagazineModel*)model;
-(void)showIntroduction:(DetailModel*)model;
-(void)showActicle:(DetailModel*)model;
- (void)calcWebViewHeight:(NSTimer*)timer;
- (void)webViewDidFinishLoad:(UIWebView *)webView;
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error;
-(void)scrollViewDidScroll:(UIScrollView *)scrollView;

@end

NS_ASSUME_NONNULL_END
