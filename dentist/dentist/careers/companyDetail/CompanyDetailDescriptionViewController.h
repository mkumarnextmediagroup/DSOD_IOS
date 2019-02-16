//
//  CompanyDetailDescriptionViewController.h
//  dentist
//
//  Created by Shirley on 2018/12/8.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CompanyDetailDescriptionViewController : UIViewController

// 是否可以滑动
//Is it currently possible to scroll
@property (nonatomic, assign) BOOL isCanScroll;
// 不滑动事件
// Callback function when scrolling is not possible
@property (nonatomic, copy) void(^noScrollAction)(void) ;


/**
 滚动到初始位置
 Scroll to the initial position
 */
-(void)contentOffsetToPointZero;

/**
 view did load
 */
- (void)viewDidLoad;
/**
 Get internal padding
 subview overwrite
 
 @return UIEdgeInsets
 */
- (UIEdgeInsets)edgeInsetsMake;
/**
 set data
 
 @param description text
 */
- (void)setData:(NSString*)description;
/**
 show content，load html
 
 @param html html content
 */
- (void)showContent:(NSString*)html;
/**
 UIScrollViewDelegate
 scroll view did scroll
 
 @param scrollView UIScrollView
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;


@end

NS_ASSUME_NONNULL_END
