//
//  DentistPickerView.h
//  dentist
//
//  Created by cstLBY on 2018/9/19.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IdName;

typedef void (^DentistPickerViewLeftActionBlock) (NSString *result,NSString *resultname);
typedef void (^DentistPickerViewRightActionBlock) (NSString *result,NSString *resultname);
typedef void (^DentistPickerViewdidSelectActionBlock) (NSString *result,NSString *resultname);
@interface DentistPickerView : UIView
/** Leftblock */
@property (copy, nonatomic) DentistPickerViewLeftActionBlock leftBlock;
/** Rightblock */
@property (copy, nonatomic) DentistPickerViewRightActionBlock rightBlock;
/** Selectblock */
@property (copy, nonatomic) DentistPickerViewdidSelectActionBlock selectBlock;
/** array */
@property (nonatomic,strong) NSArray *array;
/** array */
@property (nonatomic,strong) NSArray<IdName*> *arrayDic;
/** title */
@property (nonatomic,strong) NSString *title;
/** lefttitle */
@property (nonatomic,strong) NSString *leftTitle;
/** righttitle */
@property (nonatomic,strong) NSString *righTtitle;
@property (nonatomic,strong) NSString *selectId;
//快速创建
+(instancetype)pickerView;
//弹出
-(void)show;
-(void)show:(DentistPickerViewLeftActionBlock)leftActionBlock rightAction:(DentistPickerViewRightActionBlock)rightActionBlock selectAction:(DentistPickerViewdidSelectActionBlock)selectActionBlock;

- (void)showIndicator;

- (void)hideIndicator;
@end
