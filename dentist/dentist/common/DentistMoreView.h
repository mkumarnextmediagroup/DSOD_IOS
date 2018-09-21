//
//  DentistMoreView.h
//  dentist
//
//  Created by cstLBY on 2018/9/21.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^DentistMoreViewSelectActionBlock) (NSInteger index);
@interface DentistMoreView : UIView
/** selectblock */
@property (copy, nonatomic) DentistMoreViewSelectActionBlock selectBlock;
//弹出
-(void)show;
//弹出
-(void)show:(DentistMoreViewSelectActionBlock)selectActionBlock;
@end
