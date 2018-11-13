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
#import "CMSModel.h"

@interface CMSDetailViewController : ScrollPage

@property DetailModel *articleInfo;
@property NSString *contentId;
@property NSString *toWhichPage;
@property (nonatomic,copy) NSArray *cmsmodelsArray;
@property (nonatomic,assign) BOOL goBackCloseAll;
@property (nonatomic,assign) BOOL hideChangePage;
@end
