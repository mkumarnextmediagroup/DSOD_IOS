//
//  NoIntenetViewController.m
//  dentist
//
//  Created by 孙兴国 on 2018/8/19.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "NoIntenetViewController.h"
#import "Common.h"
#import "Masonry.h"
#import "LoginController.h"
#import "UIControl+customed.h"
#import "UIView+customed.h"
#import "StudentController.h"
#import "StackLayout.h"
#import "UILabel+customed.h"
#import "NoticeViewController.h"

@interface NoIntenetViewController ()

@end

@implementation NoIntenetViewController

+ (instancetype)shareInstance
{
    static NoIntenetViewController *instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[NoIntenetViewController alloc] init];
    });
    
    return instance;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    UIView *alphaView = [[UIView alloc] initWithFrame:self.view.frame];
    UIView *baseView = [[UIView alloc] initWithFrame:self.view.frame];
    alphaView.backgroundColor = [UIColor clearColor];
    baseView.backgroundColor = [UIColor blackColor];
    baseView.alpha = 0.8;
    [self.view addSubview:baseView];
    [self.view addSubview:alphaView];
    
    
    UIImageView *backView = self.view.addImageView;
    backView.imageName = @"close_white";
    [backView scaleFit];
    [[[[backView.layoutMaker sizeEq:23 h:23] rightParent:-40] topParent:30] install];
    
    StackLayout *sl = [StackLayout new];
    
    UIView *checkPanel = self.view.addView;
    UIButton *retryBtn = checkPanel.retryBtn;
    [[[[[retryBtn layoutMaker] sizeEq:98 h:BTN_HEIGHT] leftParent:0] centerYParent:0] install];
    
    UIButton *needBtn = checkPanel.needHelpBtn;
    [[[[[needBtn layoutMaker] sizeEq:223 h:BTN_HEIGHT] toRightOf:retryBtn offset:10] centerYParent:0] install];
    

    [sl push:checkPanel height:BTN_HEIGHT marginBottom:107];
    
    UILabel *sayText = [UILabel new];
    sayText.text = localStr(@"TryAgain");
    sayText.font = [Fonts medium:18];
    sayText.textColor = UIColor.whiteColor;
    sayText.backgroundColor = UIColor.clearColor;
    [self.view addSubview:sayText];
    
    [sl push:sayText height:30 marginBottom:19];
    
    UILabel *tisihText = [UILabel new];
    tisihText.numberOfLines = 0;
    tisihText.text = localStr(@"SeemsLike");
    tisihText.font = [Fonts medium:18];
    tisihText.textColor = UIColor.whiteColor;
    tisihText.backgroundColor = UIColor.clearColor;
    [self.view addSubview:tisihText];

    
    [sl push:tisihText height:60 marginBottom:2];

    
    [sl install];
    
    [backView onClick:self action:@selector(clickGoBack:)];
    
    [retryBtn onClick:self action:@selector(retryBtnClick:)];
    [needBtn onClick:self action:@selector(helpBtnClick:)];
    // Do any additional setup after loading the view.
}

- (void)clickGoBack:(id)sender {
    [self dismiss];
}

- (void)retryBtnClick:(id)sender {
    NSLog(@"retry!");
}

- (void)helpBtnClick:(id)sender {
    
    NoticeViewController *notice = [NoticeViewController new];
    [self openPage:notice];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
