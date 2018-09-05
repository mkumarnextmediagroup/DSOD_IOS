//
//  CustomPicker.h
//  dentist
//
//  Created by Jacksun on 2018/9/4.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseController.h"

@interface CustomPicker : UIPickerView

@property (strong, nonatomic)NSArray *infoArr;

- (void)showPicker;

- (void)hidePicker;

- (void)initPicker;
@end
