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

/// 是否可以滑动
@property (nonatomic, assign) BOOL isCanScroll;
/// 不滑动事件
@property (nonatomic, copy) void(^noScrollAction)(void) ;

-(void)contentOffsetToPointZero;

- (void)viewDidLoad;
- (UIEdgeInsets)edgeInsetsMake;
- (void)setData:(NSString*)description;
- (void)showContent:(NSString*)html;
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;


@end

NS_ASSUME_NONNULL_END
