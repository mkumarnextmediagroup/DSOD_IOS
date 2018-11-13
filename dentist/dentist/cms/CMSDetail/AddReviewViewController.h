//
//  AddReviewViewController.h
//  dentist
//
//  Created by 孙兴国 on 2018/10/16.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScrollPage.h"

typedef void(^AddReviewSuccessCallbak)(void);

@interface AddReviewViewController : ScrollPage

@property (nonatomic,strong) NSString *contentId;
@property (nonatomic,copy) AddReviewSuccessCallbak addReviewSuccessCallbak;

@end
