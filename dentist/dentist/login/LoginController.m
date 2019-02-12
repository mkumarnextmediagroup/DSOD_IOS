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
#import "NoIntenetViewController.h"
#import "DentistPickerView.h"
#import "Reachability.h"

@interface LoginController ()

@end

@implementation LoginController {
	UILabel *touchLabel;
	LAContext *context;
    UILabel *serverLabel;
}

/**
 slide left to display server options
 */
-(void)lefthandleSwipeFrom:(UISwipeGestureRecognizer *)recognizer
{
    if(recognizer.direction == UISwipeGestureRecognizerDirectionLeft) {
        NSLog(@"swipe left");
        serverLabel.hidden=NO;
    }
}

- (void)viewDidLoad {
	[super viewDidLoad];


//    UIImageView *imageView = self.view.addImageView;
//    imageView.imageName = @"bg_3.png";
//    [imageView layoutFill];
    
    UISwipeGestureRecognizer *leftrecognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(lefthandleSwipeFrom:)];
    [leftrecognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [self.view addGestureRecognizer:leftrecognizer];
    
    UITapGestureRecognizer *keywordtap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keywordtapCLick)];
    [self.view addGestureRecognizer:keywordtap];
    
    

	UIImage *image = [UIImage imageNamed:@"bg_3.png"];
	UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
	[self.view addSubview:imageView];
	[imageView layoutFill];


	UIImageView *logoView = self.view.addImageView;
	logoView.imageName = @"logo";
	[logoView layoutCenterXOffsetTop:260 height:54 offset:54 + NAVHEIGHT_OFFSET];

	UIImageView *backView = self.view.addImageView;
	backView.imageName = @"back_arrow";
	[backView scaleFit];
	[backView makeLayout:^(MASConstraintMaker *m) {
		m.width.mas_equalTo(23);
		m.height.mas_equalTo(23);
		m.left.mas_equalTo(self.view.mas_left).offset(16);
		m.top.mas_equalTo(self.view.mas_top).offset(30 + NAVHEIGHT_OFFSET);
	}];
    
    serverLabel = self.view.addLabel;
    serverLabel.textAlignment=NSTextAlignmentRight;
    if(getServerDomain()==1){
         serverLabel.text=@"Amercia";
    }else{
         serverLabel.text=@"China";
    }
   
    serverLabel.textColor=[UIColor whiteColor];
    serverLabel.userInteractionEnabled=YES;
    [serverLabel makeLayout:^(MASConstraintMaker *m) {
        m.height.mas_equalTo(30);
        m.left.mas_equalTo(backView.mas_left).offset(16);
        m.top.mas_equalTo(self.view.mas_top).offset(30 + NAVHEIGHT_OFFSET);
        m.right.mas_equalTo(self.view.mas_right).offset(-20);
    }];
    serverLabel.hidden=YES;
    UITapGestureRecognizer *serverrecognizer=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showServerView:)];
    [serverLabel addGestureRecognizer:serverrecognizer];

	StackLayout *sl = [StackLayout new];

    _emailEdit = self.view.addEditRounded;
	_emailEdit.delegate = self;
	if (self.student) {
		_emailEdit.hint = localStr(@"schemail");
	} else {
		_emailEdit.hint = localStr(@"email_address");
	}
	[_emailEdit layoutFillXOffsetCenterY:EDIT_HEIGHT offset:-23];

	UILabel *lb = self.view.addLabel;
	lb.text = localStr(@"login");
	lb.font = [Fonts heavy:37];
//	[lb wordSpace:2];
	[lb textColorWhite];
	[lb layoutFillXOffsetCenterY:46 offset:-80];


	_pwdEdit = self.view.addEditPwd;
	_pwdEdit.delegate = self;
	_pwdEdit.hint = localStr(@"pwd");
