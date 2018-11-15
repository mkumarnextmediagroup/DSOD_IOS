//
//  UIView+gesture.h
//  dentist
//
//  Created by Jacksun on 2018/11/13.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (gesture)

- (void)setTapActionWithBlock:(void (^)(void))block;

- (void)setLongPressActionWithBlock:(void (^)(void))block;

@end

NS_ASSUME_NONNULL_END
