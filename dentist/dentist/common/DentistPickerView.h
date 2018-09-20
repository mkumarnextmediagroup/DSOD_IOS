//
//  DentistPickerView.h
//  dentist
//
//  Created by cstLBY on 2018/9/19.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^DentistPickerViewLeftActionBlock) (NSString *result);
typedef void (^DentistPickerViewRightActionBlock) (NSString *result);
typedef void (^DentistPickerViewdidSelectActionBlock) (NSString *result);
@interface DentistPickerView : UIView
/** Leftblock */
@property (copy, nonatomic) DentistPickerViewLeftActionBlock leftBlock;
/** Rightblock */
@property (copy, nonatomic) DentistPickerViewRightActionBlock rightBlock;
/** Selectblock */
@property (copy, nonatomic) DentistPickerViewdidSelectActionBlock selectBlock;
/** array */
@property (nonatomic,strong) NSArray *array;
/** title */
@property (nonatomic,strong) NSString *title;
/** lefttitle */
@property (nonatomic,strong) NSString *leftTitle;
/** righttitle */
@property (nonatomic,strong) NSString *righTtitle;
//快速创建
+(instancetype)pickerView;
//弹出
-(void)show;
-(void)show:(DentistPickerViewLeftActionBlock)leftActionBlock rightAction:(DentistPickerViewRightActionBlock)rightActionBlock selectAction:(DentistPickerViewdidSelectActionBlock)selectActionBlock;
@end
