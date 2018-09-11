//
//  EditEduViewController.h
//  dentist
//
//  Created by Jacksun on 2018/9/3.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScrollPage.h"

@class Education;

@interface EditEduViewController : ScrollPage

@property Education *education;
@property BOOL isAdd;
@property(nonnull) void (^saveCallback)(Education *e);
@property(nonnull) void (^deleteCallback)(Education *e);

@end
