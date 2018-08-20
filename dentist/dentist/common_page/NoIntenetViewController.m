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

@interface NoIntenetViewController ()

@end

@implementation NoIntenetViewController

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
    tisihText.text = localStr(@"Seems like you are currently not connected to the internet.");
    tisihText.font = [Fonts medium:18];
    tisihText.textColor = UIColor.whiteColor;
    tisihText.backgroundColor = UIColor.clearColor;
    [self.view addSubview:tisihText];
    
    
    UILabel *sayText = [UILabel new];
    sayText.text = localStr(@"Try again when you get online.");
    sayText.font = [Fonts medium:18];
    sayText.textColor = UIColor.whiteColor;
    sayText.backgroundColor = UIColor.clearColor;
    [self.view addSubview:sayText];
    
    UIButton *retryButton = [UIButton new];
    [retryButton title:localStr(@"Retry")];
    retryButton.stylePrimary;
    [self.view addSubview:retryButton];
    
    
    UIButton *helpButton = [UIButton new];
    [helpButton title:localStr(@"Need help?")];
    helpButton.styleWhite;
    [self.view addSubview:helpButton];

    StackLayout *sl = [StackLayout new];
    [sl push:retryButton height:BTN_HEIGHT marginBottom:65];
    [sl push:helpButton height:BTN_HEIGHT marginBottom:8];
    [sl push:sayText height:30 marginBottom:12];
    [sl push:tisihText height:60 marginBottom:2];

    [sl install];
    
    [backView onClick:self action:@selector(clickGoBack:)];
    // Do any additional setup after loading the view.
}

- (void)clickGoBack:(id)sender {
    [self dismiss];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
