//
//  EditPracticeAddressViewController.h
//  dentist
//
//  Created by wennan on 2018/9/9.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseController.h"

@class Address;

@interface EditPracticeAddressViewController : BaseController
@property(strong, nonatomic) NSString *selectPracticeAddress;
@property(copy, nonatomic) void (^saveBtnClickBlock)(NSString *code);
@property Address *address;
@end
