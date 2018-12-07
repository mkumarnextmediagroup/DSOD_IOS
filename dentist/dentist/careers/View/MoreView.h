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
@end

@interface MoreView : UIView

+ (instancetype)initSliderView;
@property (nonatomic,weak) id<MoreViewDelegate> delegate;
- (void)showFuntionBtn;
- (void)hideFuntionBtn;

@end