//	[pwdEdit themeError];
	[_pwdEdit layoutFillXOffsetCenterY:EDIT_HEIGHT offset:23];

	_checkButton = self.view.addCheckbox;
	_checkButton.selected = YES;
	[[[[[_checkButton layoutMaker] sizeEq:24 h:24] leftParent:EDGE] below:_pwdEdit offset:16] install];
	[_checkButton onClick:self action:@selector(clickCheckBox:)];


	touchLabel = self.view.addLabel;
	touchLabel.text = localStr(@"enable_touch");
	[touchLabel textColorWhite];
	touchLabel.font = [Fonts medium:15];
	[[[[[touchLabel layoutMaker] sizeFit] toRightOf:_checkButton offset:8] centerYOf:_checkButton offset:0] install];


	UILabel *forgotLabel = self.view.addLabel;
	[forgotLabel textAlignRight];
	forgotLabel.text = localStr(@"forgot");
	[forgotLabel textColorWhite];
	forgotLabel.font = [Fonts semiBold:12];

	[[[[[forgotLabel layoutMaker] sizeFit] rightOf:_pwdEdit] centerYOf:touchLabel offset:0] install];


	_loginButton = self.view.addButton;
	[_loginButton styleWhite];
	[_loginButton title:localStr(@"login")];
	[_loginButton styleSecondary];
    

	UILabel *regLabel = self.view.addLabel;
	[regLabel textAlignCenter];
	regLabel.font = [Fonts medium:15];
	regLabel.textColor = UIColor.whiteColor;
	regLabel.text = localStr(@"create_account");
	[regLabel underLineSingle];

	[sl push:regLabel height:20 marginBottom:33 + TABLEBAR_SAFE_BOTTOM_MARGIN];

	if (!self.student) {
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
		[linkedinButton onClick:self action:@selector(clickLinkedin:)];

		[sl push:linkedinButton height:BTN_HEIGHT marginBottom:22];

	}
	[sl push:_loginButton height:BTN_HEIGHT marginBottom:8];
	[sl install];


	[regLabel onClickView:self action:@selector(clickGoReg:)];
	[backView onClick:self action:@selector(clickGoBack:)];
	[_loginButton onClick:self action:@selector(clickLogin:)];
	[forgotLabel onClickView:self action:@selector(clickForgot:)];

	[_emailEdit returnNext];
	[_pwdEdit returnDone];

	[_emailEdit keyboardEmail];
	[_pwdEdit keyboardDefault];

	NSString *account = getLastAccount();
	if (account != nil && getLoginType()==0) {
		_emailEdit.text = account;
	}

	context = [[LAContext alloc] init];
	if ([self isSupportBiometrics]) {
		if (@available(iOS 11.0, *)) {
			switch (context.biometryType) {
				case LABiometryNone:
					_checkButton.selected = NO;
					_checkButton.enabled = NO;
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
		_checkButton.selected = NO;
		_checkButton.enabled = NO;
	}
}

#pragma mark -----UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField {
	BOOL err = NO;

	if ([_emailEdit.text trimed].length < 5 || !_emailEdit.text.matchEmail) {
		[_emailEdit themeError];
		err = YES;
	} else {
		[_emailEdit themeNormal];
	}
	if ([_pwdEdit.text trimed].length < 2) {
		[_pwdEdit themeError];
		err = YES;
	} else {
		[_pwdEdit themeNormal];
	}

	BOOL flag = [self shouldEableloginBtn];
	_loginButton.enabled = flag;

//    loginButton.enabled = !err;
}

/**
 back event
 */
- (void)clickGoBack:(id)sender {
	[self dismiss];
}

/**
 go to the registration page from student
 */
- (void)clickGoReg:(id)sender {

	StudentController *c = [StudentController new];
	[self presentViewController:c animated:YES completion:nil];

}

/**
 click the CheckBox to check the username and password are legal
 */
- (void)clickCheckBox:(id)sender {

	BOOL flag = [self shouldEableloginBtn];
	_loginButton.enabled = flag;
}

