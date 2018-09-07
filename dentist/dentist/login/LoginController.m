//
// Created by entaoyang@163.com on 2018/8/15.
// Copyright (c) 2018 nextmedia.com. All rights reserved.
//

#import "LoginController.h"
#import <LocalAuthentication/LAContext.h>
#import "ForgotViewController.h"
#import "StudentController.h"
#import "Proto.h"
#import "Async.h"
#import "AppDelegate.h"
#import "RegController.h"

@interface LoginController ()

@end

@implementation LoginController {
	UITextField *emailEdit;
	UITextField *pwdEdit;
	UIButton *checkButton;
	UIButton *loginButton;

	UILabel *touchLabel;
	LAContext *context;
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
	backView.imageName = @"back_arrow";
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
	lb.font = [Fonts heavy:37];
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


	touchLabel = self.view.addLabel;
	touchLabel.text = localStr(@"enable_touch");
	[touchLabel textColorWhite];
	touchLabel.font = [Fonts medium:15];
	[[[[[touchLabel layoutMaker] sizeFit] toRightOf:checkButton offset:8] centerYOf:checkButton offset:0] install];


	UILabel *forgotLabel = self.view.addLabel;
	[forgotLabel textAlignRight];
	forgotLabel.text = localStr(@"forgot");
	[forgotLabel textColorWhite];
	forgotLabel.font = [Fonts semiBold:12];

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
	regLabel.font = [Fonts medium:15];
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

	[emailEdit returnNext];
	[pwdEdit returnDone];

	[emailEdit keyboardEmail];
	[pwdEdit keyboardDefault];

	NSString *account = getLastAccount();
	if (account != nil) {
		emailEdit.text = account;
	}


	context = [[LAContext alloc] init];
	if ([self isSupportBiometrics]) {
		if (@available(iOS 11.0, *)) {
			switch (context.biometryType) {
				case LABiometryNone:
					checkButton.selected = NO;
					checkButton.enabled = NO;
					break;
				case LABiometryTypeTouchID:
					touchLabel.text = localStr(@"enable_touch");
					break;
				case LABiometryTypeFaceID:
					touchLabel.text = localStr(@"enable_face");
					break;
				default:
					break;
			}
		}
	} else {
		checkButton.selected = NO;
		checkButton.enabled = NO;
	}
}


- (void)textFieldDidEndEditing:(UITextField *)textField {
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

	StudentController *c = [StudentController new];
	[self presentViewController:c animated:YES completion:nil];

}


- (void)clickLogin:(id)sender {
	NSLog(@"clickLogin");
	NSString *email = [emailEdit.text trimed];
	__block NSString *pwd = [pwdEdit.text trimed];
	if (pwd.length > 0) {
		[self login:email password:pwd];
		return;
	}
	if (!checkButton.isSelected || checkButton.hidden) {
		return;
	}
	NSError *error;
	BOOL success;
	success = [context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error];
	if (!success) {
		NSString *msg = @"TouchID may not support";
		[self alertOK:nil msg:msg okText:nil onOK:nil];
		checkButton.selected = NO;
		return;
	}

	[context evaluatePolicy:LAPolicyDeviceOwnerAuthentication localizedReason:localStr(@"authenticateHint") reply:
			^(BOOL success, NSError *authenticationError) {
				if (success) {
					foreTask(^() {
						pwd = keychainGetPwd(email);
						if (pwd != nil) {
							[self login:email password:pwd];
						}
					});

				}
			}
	];

}

- (void)clickLinkedin:(id)sender {
	NSLog(@"clickLinkedin ");
//    NoIntenetViewController *intenet = [NoIntenetViewController new];
//    intenet.modalPresentationStyle = UIModalPresentationOverCurrentContext;
//    intenet.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//    intenet.providesPresentationContextTransitionStyle = YES;
//    intenet.definesPresentationContext = YES;
//    [self openPage:intenet];

	[self Den_showAlertWithTitle:localStr(@"permission") message:localStr(@"WouldYou") appearanceProcess:^(DenAlertController *_Nonnull alertMaker) {
		alertMaker.
				addActionCancelTitle(@"Dont't Allow").
				addActionDefaultTitle(@"OK");
	}               actionsBlock:^(NSInteger buttonIndex, UIAlertAction *_Nonnull action, DenAlertController *_Nonnull alertSelf) {
		if ([action.title isEqualToString:@"Dont't Allow"]) {
			NSLog(@"Dont't Allow");
		} else if ([action.title isEqualToString:@"OK"]) {
			NSLog(@"OK");

			//request the linkedin
			LinkedInHelper *linkedIn = [LinkedInHelper sharedInstance];

			// If user has already connected via linkedin in and access token is still valid then
			// No need to fetch authorizationCode and then accessToken again!
			if (linkedIn.isValidToken) {

				linkedIn.customSubPermissions = [NSString stringWithFormat:@"%@,%@", first_name, last_name];

				// So Fetch member info by elderyly access token
				[linkedIn autoFetchUserInfoWithSuccess:^(NSDictionary *userInfo) {
					// get the access_token
					NSString *token = userInfo[@"access_token"];
					//send the token to the server
					HttpResult *result = [Proto sendLinkedInInfo:token];
					NSLog(@"%@", result);
					if ([result.jsonBody[@"msg"] isEqualToString:@"password is null"]) {//go to the register page
						RegController *reg = [RegController new];
						reg.student = NO;
						reg.nameStr = result.resultMap[@"full_name"];
						reg.emailStr = result.resultMap[@"username"];
						[self openPage:reg];
					}

				}                         failUserInfo:^(NSError *error) {
					NSLog(@"error : %@", error.userInfo.description);
				}];
			} else {

				linkedIn.cancelButtonText = @"Close";// Or any other language But Default is Close

				NSArray *permissions = @[@(BasicProfile),
						@(EmailAddress),
						@(Share),
						@(CompanyAdmin)];

				linkedIn.showActivityIndicator = YES;
				[linkedIn requestMeWithSenderViewController:self
				                                   clientId:@"81nb85ffrekjgr"
				                               clientSecret:@"K0pwDPX4ptU1Qodg"
				                                redirectUrl:@"https://com.appcoda.linkedin.oauth/oauth"
				                                permissions:permissions
				                                      state:@""
				                            successUserInfo:^(NSDictionary *userInfo) {

					                            // get the access_token
					                            NSString *token = userInfo[@"access_token"];
					                            //send the token to the server
					                            HttpResult *result = [Proto sendLinkedInInfo:token];

					                            if ([result.jsonBody[@"msg"] isEqualToString:@"password is null"]) {//go to the register page
						                            RegController *reg = [RegController new];
						                            reg.student = NO;
						                            reg.nameStr = result.resultMap[@"full_name"];
						                            reg.emailStr = result.resultMap[@"username"];
						                            [self openPage:reg];
					                            }

				                            } cancelBlock:^{
							NSLog(@"User cancelled the request Action");

						}                 failUserInfoBlock:^(NSError *error) {
							NSLog(@"error : %@", error.userInfo.description);

						}
				];
			}
		}
	}];

}

- (void)clickForgot:(id)sender {
	NSLog(@"clickForgot");
	ForgotViewController *forgot = [ForgotViewController new];
	[self openPage:forgot];
}


- (BOOL)isSupportBiometrics {
	NSError *error;
	return [context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error];
}


- (void)login:(NSString *)userName password:(NSString *)pwd {

	backTask(^() {
		HttpResult *r = [Proto login:userName pwd:pwd];
		if (Proto.isLogined) {
			foreTask(^() {
				[AppDelegate.instance switchToMainPage];
			});
		}
	});

}

@end
