//
// Created by entaoyang@163.com on 2018/8/15.
// Copyright (c) 2018 nextmedia.com. All rights reserved.
//

#import "RegController.h"
#import "LoginController.h"
#import "NSString+myextend.h"
#import <LocalAuthentication/LAContext.h>
#import <LocalAuthentication/LAError.h>
#import "SAMKeychain.h"


@interface RegController ()

@end

@implementation RegController {
	UITextField *nameEdit;
	UITextField *emailEdit;
	UITextField *pwdEdit;
	UIButton *checkButton;
	UIButton *regButton;
	UILabel *touchLabel;

	LAContext *context;
	NSString *alertTitle;
	NSString *alertHint;
}

- (id)init {
	self = [super init];
	self.student = false;
	return self;
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
	[[[[backView.layoutMaker sizeEq:23 h:23] leftParent:16] topParent:30] install];


	//arrange controls from bottom to top
	StackLayout *sl = [StackLayout new];

	UIView *loginPanel = self.view.addView;
	loginPanel.backgroundColor = UIColor.clearColor;
	UILabel *alreadyLabel = loginPanel.addLabel;
	alreadyLabel.text = localStr(@"already_user");
	alreadyLabel.font = [Fonts regular:15];
	[alreadyLabel textColorWhite];
	[alreadyLabel textAlignRight];
	[[[[[alreadyLabel layoutMaker] sizeFit] centerXParent:-30] centerYParent:0] install];
	UILabel *loginLabel = loginPanel.addLabel;
	loginLabel.text = localStr(@"login");
	loginLabel.font = [Fonts semiBold:15];
	[loginLabel textColorWhite];
	[loginLabel underLineSingle];
	[[[[[loginLabel layoutMaker] sizeFit] toRightOf:alreadyLabel offset:4] centerYParent:0] install];

	[sl push:loginPanel height:20 marginBottom:33];

	if (!self.student) {
		UIButton *linkedinButton = self.view.addButton;
		[linkedinButton title:localStr(@"reg_linkedin")];
		[linkedinButton styleBlue];
		UIImageView *inView = linkedinButton.addImageView;
		inView.imageName = @"in";
		[inView scaleFit];
		[[[[inView.layoutMaker sizeEq:20 h:20] leftParent:10] centerYParent:0] install];
		UIView *lineView = linkedinButton.addView;
		lineView.backgroundColor = rgb255(0x2F, 0x9c, 0xD5);
		[sl push:linkedinButton height:BTN_HEIGHT marginBottom:22];

		[linkedinButton onClick:self action:@selector(clickLinkedin:)];
	}

	regButton = self.view.addButton;
	[regButton title:localStr(@"reg")];
	[regButton styleWhite];
	regButton.enabled = NO;
	[sl push:regButton height:BTN_HEIGHT marginBottom:10];


	UIView *termPanel = self.view.addView;
	[sl push:termPanel height:18 marginBottom:25];

	UILabel *andLabel = termPanel.addLabel;
	andLabel.font = [Fonts regular:12];
	andLabel.text = localStr(@"and");
	[[[[[andLabel layoutMaker] sizeFit] centerXParent:8] topParent:0] install];

	UILabel *termLabel = termPanel.addLabel;
	termLabel.font = [Fonts regular:12];
	termLabel.text = localStr(@"terms");
	[termLabel underLineSingle];
	[[[[[termLabel layoutMaker] sizeFit] topParent:0] toLeftOf:andLabel offset:0] install];
	[termLabel onClickView:self action:@selector(clickTerms:)];

	UILabel *policyLabel = termPanel.addLabel;
	policyLabel.font = [Fonts regular:12];
	policyLabel.text = localStr(@"policy");
	[policyLabel underLineSingle];
	[[[[[policyLabel layoutMaker] sizeFit] topParent:0] toRightOf:andLabel offset:0] install];
	[policyLabel onClickView:self action:@selector(clickPolicy:)];

	UILabel *dotLabel = termPanel.addLabel;
	dotLabel.font = [Fonts regular:12];
	dotLabel.text = @".";
	[[[[[dotLabel layoutMaker] sizeFit] topParent:0] toRightOf:policyLabel offset:0] install];


	UILabel *agreeLabel = self.view.addLabel;
	agreeLabel.font = [Fonts regular:12];
	agreeLabel.numberOfLines = 2;
	[agreeLabel textAlignCenter];
	agreeLabel.text = localStr(@"agree");
	[sl push:agreeLabel height:agreeLabel.heightThatFit marginBottom:0];


	UIView *checkPanel = self.view.addView;
	checkButton = checkPanel.addCheckbox;
	checkButton.selected = YES;
	[[[[[checkButton layoutMaker] sizeEq:24 h:24] leftParent:0] centerYParent:0] install];
	touchLabel = checkPanel.addLabel;
	touchLabel.text = localStr(@"enable_touch");
	[touchLabel textColorWhite];
	touchLabel.font = [Fonts medium:15];
	[[[[[touchLabel layoutMaker] sizeFit] toRightOf:checkButton offset:10] centerYParent:0] install];

	context = [[LAContext alloc] init];
	BOOL isCanEvaluatePolicy = [self isSupportBiometrics];
	if (isCanEvaluatePolicy) {
		// 判断设备支持TouchID还是FaceID
		if (@available(iOS 11.0, *)) {
			switch (context.biometryType) {
				case LABiometryNone:
					[self justSupportBiometricsType:0];
					break;
				case LABiometryTypeTouchID:
					[self justSupportBiometricsType:1];
					break;
				case LABiometryTypeFaceID:
					[self justSupportBiometricsType:2];
					break;
				default:
					break;
			}
		} else {
			// Fallback on earlier versions
			NSLog(@"iOS 11之前不需要判断 biometryType");
			// 因为iPhoneX起始系统版本都已经是iOS11.0，所以iOS11.0系统版本下不需要再去判断是否支持faceID，直接走支持TouchID逻辑即可。
			[self justSupportBiometricsType:1];
		}

	} else {
		[self justSupportBiometricsType:0];
	}


	[sl push:checkPanel height:30 marginBottom:20];

	UILabel *reqLabel = self.view.addLabel;
	reqLabel.text = localStr(@"pwd_req");
	reqLabel.font = [Fonts regular:12];
	[reqLabel wordSpace:-0.2f];
	[reqLabel textColorWhite];
	UIImageView *infoImgView = reqLabel.addImageView;
	infoImgView.imageName = @"info";
	[infoImgView scaleFill];
	[[[[[infoImgView layoutMaker] sizeEq:15 h:15] leftParent:0] centerYParent:0] install];
	[sl push:reqLabel height:[reqLabel heightThatFit] marginBottom:22];


	pwdEdit = self.view.addEdit;
	pwdEdit.delegate = self;
	pwdEdit.hint = localStr(@"pwd");
	[pwdEdit stylePassword];
	[pwdEdit returnDone];
	[pwdEdit keyboardDefault];
	[sl push:pwdEdit height:36 marginBottom:10];

	emailEdit = self.view.addEdit;
	emailEdit.delegate = self;
	emailEdit.hint = localStr(@"email_address");
	[emailEdit returnNext];
	[emailEdit keyboardEmail];
	[sl push:emailEdit height:36 marginBottom:10];

	nameEdit = self.view.addEdit;
	nameEdit.delegate = self;
	nameEdit.hint = localStr(@"full_name");
	[nameEdit returnNext];
	[nameEdit keyboardDefault];
	[sl push:nameEdit height:36 marginBottom:10];


	UILabel *lbReg = self.view.addLabel;
	lbReg.text = localStr(@"reg");
	lbReg.font = [Fonts heavy:37];
	[lbReg textColorWhite];
	CGSize sz = [lbReg sizeThatFits:CGSizeZero];
	[sl push:lbReg height:sz.height marginBottom:20];


	[sl install];


	[backView onClick:self action:@selector(clickGoBack:)];
	[regButton onClick:self action:@selector(clickReg:)];
	[loginLabel onClickView:self action:@selector(clickLogin:)];

}


