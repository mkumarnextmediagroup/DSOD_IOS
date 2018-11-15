//
//  SliderListView.h
//  dentist
//
//  Created by Jacksun on 2018/11/7.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SliderListView : UIView

+ (instancetype)sharedInstance:(UIView *)view isSearch:(BOOL)isSearch magazineId:(NSString * _Nullable)magazineId;

- (void)showSliderView;

- (void)hideSliderView;

@end

NS_ASSUME_NONNULL_END
