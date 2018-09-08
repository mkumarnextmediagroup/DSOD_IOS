//
//  UpdateViewController.h
//  dentist
//
//  Created by Jacksun on 2018/9/1.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseController.h"

@interface UpdateViewController : BaseController
@property (copy,nonatomic)void(^selctBtnClickBlock)(NSString *code);
@property (nonatomic,strong) NSMutableArray *dataList;
@property (copy, nonatomic) NSString *selectStr;
@end
