//
//  DentistFilterView.h
//  dentist
//
//  Created by cstLBY on 2018/9/19.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^DentistFilterViewCloseActionBlock) (NSString *category,NSString *type);
@interface DentistFilterView : UIView<UITextFieldDelegate>
/** closeblock */
@property (copy, nonatomic) DentistFilterViewCloseActionBlock closeBlock;
@property (nonatomic,strong) NSString *categorytext;
@property (nonatomic,strong) NSString *typetext;
-(void)show;

-(void)show:(DentistFilterViewCloseActionBlock)closeActionBlock;
@end
