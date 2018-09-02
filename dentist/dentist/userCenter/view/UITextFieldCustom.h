//
//  UITextFieldCustom.h
//  CSTMall
//
//  Created by cst on 15/8/27.
//  Copyright (c) 2015年 cst. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextFieldCustom : UITextField
{
    BOOL isEnablePadding;
    float paddingLeft;
    float paddingRight;
    float paddingTop;
    float paddingBottom;
}

- (void)setPadding:(BOOL)enable top:(float)top right:(float)right bottom:(float)bottom left:(float)left;

@end
