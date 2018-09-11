//
//  EditPracticeAddressViewController.h
//  dentist
//
//  Created by wennan on 2018/9/9.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScrollPage.h"

@class Address;

@interface EditPracticeAddressViewController : ScrollPage

@property(nullable) Address *address;
@property void (^saveCallback)(Address *address);

@end
