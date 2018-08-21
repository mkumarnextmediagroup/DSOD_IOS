//
// Created by entaoyang@163.com on 2018/8/15.
// Copyright (c) 2018 nextmedia.com. All rights reserved.
//

#import "LoginController.h"
#import "Common.h"
#import "NSString+myextend.h"
#import <LocalAuthentication/LAContext.h>
#import <LocalAuthentication/LAError.h>
#import "SAMKeychain.h"
#import "NoIntenetViewController.h"
#import "ForgotViewController.h"

@interface LoginController ()

@end

@implementation LoginController {
	UITextField *emailEdit;
	UITextField *pwdEdit;
	UIButton *checkButton;
	UIButton *loginButton;
}

- (void)viewDidLoad {
	[super viewDidLoad];


	UIImageView *imageView = self.view.addImageView;
	imageView.imageName = @"bg_3.png";
	[imageView layoutFill];

	UIImageView *logoView = self.view.addImageView;
	logoView.imageName = @"logo_white";
	[logoView layoutCenterXOffsetTop:260 height:54 offset:54];

	UIImageView *backView = self.view.addImageView;
	backView.imageName = @"back.png";
	[backView scaleFit];
	[backView makeLayout:^(MASConstraintMaker *m) {
		m.width.mas_equalTo(23);
		m.height.mas_equalTo(23);
		m.left.mas_equalTo(self.view.mas_left).offset(16);
		m.top.mas_equalTo(self.view.mas_top).offset(30);
	}];

	emailEdit = self.view.addEdit;
	emailEdit.delegate = self;
	emailEdit.hint = localStr(@"email_address");
	[emailEdit layoutFillXOffsetCenterY:EDIT_HEIGHT offset:-23];

	UILabel *lb = self.view.addLabel;
	lb.text = localStr(@"login");
	lb.font = [Fonts regular:37];
//	[lb wordSpace:2];
	[lb textColorWhite];
	[lb layoutFillXOffsetCenterY:46 offset:-80];


	pwdEdit = self.view.addEdit;
	pwdEdit.delegate = self;
	pwdEdit.hint = localStr(@"pwd");
	[pwdEdit stylePassword];
//	[pwdEdit themeError];
	[pwdEdit layoutFillXOffsetCenterY:EDIT_HEIGHT offset:23];

	checkButton = self.view.addCheckbox;
	checkButton.selected = YES;
	[[[[[checkButton layoutMaker] sizeEq:24 h:24] leftParent:EDGE] below:pwdEdit offset:16] install];
    


	UILabel *touchLabel = self.view.addLabel;
	touchLabel.text = localStr(@"enable_touch");
	[touchLabel textColorWhite];
	touchLabel.font = [Fonts light:15];
	[[[[[touchLabel layoutMaker] sizeFit] toRightOf:checkButton offset:8] centerYOf:checkButton offset:0] install];

	UILabel *forgotLabel = self.view.addLabel;
	[forgotLabel textAlignRight];
	forgotLabel.text = localStr(@"forgot");
	[forgotLabel textColorWhite];
	forgotLabel.font = [Fonts light:12];

	[[[[[forgotLabel layoutMaker] sizeFit] rightOf:pwdEdit] centerYOf:touchLabel offset:0] install];


	loginButton = self.view.addButton;
	[loginButton title:localStr(@"login")];
	[loginButton styleSecondary];


	UIButton *linkedinButton = self.view.addButton;
	[linkedinButton title:localStr(@"login_using_linkedin")];
	[linkedinButton styleBlue];
	UIImageView *inView = linkedinButton.addImageView;
	inView.imageName = @"in";
	[inView scaleFit];
	[[[[inView.layoutMaker sizeEq:20 h:20] leftParent:10] centerYParent:0] install];
	UIView *lineView = linkedinButton.addView;
	lineView.backgroundColor = rgb255(0x2F, 0x9c, 0xD5);
	[[[[[lineView.layoutMaker widthEq:1] topParent:0] bottomParent:0] leftParent:40] install];


	UILabel *regLabel = self.view.addLabel;
	[regLabel textAlignCenter];
	regLabel.font = [Fonts regular:14];
	regLabel.textColor = UIColor.whiteColor;
	regLabel.text = localStr(@"create_account");
	[regLabel underLineSingle];


	StackLayout *sl = [StackLayout new];
	[sl push:regLabel height:20 marginBottom:33];
	[sl push:linkedinButton height:BTN_HEIGHT marginBottom:22];
	[sl push:loginButton height:BTN_HEIGHT marginBottom:8];
	[sl install];


	[regLabel onClickView:self action:@selector(clickGoReg:)];
	[backView onClick:self action:@selector(clickGoBack:)];
	[loginButton onClick:self action:@selector(clickLogin:)];
	[linkedinButton onClick:self action:@selector(clickLinkedin:)];
	[forgotLabel onClickView:self action:@selector(clickForgot:)];
    [checkButton onClick:self action:@selector(clickUseTouchID:)];

	[emailEdit returnNext];
	[pwdEdit returnDone];

	[emailEdit keyboardEmail];
	[pwdEdit keyboardDefault];
}

- (void)onTextFieldDone:(UITextField *)textField {
	BOOL err = NO;

	if ([emailEdit.text trimed].length < 5 || !emailEdit.text.matchEmail) {
		[emailEdit themeError];
		err = YES;
	} else {
		[emailEdit themeNormal];
	}
	if ([pwdEdit.text trimed].length < 2) {
		[pwdEdit themeError];
		err = YES;
	} else {
		[pwdEdit themeNormal];
	}
	loginButton.enabled = !err;
}


