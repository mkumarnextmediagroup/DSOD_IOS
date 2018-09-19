//
//  PlayerView.h
//  dentist
//
//  Created by 孙兴国 on 2018/9/19.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Article;

@interface PlayerView : UIView

-(void)bind:(Article *)bindInfo ;

- (void)resetLayout;

@end
