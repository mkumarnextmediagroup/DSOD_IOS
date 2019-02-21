//
//  MoreView.h
//  dentist
//
//  Created by 孙兴国 on 2018/12/2.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MoreViewDelegate <NSObject>

@optional
- (void)moreActionClick:(NSInteger)index;
- (void)moreViewClose:(NSInteger)index;
@end

@interface MoreView : UIView
@property (nonatomic,assign) NSInteger selectIndex;
@property (nonatomic,weak) id<MoreViewDelegate> delegate;

+ (instancetype)initSliderView;
- (void)showFuntionBtn;
- (void)hideFuntionBtn;
- (void)initSubView;

@end
