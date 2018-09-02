//
//  UISearchBarView.h
//  CSTMall
//
//  Created by cst on 15/8/26.
//  Copyright (c) 2015年 cst. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITextFieldCustom.h"

@protocol UISearchBarViewDelegate <NSObject>

- (void)updateTheSearchText:(NSString *)fieldTest;

@end

@interface UISearchBarView : UIView

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIImageView *searchImg;
@property (nonatomic, assign) id<UISearchBarViewDelegate> delegate;
@end
