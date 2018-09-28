//
//  DentistFilterView.h
//  dentist
//
//  Created by cstLBY on 2018/9/19.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^DentistFilterViewCloseActionBlock) (void);
@interface DentistFilterView : UIView<UITextFieldDelegate>
/** closeblock */
@property (copy, nonatomic) DentistFilterViewCloseActionBlock closeBlock;

-(void)show;

-(void)show:(DentistFilterViewCloseActionBlock)closeActionBlock;
@end