- (void)onTextFieldDone:(UITextField *)textField {

	BOOL err = NO;
	if ([nameEdit.text trimed].length < 1) {
		[nameEdit themeError];
		err = YES;
	} else {
		[nameEdit themeNormal];
	}
	if ([emailEdit.text trimed].length < 5 || !emailEdit.text.matchEmail) {
		[emailEdit themeError];
		err = YES;
	} else {
		[emailEdit themeNormal];
	}
	if (!pwdEdit.text.matchPassword) {
		[pwdEdit themeError];
		err = YES;
	} else {
		[pwdEdit themeNormal];
	}
	regButton.enabled = !err;
}


- (void)clickGoBack:(id)sender {
	[self dismiss];
}

- (void)clickTerms:(id)sender {
	NSLog(@"clickTerms");
}

- (void)clickPolicy:(id)sender {
	NSLog(@"clickTerms");
}

- (void)clickReg:(id)sender {
	NSLog(@"clickLogin");
	//TODO 成功后，保存用户账号
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	[userDefaults setObject:([emailEdit.text trimed]) forKey:(@"lastAccessUser")];
	[userDefaults synchronize];

	//TODO 成功后，保存到钥匙串
	[SAMKeychain setPassword:[pwdEdit.text trimed] forService:@"lastAccessUser" account:[emailEdit.text trimed]];

	if (checkButton.isSelected) {

		UIAlertController *alert = [UIAlertController alertControllerWithTitle:alertTitle message:alertHint preferredStyle:UIAlertControllerStyleAlert];

		UIAlertAction *okButton = [UIAlertAction actionWithTitle:localStr(@"ok") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
			// Do something after clicking OK button
			LAContext *context = [[LAContext alloc] init];
			NSError *error;
			BOOL success;

			// test if we can evaluate the policy, this test will tell us if Touch ID is available and enrolled
			success = [context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error];

			if (success) {
				NSLog(@"支持");
				[self evaluatePolicy];
			} else {
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


		}];
		UIAlertAction *cancelButton = [UIAlertAction actionWithTitle:localStr(@"notallow") style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
			// Do something after clicking Cancel button
		}];
		[alert addAction:okButton];
		[alert addAction:cancelButton];
		[self presentViewController:alert animated:YES completion:nil];


	} else {
		//模拟注册成功
		[self dismiss];
		if (self.registSuccessBlock) {
			self.registSuccessBlock();
		}
	}
}

