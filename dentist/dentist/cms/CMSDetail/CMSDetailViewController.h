//
//  CMSDetailViewController.h
//  dentist
//
//  Created by 孙兴国 on 2018/9/19.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScrollPage.h"
#import "Article.h"
#import "DetailModel.h"

@interface CMSDetailViewController : ScrollPage

@property DetailModel *articleInfo;
@property NSString *toWhichPage;

@end
