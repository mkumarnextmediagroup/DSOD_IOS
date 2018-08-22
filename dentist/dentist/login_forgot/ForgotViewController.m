//
//  ForgotViewController.m
//  dentist
//
//  Created by Jacksun on 2018/8/19.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "ForgotViewController.h"
#import "Common.h"
#import "StackLayout.h"
#import "UIView+customed.h"
#import "UILabel+customed.h"
#import "UIControl+customed.h"

@interface ForgotViewController ()

@end

@implementation ForgotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *logoView = self.view.addImageView;
    logoView.imageName = @"logo";
    [logoView layoutCenterXOffsetTop:260 height:54 offset:54];
    
    UIImageView *backView = self.view.addImageView;
    backView.imageName = @"back.png";
    [backView scaleFit];
    [backView makeLayout:^(MASConstraintMaker *m) {
        m.width.mas_equalTo(23);
        m.height.mas_equalTo(23);
        m.left.mas_equalTo(self.view.mas_left).offset(16);
        m.top.mas_equalTo(self.view.mas_top).offset(50);
    }];
    
    UILabel *panic = [UILabel new];
    panic.text = localStr(@"Don't panic");
    panic.font = [Fonts medium:38];
    panic.textColor = UIColor.blackColor;
    panic.backgroundColor = UIColor.clearColor;
    [self.view addSubview:panic];
    
    UILabel *textLab = [UILabel new];
    textLab.numberOfLines = 0 ;
    textLab.text = localStr(@"just");
    textLab.font = [Fonts medium:17];
    textLab.textColor = UIColor.blackColor;
    textLab.backgroundColor = UIColor.clearColor;
    [self.view addSubview:textLab];
    
    UITextField *emailEdit = self.view.addEdit;
    emailEdit.delegate = self;
    emailEdit.hint = localStr(@"email_address");
    [emailEdit layoutFillXOffsetBottom:EDIT_HEIGHT offset:125];

    UIButton *sendButton = [UIButton new];
    [sendButton title:localStr(@"send")];
    sendButton.stylePrimary;
    [self.view addSubview:sendButton];
    
    NSString * aStr = @"Nevermind,Take me back";
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",aStr]];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0,10)];
    
    UIButton * backBtn = [UIButton new];
    [backBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [backBtn setTitleColor:rgb255(155, 155, 155) forState:UIControlStateNormal];
    [backBtn setAttributedTitle:str forState:UIControlStateNormal];
    [self.view addSubview:backBtn];
    
    StackLayout *sl = [StackLayout new];
    [sl push:backBtn height:BTN_HEIGHT marginBottom:30];
    [sl push:sendButton height:BTN_HEIGHT marginBottom:8];
    [sl push:emailEdit height:EDIT_HEIGHT marginBottom:14];
    [sl push:textLab height:60 marginBottom:12];
    [sl push:panic height:36 marginBottom:2];
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
