//
//  DentistFilterView.h
//  dentist
//
//  Created by cstLBY on 2018/9/19.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^DentistFilterViewCloseActionBlock) (NSString *category,NSString *type);
typedef void (^DentistFilterViewSelectActionBlock) (NSString *category,NSString *type);
@interface DentistFilterView : UIView<UITextFieldDelegate>
/** closeblock */
@property (copy, nonatomic) DentistFilterViewCloseActionBlock closeBlock;
/** selectblock */
@property (copy, nonatomic) DentistFilterViewSelectActionBlock selectBlock;

@property (nonatomic,strong) NSString *categorytext;
@property (nonatomic,strong) NSString *typetext;
-(void)show;

-(void)show:(DentistFilterViewCloseActionBlock)closeActionBlock;
-(void)show:(DentistFilterViewCloseActionBlock)closeActionBlock select:(DentistFilterViewSelectActionBlock)selectActionBlock;
@end
