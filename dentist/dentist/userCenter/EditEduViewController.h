//
//  EditEduViewController.h
//  dentist
//
//  Created by Jacksun on 2018/9/3.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseController.h"

@class Education;

@interface EditEduViewController : BaseController

@property (strong, nonatomic)NSString *addOrEdit;
@property Education * education ;

@end
