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
    [backView makeLayout:^(MASConstraintMaker *m) {
        m.width.mas_equalTo(23);
        m.height.mas_equalTo(23);
        m.right.mas_equalTo(self.view.mas_right).offset(-26);
        m.top.mas_equalTo(self.view.mas_top).offset(40);
    }];
    
    UILabel *tisihText = [UILabel new];
    tisihText.numberOfLines = 0;
    tisihText.text = localStr(@"SeemsLike");
    tisihText.font = [Fonts medium:18];
    tisihText.textColor = UIColor.whiteColor;
    tisihText.backgroundColor = UIColor.clearColor;
    [self.view addSubview:tisihText];
    
    
    UILabel *sayText = [UILabel new];
    sayText.text = localStr(@"TryAgain");
    sayText.font = [Fonts medium:18];
    sayText.textColor = UIColor.whiteColor;
    sayText.backgroundColor = UIColor.clearColor;
    [self.view addSubview:sayText];
    
//    UIView *loginPanel = self.view.addView;
//    loginPanel.backgroundColor = UIColor.clearColor;
//    UIButton *needBtn = loginPanel.needHelpBtn;
//    [[[[[needBtn layoutMaker] sizeFit] centerXParent:-30] centerYParent:0] install];
//
//    UIButton *retryBtn = loginPanel.retryBtn;
//    [[[[[retryBtn layoutMaker] sizeFit] toRightOf:needBtn offset:4] centerYParent:0] install];
    
    UIButton *retryBtn = [UIButton new];
    [retryBtn title:localStr(@"Retry")];
    [retryBtn stylePrimary];
    [self.view addSubview:retryBtn];

    UIButton *needBtn = [UIButton new];
    [needBtn title:localStr(@"Need help?")];
    [needBtn styleWhite];
    [self.view addSubview:needBtn];

    StackLayout *sl = [StackLayout new];
//    [sl push:needBtn height:BTN_HEIGHT marginBottom:65];
//    [sl push:retryBtn height:BTN_HEIGHT marginBottom:8];
//    [sl push:loginPanel height:BTN_HEIGHT marginBottom:40];
    [sl push:sayText height:30 marginBottom:12];
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
