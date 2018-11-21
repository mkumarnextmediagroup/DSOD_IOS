//
//  SliderListView.h
//  dentist
//
//  Created by Jacksun on 2018/11/7.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SliderListViewDelegate <NSObject>

@optional
- (void)gotoDetailPage:(NSString *)articleID;
@end


@interface SliderListView : UIView

/*
 * isSearch:YES is search page, NO is list Page
 * magazineId
 */

@property (nonatomic,weak) id<SliderListViewDelegate> delegate;

+ (instancetype)initSliderView:(BOOL)isSearch magazineId:(NSString * _Nullable)magazineId;
+(void)hideSliderView;
- (void)showSliderView;

@end

NS_ASSUME_NONNULL_END
