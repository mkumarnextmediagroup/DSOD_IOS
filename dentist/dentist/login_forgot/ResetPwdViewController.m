//
//  ResetPwdViewController.m
//  dentist
//
//  Created by Jacksun on 2018/8/22.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "ResetPwdViewController.h"

@interface ResetPwdViewController ()

@end

@implementation ResetPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *backImg = [UIImage imageNamed:@"close.png"];
    [self setTopTitle:localStr(@"resetPwd") imageName:backImg];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *logoView = self.view.addImageView;
    logoView.imageName = @"logo";
    [logoView layoutCenterXOffsetTop:260 height:54 offset:104];
    
    StackLayout *sl = [StackLayout new];
    
//    UIButton *regButton = [UIButton new];
//    [regButton title:localStr(@"reg")];
//    [regButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [sl push:regButton height:BTN_HEIGHT marginBottom:10];
    
    UILabel *reqLabel = [UILabel new];
    reqLabel.text = localStr(@"pwd_req");
    reqLabel.font = [Fonts light:12];
    [reqLabel textColorWhite];
    UIImageView *infoImgView = reqLabel.addImageView;
    infoImgView.imageName = @"info";
    [infoImgView scaleFill];
    [[[[[infoImgView layoutMaker] sizeEq:15 h:15] leftParent:0] centerYParent:0] install];
    [sl push:reqLabel height:[reqLabel heightThatFit] marginBottom:22];
    
    UITextField *pwdEdit = self.view.addEdit;
    pwdEdit.delegate = self;
    pwdEdit.hint = localStr(@"conpwd");
    [pwdEdit returnNext];
    [pwdEdit returnDone];
    [pwdEdit keyboardDefault];
    [sl push:pwdEdit height:36 marginBottom:10];
    
    UITextField *emailEdit = self.view.addEdit;
    emailEdit.delegate = self;
    emailEdit.hint = localStr(@"newpwd");
    [emailEdit returnNext];
    [emailEdit keyboardEmail];
    [sl push:emailEdit height:36 marginBottom:10];
    
    UITextField *nameEdit = self.view.addEdit;
    nameEdit.delegate = self;
    nameEdit.hint = localStr(@"temppwd");
    [nameEdit returnNext];
    [nameEdit keyboardDefault];
    [sl push:nameEdit height:36 marginBottom:10];
    
    UILabel *lbReg = self.view.addLabel;
    lbReg.text = localStr(@"hereyou");
    lbReg.font = [Fonts regular:17];
    lbReg.numberOfLines = 0;
    lbReg.textColor = [UIColor blackColor];
//    CGSize sz = [lbReg sizeThatFits:CGSizeZero];
    [sl push:lbReg height:45 marginBottom:20];
    
    
    [sl install];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
