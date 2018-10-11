//
//  PlayerView.h
//  dentist
//
//  Created by 孙兴国 on 2018/9/19.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"

@class Article;

@interface PlayerView : UIView

@property (strong, nonatomic)SBPlayer *sbPlayer;

-(void)bind:(Article *)bindInfo ;
- (void)resetLayout;

@end
