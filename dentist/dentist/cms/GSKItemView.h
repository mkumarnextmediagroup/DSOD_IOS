//
//  GSKItemView.h
//  dentist
//
//  Created by 孙兴国 on 2018/10/13.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Article.h"

@interface GSKItemView : UIView

@property (strong, nonatomic) UIButton *moreButton;

-(void) bind:(Article*)item ;

@end
