//
//  TextFieldImageView.h
//  dentist
//
//  Created by feng zhenrong on 2018/12/20.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TextFieldImageView : UIView
@property(nonatomic,strong) UIImageView *iconView;
@property(readonly) UITextField *edit;
@end

NS_ASSUME_NONNULL_END
