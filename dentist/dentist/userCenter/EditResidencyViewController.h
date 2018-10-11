//
//  EditResidencyViewController.h
//  dentist
//
//  Created by Jacksun on 2018/9/6.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScrollPage.h"

@class Residency;

@interface EditResidencyViewController : ScrollPage<UITextFieldDelegate>

@property(nullable) Residency *residency;
@property BOOL isAdd;
@property(nonnull) void (^saveCallback)(Residency * _Nullable r);
@property(nonnull) void (^deleteCallback)(Residency * _Nullable exp);

@end
