//
//  ViewAllViewController.h
//  dentist
//
//  Created by Jacksun on 2018/10/17.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScrollPage.h"
#import "DiscussInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface ViewAllViewController : ScrollPage

@property NSArray<DiscussInfo *> *discussInfo;

@end

NS_ASSUME_NONNULL_END