- (BOOL)isSupportBiometrics {

	NSError *error;
	BOOL success;
	// test if we can evaluate the policy, this test will tell us if Touch ID is available and enrolled
	success = [context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error];
	return success;

}

// 判断生物识别类型，更新UI
- (void)justSupportBiometricsType:(NSInteger)biometryType {
	switch (biometryType) {
		case 0://需求方说没有这种情况
			NSLog(@"该设备支持不支持FaceID和TouchID");
			break;
		case 1://该设备支持TouchID
			NSLog(@"该设备支持TouchID");
			touchLabel.text = localStr(@"enable_touch");
			alertTitle = localStr(@"useTouchIDTitle");
			alertHint = localStr(@"useTouchIDHint");

			break;
		case 2://该设备支持FaceID
			NSLog(@"该设备支持Face ID");
			touchLabel.text = localStr(@"enable_face");
			alertTitle = localStr(@"useFaceIDTitle");
			alertHint = localStr(@"useFaceIDHint");

			break;
		default:
			break;
	}
}


- (void)evaluatePolicy {

	__block NSString *msg;

	// show the authentication UI with our reason string
	__weak __typeof(self) weakSelf = self;
	[context evaluatePolicy:LAPolicyDeviceOwnerAuthentication localizedReason:localStr(@"authenticateHint") reply:
			^(BOOL success, NSError *authenticationError) {
				if (success) {
					[[NSOperationQueue mainQueue] addOperationWithBlock:^{
						//TODO 此处模拟通过验证后注册成功，关掉当前页面
						[weakSelf dismiss];
						if (self.registSuccessBlock) {
							self.registSuccessBlock();
						}

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
							// 由于不可抗拒力，应用进入后台（其实很简单，你写两个测试demo，在一个启动指纹时开启另一个项目，你的指纹项目就会因为不可抗力进入后台，这时候就会走到这）
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

- (void)clickLinkedin:(id)sender {
	NSLog(@"clickLinkedin ");
}

- (void)clickLogin:(id)sender {
	LoginController *c = [LoginController new];
	[self openPage:c];
}
@end
