//
//  EditResidencyViewController.h
//  dentist
//
//  Created by Jacksun on 2018/9/6.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseController.h"

@class Residency;

@interface EditResidencyViewController : BaseController

@property(strong, nonatomic) NSString *addOrEdit;
@property(assign, nonatomic) int      updateIndex;
@property Residency *residency;

@end
