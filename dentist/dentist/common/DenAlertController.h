//
//  DenAlertController.h
//  dentist
//
//  Created by Jacksun on 2018/8/28.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

#pragma mark - I.the Constructor of DenAlertController

@class DenAlertController;
/**
 DenAlertController: alertAction配置链
 
 @param title title
 @return      DenAlertController object
 */
typedef DenAlertController * _Nonnull (^DenAlertActionTitle)(NSString *title);

/**
 DenAlertController: alert block
 
 @param buttonIndex button index(According to the order of adding action)
 @param action      UIAlertAction object
 @param alertSelf   self object
 */
typedef void (^DenAlertActionBlock)(NSInteger buttonIndex, UIAlertAction *action, DenAlertController *alertSelf);


NS_CLASS_AVAILABLE_IOS(8_0) @interface DenAlertController : UIAlertController


/**
 DenAlertController: 禁用alert弹出动画，默认执行系统的默认弹出动画
 */
- (void)alertAnimateDisabled;

/**
 DenAlertController: alert弹出后，可配置的回调
 */
@property (nullable, nonatomic, copy) void (^alertDidShown)(void);

/**
 DenAlertController: alert关闭后，可配置的回调
 */
@property (nullable, nonatomic, copy) void (^alertDidDismiss)(void);

/**
 DenAlertController: 设置toast模式展示时间：如果alert未添加任何按钮，将会以toast样式展示，这里设置展示时间，默认1s
 */
@property (nonatomic, assign) NSTimeInterval toastStyleDuration; //deafult Den_alertShowDurationDefault = 1s


/**
 DenAlertController: 链式构造alert视图按钮，添加一个alertAction按钮，默认样式，参数为标题
 
 @return DenAlertController对象
 */
- (DenAlertActionTitle)addActionDefaultTitle;

/**
 DenAlertController: 链式构造alert视图按钮，添加一个alertAction按钮，取消样式，参数为标题(warning:一个alert该样式只能添加一次!!!)
 
 @return DenAlertController对象
 */
- (DenAlertActionTitle)addActionCancelTitle;

/**
 DenAlertController: 链式构造alert视图按钮，添加一个alertAction按钮，警告样式，参数为标题
 
 @return DenAlertController对象
 */
- (DenAlertActionTitle)addActionDestructiveTitle;

@end


#pragma mark - II.UIViewController扩展使用DenAlertController

/**
 DenAlertController: alert构造块
 
 @param alertMaker DenAlertController配置对象
 */
typedef void(^DenAlertAppearanceProcess)(DenAlertController *alertMaker);

@interface UIViewController (DenAlertController)

/**
 DenAlertController: show-alert(iOS8)
 
 @param title             title
 @param message           message
 @param appearanceProcess alert配置过程
 @param actionBlock       alert点击响应回调
 */
- (void)Den_showAlertWithTitle:(nullable NSString *)title
                       message:(nullable NSString *)message
             appearanceProcess:(DenAlertAppearanceProcess)appearanceProcess
                  actionsBlock:(nullable DenAlertActionBlock)actionBlock NS_AVAILABLE_IOS(8_0);

/**
 DenAlertController: show-actionSheet(iOS8)
 
 @param title             title
 @param message           message
 @param appearanceProcess actionSheet配置过程
 @param actionBlock       actionSheet点击响应回调
 */
- (void)Den_showActionSheetWithTitle:(nullable NSString *)title
                             message:(nullable NSString *)message
                   appearanceProcess:(DenAlertAppearanceProcess)appearanceProcess
                        actionsBlock:(nullable DenAlertActionBlock)actionBlock NS_AVAILABLE_IOS(8_0);

@end

NS_ASSUME_NONNULL_END
