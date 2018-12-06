//
//  FilterView.h
//  dentist
//
//  Created by Jacksun on 2018/11/29.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol FilterViewDelegate <NSObject>

@optional
- (void)searchCondition:(NSDictionary *)condition;
@end

@interface FilterView : UIView

@property (nonatomic,weak) id<FilterViewDelegate> delegate;

+ (instancetype)initFilterView;
- (void)showFilter;
@end

NS_ASSUME_NONNULL_END
