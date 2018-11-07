//
//  ActionSheet.h
//  mayc
//
//  Created by 孙兴国 on 2018/9/27.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DenActionSheet;
@protocol MyActionSheetDelegate <NSObject>

@optional
- (void)myActionSheet:(DenActionSheet *)actionSheet parentView:(UIView *)parentView subLabel:(UILabel *)subLabel index:(NSInteger)index;
@end


@interface DenActionSheet : UIView <MyActionSheetDelegate>

@property (nonatomic,strong) UIWindow *mywindow;
@property (nonatomic, strong) UIView *parentView;
@property (nonatomic, assign) id<MyActionSheetDelegate> delgate;
@property (nonatomic, assign) CGRect paretViewFrame;
@property (nonatomic, copy) NSString *titleName;

@property (nonatomic, strong) NSMutableArray *titleNameArr;
@property (nonatomic, strong) NSArray        *imageArr;

- (void)show;
- (void)show:(UIView *)superview;
-(void)updateActionTitle:(NSArray *)titlearr;
- (instancetype)initWithDelegate:(id)delegate title:(NSString *)title cancelButton:(NSString *)cancelButton imageArr:(NSArray *)imageArr otherTitle:(NSString *)otherTitle, ... NS_REQUIRES_NIL_TERMINATION;



@end
