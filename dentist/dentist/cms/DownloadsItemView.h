//
//  DownloadsItemView.h
//  dentist
//
//  Created by cstLBY on 2018/9/19.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Article;
@interface DownloadsItemView : UIView
@property (strong, nonatomic)UIButton *markButton;
-(void) bind:(Article*)item ;
@end
