//
//  PickerViewController.h
//  dentist
//
//  Created by Jacksun on 2018/9/5.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseController.h"

@interface PickerViewController : UIViewController

@property (strong, nonatomic)NSArray *infoArr;

@property (copy,nonatomic)void(^pickerSelectBlock)(NSString *);

- (void)showPicker;

- (void)hidePicker;

- (void)initPicker;


@end