- (void)clickGoBack:(id)sender {
	[self dismiss];
}

- (void)clickGoReg:(id)sender {
	NSLog(@"click reg ");
	NSLog(@"%@", sender);
}

- (void)clickLogin:(id)sender {
	NSLog(@"clickLogin");
   
    [self login:[emailEdit.text trimed] password:[pwdEdit.text trimed]];
    
}

- (void)clickLinkedin:(id)sender {
	NSLog(@"clickLinkedin ");
    NoIntenetViewController *intenet = [NoIntenetViewController new];
    intenet.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    intenet.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    intenet.providesPresentationContextTransitionStyle = YES;
    intenet.definesPresentationContext = YES;
    [self openPage:intenet];
}

- (void)clickForgot:(id)sender {
    NSLog(@"clickForgot");
    ForgotViewController *forgot = [ForgotViewController new];
    [self openPage:forgot];
}

- (void)clickUseTouchID:(id)sender {
    NSLog(@"clickUseTouchID");
    if(checkButton.isSelected){
        LAContext *context = [[LAContext alloc] init];
        NSError *error;
        BOOL success;
        
        // test if we can evaluate the policy, this test will tell us if Touch ID is available and enrolled
        success = [context canEvaluatePolicy: LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error];
        
        
        if(success){
            NSLog(@"支持");
            [self evaluatePolicy];
        }else{
            switch (error.code) {
                    // 没有设置指纹（没有设置密码也会走到这），但是支持指纹识别
                case LAErrorBiometryNotEnrolled:
                    NSLog(@"没有设置指纹");
                    break;
                    // 理论上是没有设置密码,待测试
                case LAErrorPasscodeNotSet:
                    NSLog(@"没有设置密码");
                    break;
                    // 在使用touchID的场景中,错误太多次而导致touchID被锁不可用
                case LAErrorBiometryLockout:
                    NSLog(@"被锁");
                    break;
                default:
                    NSLog(@"不支持");
                break;
                    
            }
        }
        
    }
}


- (void)evaluatePolicy
{
    LAContext *context = [[LAContext alloc] init];
    __block  NSString *msg;
    
    // show the authentication UI with our reason string
    //LAPolicyDeviceOwnerAuthentication 相对简单（正确，取消，输入密码）
    //LAPolicyDeviceOwnerAuthenticationWithBiometrics 错误码较多，但是发现点击输入密码，竟然抛出错误，而不是弹出密码框
    __weak __typeof(self) weakSelf = self;
    [context evaluatePolicy:LAPolicyDeviceOwnerAuthentication localizedReason:NSLocalizedString(@"Please authenticate to proceed", nil) reply:
     ^(BOOL success, NSError *authenticationError) {
         if (success) {
             msg =[NSString stringWithFormat:@"EVALUATE_POLICY_SUCCESS"];
             NSData *evaluatedPolicyDomainState=context.evaluatedPolicyDomainState;//可以比对他，采取其他策略；
             NSLog(@"result===%@",evaluatedPolicyDomainState);
             [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                 //其他情况，切换主线程处理
                 NSArray *accountArray = [SAMKeychain accountsForService:@"lastAccessUser"];
                 int count = accountArray.count;
                 for( int i=0; i<count; i++){
                     NSLog(@"%i-%@", i, [accountArray objectAtIndex:i]);
                 }
                 //如何获取上一次账号，上面代码打印出来不是一个简单的字符串
                 //NSString *pwd = [SAMKeychain passwordForService:@"lastAccessUser" account:<#(nonnull NSString *)#>];
                  [weakSelf login:[emailEdit.text trimed] password:[pwdEdit.text trimed]];
             }];
            
             
         } else {
             
             switch (authenticationError.code) {
                     //  指纹识别3次失败进入这里
                 case LAErrorAuthenticationFailed:
                     NSLog(@"验证失败");
                     break;
                     //   指纹识别时，点击取消
                 case LAErrorUserCancel:
                     NSLog(@"点击取消按钮");
                     break;
                     //  指纹识别时，点击输入密码按钮
                 case LAErrorUserFallback:
                     NSLog(@"点击输入密码按钮");
                     break;
                     //  没有在设备上设置密码
                 case LAErrorPasscodeNotSet:
                     NSLog(@"没有在设备上设置密码");
                     break;
                     //  设备上TouchID不可用，例如未打开
                 case LAErrorBiometryNotAvailable:
                     NSLog(@"设备不支持TouchID");
                     break;
                     //  没有设置TouchID
                 case LAErrorBiometryNotEnrolled:
                     NSLog(@"设备没有注册TouchID");
                     break;
                     // 设备TouchID被锁，且只会在iOS9以上设备出现
                 case LAErrorBiometryLockout:
                     NSLog(@"TouchID被锁");
                     break;
                     //     由于不可抗拒力，应用进入后台（其实很简单，你写两个测试demo，在一个启动指纹时开启另一个项目，你的指纹项目就会因为不可抗力进入后台，这时候就会走到这）
                 case LAErrorSystemCancel:
                     NSLog(@"由于系统阻止，转入后台");
                     break;
                 default:
                     NSLog(@"不支持");
                     break;
             }
             
             //msg = [NSString stringWithFormat:@"EVALUATE_POLICY_WITH_ERROR : %@",
                    //uthenticationError];
         }
         
     }];
    
}


- (void)login:(NSString *)userName password:(NSString *)pwd {

    NSString *msg = [NSString stringWithFormat:@"Login Success,Hi %@",
           userName];

    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:msg message:nil delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
    [alertView show];

    
}

@end