/**
 check the username and password are legal
*/
- (BOOL)shouldEableloginBtn {

	NSString *email = [_emailEdit.text trimed];
	NSString *pwd = keychainGetPwd(email);
	if (email.matchEmail && [_pwdEdit.text trimed].length > 2) {
		return YES;
	}
	if (_checkButton.isSelected) {
		if (email.matchEmail && pwd != nil) {
			return YES;
		}
	}

	return NO;

}



/**
 click the linkedin event
 */
- (void)clickLogin:(id)sender {
	NSLog(@"clickLogin");
	NSString *email = [_emailEdit.text trimed];
	__block NSString *pwd = [_pwdEdit.text trimed];
	if (pwd.length > 0) {
		[self login:email password:pwd];
		return;
	}
	if (!_checkButton.isSelected || _checkButton.hidden) {
		return;
	}
	NSError *error;
	BOOL success;
	success = [context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error];
	if (!success) {
		NSString *msg = @"TouchID may not support";
		[self alertOK:nil msg:msg okText:nil onOK:nil];
		_checkButton.selected = NO;
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

/**
 click the linkedin event
 */
- (void)clickLinkedin:(id)sender {
//    NSLog(@"clickLinkedin ");
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
					if (result.code == 0) {//go to the register page

						[self linkedinLogin:result.resultMap[@"email"] token:result.resultMap[@"tokenValue"]];
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

					                            if (result.code == 0) {//go to the register page

						                            [self linkedinLogin:result.resultMap[@"email"] token:result.resultMap[@"tokenValue"]];
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

/**
 click the forgot password event
 */
- (void)clickForgot:(id)sender {
	NSLog(@"clickForgot");
	ForgotViewController *forgot = [ForgotViewController new];
	[self openPage:forgot];
}

/**
 check thethe device supports biometrics
 */
- (BOOL)isSupportBiometrics {
	NSError *error;
	return [context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error];
}

/**
 logining by linked
 */
- (void)linkedinLogin:(NSString *)userid token:(NSString *)token {

	[self showIndicator];
	backTask(^() {
		[Proto linkedinLogin:token userid:userid];
		foreTask(^() {
			[self hideIndicator];
			if (Proto.isLogined) {
                putLoginType(1);
				[AppDelegate.instance switchToMainPage];
			}
		});
	});

}


/**
login event
 */
- (void)login:(NSString *)userName password:(NSString *)pwd {
    [self showIndicator];
    
    if(![self reachabilityStatus]){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self hideIndicator];
            [self showErrorMsgView:userName pwd:pwd];
        });
        return;
    }

	
	backTask(^() {
		HttpResult *r = [Proto login:userName pwd:pwd];
        
        if(r.OK){
            backTask(^{[Proto getProfileInfo];});
        }
		foreTask(^() {
			[self hideIndicator];

			if (r.code == 1001)//pwd is error
			{
				NSString *content = [NSString stringWithFormat:@"%@\n%@", localStr(@"sorry"), userName];
				[self Den_showAlertWithTitle:localStr(@"incorrect") message:content appearanceProcess:^(DenAlertController *_Nonnull alertMaker) {
					alertMaker.
							addActionCancelTitle(@"Try Again").
							addActionDefaultTitle(localStr(@"resetPwdLower"));
				}               actionsBlock:^(NSInteger buttonIndex, UIAlertAction *_Nonnull action, DenAlertController *_Nonnull alertSelf) {
					if ([action.title isEqualToString:localStr(@"resetPwdLower")]) {
						[self clickForgot:nil];
					}
				}];
			} else if (r.code == 1003)//username is error
			{
				NSString *content = [NSString stringWithFormat:@"%@\n%@", localStr(@"sorryEmail"), userName];
				[self Den_showAlertWithTitle:localStr(@"incorrMail") message:content appearanceProcess:^(DenAlertController *_Nonnull alertMaker) {
					alertMaker.
							addActionCancelTitle(@"Try Again").
							addActionDefaultTitle(localStr(@"create_newAccount"));
				}               actionsBlock:^(NSInteger buttonIndex, UIAlertAction *_Nonnull action, DenAlertController *_Nonnull alertSelf) {
					if ([action.title isEqualToString:localStr(@"create_newAccount")]) {
						[self clickGoReg:nil];
					}
				}];
			} else if (r.code == 0)//login success
			{
				if (r.OK) {
					keychainPutPwd(userName, pwd);
				}
				if (Proto.isLogined) {
					foreTask(^() {
                        putLoginType(0);
						[AppDelegate.instance switchToMainPage];
					});
				}
			}
		});
	});

}

/**
 check the newwork status
 */
-(BOOL)reachabilityStatus{
    NetworkStatus status = [[Reachability reachabilityForInternetConnection] currentReachabilityStatus];
    return status != NotReachable;
}

NSString *retryUserName;
NSString *retryPwd;
UIView *networkErrorView;

/**
 this is the error tip view,there two button action ,Retry action & dismiss action
 click the Retry action is log in again
 click the Dismiss action is hide this error view
 */
-(void)showErrorMsgView:(NSString*)userName pwd:(NSString*)pwd{
    retryUserName = userName;
    retryPwd = pwd;
    
    networkErrorView= self.view.addView;
    networkErrorView.backgroundColor = argbHex(0xdd000000);
    [[[[[networkErrorView.layoutMaker topParent:0]leftParent:0]rightParent:0]bottomParent:0]install];
    
    UILabel *label = networkErrorView.addLabel;
    label.textColor = UIColor.whiteColor;
    label.text = @"Seems like you are currently not\nconnected to the internet.\n\nTry again when you get online.";
    label.font = [Fonts regular:18];
    [[[[label.layoutMaker bottomParent:-120]leftParent:23]rightParent:-23]install];
    
    UIButton *retryBtn = networkErrorView.addButton;
    retryBtn.backgroundColor =Colors.textDisabled;
    [retryBtn addTarget:self action:@selector(retryLogin) forControlEvents:UIControlEventTouchUpInside];
    retryBtn.titleLabel.font = [Fonts regular:15];
    [retryBtn setTitle:@"Retry" forState:UIControlStateNormal];
    [[[[retryBtn.layoutMaker below:label offset:15]leftParent:23] sizeEq:100 h:44] install];
    
    UIButton *dismissBtn = networkErrorView.addButton;
    dismissBtn.backgroundColor = UIColor.whiteColor;
    [dismissBtn addTarget:self action:@selector(dismissErrorView) forControlEvents:UIControlEventTouchUpInside];
    [dismissBtn setTitleColor:rgbHex(0x4A4A4A) forState:UIControlStateNormal];
    dismissBtn.titleLabel.font = [Fonts regular:15];
    [dismissBtn setTitle:@"Dismiss" forState:UIControlStateNormal];
    [[[[[dismissBtn.layoutMaker below:label offset:15]toRightOf:retryBtn offset:10]rightParent:-23]heightEq:44] install];
}

/**
 click again to log in
 */
-(void)retryLogin{
    [self dismissErrorView];
    [self login:retryUserName password:retryPwd];
}

/**
 hide the error view
 */
-(void)dismissErrorView{
    [networkErrorView removeFromSuperview];
}

/**
 Click on a blank place to hide the keyboard
 */
-(void)keywordtapCLick
{
    [self.view endEditing:YES];
}

/**
 show the pickerview to choose a different server
 */
-(void)showServerView:(UITapGestureRecognizer *)recognizer
{
    DentistPickerView *picker = [[DentistPickerView alloc]init];
    picker.array = @[@"China",@"Amercia"];
    picker.righTtitle=localStr(@"OK");
    [picker show:^(NSString *result,NSString *resultname) {
        
    } rightAction:^(NSString *result,NSString *resultname) {
        if([result isEqualToString:@"Amercia"]){
            putServerDomain(1);
        }else{
            putServerDomain(0);
        }
        self->serverLabel.text=result;
    } selectAction:^(NSString *result,NSString *resultname) {
        
    }];
}

@end
