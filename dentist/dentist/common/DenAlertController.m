//
//  DenAlertController.m
//  dentist
//
//  Created by Jacksun on 2018/8/28.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "DenAlertController.h"

//toast默认展示时间
static NSTimeInterval const DenAlertShowDurationDefault = 1.0f;


#pragma mark - I.AlertActionModel
@interface DenAlertActionModel : NSObject
@property (nonatomic, copy) NSString * title;
@property (nonatomic, assign) UIAlertActionStyle style;
@end
@implementation DenAlertActionModel
- (instancetype)init
{
    if (self = [super init]) {
        self.title = @"";
        self.style = UIAlertActionStyleDefault;
    }
    return self;
}
@end



#pragma mark - II.DenAlertController
/**
 AlertActions配置
 
 @param actionBlock DenAlertActionBlock
 */
typedef void (^DenAlertActionsConfig)(DenAlertActionBlock actionBlock);


@interface DenAlertController ()
//DenAlertActionModel数组
@property (nonatomic, strong) NSMutableArray <DenAlertActionModel *>* Den_alertActionArray;
//是否操作动画
@property (nonatomic, assign) BOOL Den_setAlertAnimated;
//action config
- (DenAlertActionsConfig)alertActionsConfig;
@end

@implementation DenAlertController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    if (self.alertDidDismiss) {
        self.alertDidDismiss();
    }
}
- (void)dealloc
{
    //    NSLog(@"test-dealloc");
}

#pragma mark - Private
//action-title数组
- (NSMutableArray<DenAlertActionModel *> *)Den_alertActionArray
{
    if (_Den_alertActionArray == nil) {
        _Den_alertActionArray = [NSMutableArray array];
    }
    return _Den_alertActionArray;
}
//action config
- (DenAlertActionsConfig)alertActionsConfig
{
    return ^(DenAlertActionBlock actionBlock) {
        if (self.Den_alertActionArray.count > 0)
        {
            //create action
            __weak typeof(self)weakSelf = self;
            [self.Den_alertActionArray enumerateObjectsUsingBlock:^(DenAlertActionModel *actionModel, NSUInteger idx, BOOL * _Nonnull stop) {
                UIAlertAction *alertAction = [UIAlertAction actionWithTitle:actionModel.title style:actionModel.style handler:^(UIAlertAction * _Nonnull action) {
                    __strong typeof(weakSelf)strongSelf = weakSelf;
                    if (actionBlock) {
                        actionBlock(idx, action, strongSelf);
                    }
                }];
                //action作为self元素，其block实现如果引用本类指针，会造成循环引用
                [self addAction:alertAction];
            }];
        }
        else
        {
            NSTimeInterval duration = self.toastStyleDuration > 0 ? self.toastStyleDuration : DenAlertShowDurationDefault;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self dismissViewControllerAnimated:!(self.Den_setAlertAnimated) completion:NULL];
            });
        }
    };
}

#pragma mark - Public

- (instancetype)initAlertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle
{
    if (!(title.length > 0) && (message.length > 0) && (preferredStyle == UIAlertControllerStyleAlert)) {
        title = @"";
    }
    self = [[self class] alertControllerWithTitle:title message:message preferredStyle:preferredStyle];
    if (!self) return nil;
    
    self.Den_setAlertAnimated = NO;
    self.toastStyleDuration = DenAlertShowDurationDefault;
    
    return self;
}

- (void)alertAnimateDisabled
{
    self.Den_setAlertAnimated = YES;
}

- (DenAlertActionTitle)addActionDefaultTitle
{
    //该block返回值不是本类属性，只是局部变量，不会造成循环引用
    return ^(NSString *title) {
        DenAlertActionModel *actionModel = [[DenAlertActionModel alloc] init];
        actionModel.title = title;
        actionModel.style = UIAlertActionStyleDefault;
        [self.Den_alertActionArray addObject:actionModel];
        return self;
    };
}

- (DenAlertActionTitle)addActionCancelTitle
{
    return ^(NSString *title) {
        DenAlertActionModel *actionModel = [[DenAlertActionModel alloc] init];
        actionModel.title = title;
        actionModel.style = UIAlertActionStyleCancel;
        [self.Den_alertActionArray addObject:actionModel];
        return self;
    };
}

- (DenAlertActionTitle)addActionDestructiveTitle
{
    return ^(NSString *title) {
        DenAlertActionModel *actionModel = [[DenAlertActionModel alloc] init];
        actionModel.title = title;
        actionModel.style = UIAlertActionStyleDestructive;
        [self.Den_alertActionArray addObject:actionModel];
        return self;
    };
}

@end



#pragma mark - III.UIViewController扩展
@implementation UIViewController (DenAlertController)

- (void)Den_showAlertWithPreferredStyle:(UIAlertControllerStyle)preferredStyle title:(NSString *)title message:(NSString *)message appearanceProcess:(DenAlertAppearanceProcess)appearanceProcess actionsBlock:(DenAlertActionBlock)actionBlock
{
    if (appearanceProcess)
    {
        DenAlertController *alertMaker = [[DenAlertController alloc] initAlertControllerWithTitle:title message:message preferredStyle:preferredStyle];
        //Prevent nil
        if (!alertMaker) {
            return ;
        }
        appearanceProcess(alertMaker);
        //配置响应
        alertMaker.alertActionsConfig(actionBlock);
        
        if (alertMaker.alertDidShown)
        {
            [self presentViewController:alertMaker animated:!(alertMaker.Den_setAlertAnimated) completion:^{
                alertMaker.alertDidShown();
            }];
        }
        else
        {
            [self presentViewController:alertMaker animated:!(alertMaker.Den_setAlertAnimated) completion:NULL];
        }
    }
}

- (void)Den_showAlertWithTitle:(NSString *)title message:(NSString *)message appearanceProcess:(DenAlertAppearanceProcess)appearanceProcess actionsBlock:(DenAlertActionBlock)actionBlock
{
    [self Den_showAlertWithPreferredStyle:UIAlertControllerStyleAlert title:title message:message appearanceProcess:appearanceProcess actionsBlock:actionBlock];
}

- (void)Den_showActionSheetWithTitle:(NSString *)title message:(NSString *)message appearanceProcess:(DenAlertAppearanceProcess)appearanceProcess actionsBlock:(DenAlertActionBlock)actionBlock
{
    [self Den_showAlertWithPreferredStyle:UIAlertControllerStyleActionSheet title:title message:message appearanceProcess:appearanceProcess actionsBlock:actionBlock];
}

@end
