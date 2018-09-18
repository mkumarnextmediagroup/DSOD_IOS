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
#import "Async.h"
#import "Proto.h"
#import "AppDelegate.h"

#define TAG_NAME_FIELD 100

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

	UITextView *popView;
}

- (id)init {
	self = [super init];
	self.student = false;
	popView = nil;
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];

//    UIImageView *imageView = self.view.addImageView;
//    imageView.imageName = @"bg_3.png";
//    [imageView layoutFill];
    
    UIImage *image = [UIImage imageNamed:@"bg_3.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [self.view addSubview:imageView];
    [imageView layoutFill];
    
    

	UIImageView *logoView = self.view.addImageView;
	logoView.imageName = @"logo";
	[logoView layoutCenterXOffsetTop:260 height:54 offset:54+NAVHEIGHT_OFFSET];

	UIImageView *backView = self.view.addImageView;
	backView.imageName = @"back_arrow";
	[backView scaleFit];
	[[[[backView.layoutMaker sizeEq:23 h:23] leftParent:16] topParent:30+NAVHEIGHT_OFFSET] install];


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

	[sl push:loginPanel height:20 marginBottom:33+TABLEBAR_SAFE_BOTTOM_MARGIN];

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
	[andLabel textColorWhite];
	[[[[[andLabel layoutMaker] sizeFit] centerXParent:8] topParent:0] install];

	UILabel *termLabel = termPanel.addLabel;
	termLabel.font = [Fonts regular:12];
	termLabel.text = localStr(@"terms");
	[termLabel textColorWhite];
	[termLabel underLineSingle];
	[[[[[termLabel layoutMaker] sizeFit] topParent:0] toLeftOf:andLabel offset:0] install];
	[termLabel onClickView:self action:@selector(clickTerms:)];

	UILabel *policyLabel = termPanel.addLabel;
	policyLabel.font = [Fonts regular:12];
	policyLabel.text = localStr(@"policy");
	[policyLabel textColorWhite];
	[policyLabel underLineSingle];
	[[[[[policyLabel layoutMaker] sizeFit] topParent:0] toRightOf:andLabel offset:0] install];
	[policyLabel onClickView:self action:@selector(clickPolicy:)];

	UILabel *dotLabel = termPanel.addLabel;
	dotLabel.font = [Fonts regular:12];
	dotLabel.text = @".";
	[dotLabel textColorWhite];
	[[[[[dotLabel layoutMaker] sizeFit] topParent:0] toRightOf:policyLabel offset:0] install];


	UILabel *agreeLabel = self.view.addLabel;
	agreeLabel.font = [Fonts regular:12];
	agreeLabel.numberOfLines = 2;
	[agreeLabel textAlignCenter];
	[agreeLabel textColorWhite];
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

    
	pwdEdit = self.view.addEditPwd;
	pwdEdit.delegate = self;
    pwdEdit.hint = localStr(@"pwd");
	[pwdEdit returnDone];
	[pwdEdit keyboardDefault];
	[sl push:pwdEdit height:36 marginBottom:10];

	emailEdit = self.view.addEditRounded;
	emailEdit.delegate = self;
    if (self.student) {
        emailEdit.hint = localStr(@"schemail");
    }else
    {
        emailEdit.hint = localStr(@"email_address");
    }
	emailEdit.text = self.emailStr;
	[emailEdit returnNext];
	[emailEdit keyboardEmail];
	[sl push:emailEdit height:36 marginBottom:10];

	nameEdit = self.view.addEditRounded;
	nameEdit.delegate = self;
    nameEdit.tag=TAG_NAME_FIELD;
	nameEdit.hint = localStr(@"full_name");
	nameEdit.text = self.nameStr;
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
	[reqLabel onClickView:self action:@selector(clickReqLabel:)];


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
					alertTitle = localStr(@"useTouchIDTitle");
					alertHint = localStr(@"useTouchIDHint");
					break;
				case LABiometryTypeFaceID:
					touchLabel.text = localStr(@"enable_face");
					alertTitle = localStr(@"useFaceIDTitle");
					alertHint = localStr(@"useFaceIDHint");
					break;
				default:
					break;
			}
		}else
        {
            touchLabel.text = localStr(@"enable_touch");
            alertTitle = localStr(@"useTouchIDTitle");
            alertHint = localStr(@"useTouchIDHint");

        }
	} else {
        checkButton.selected = NO;
        checkButton.enabled = NO;
	}

}

- (UITextView *)pwdReqView {
	UITextView *noticelb = [UITextView new];
	noticelb.backgroundColor = Colors.secondary;
	noticelb.textColor = UIColor.whiteColor;
	noticelb.tag = 11;
	noticelb.editable = NO;
	noticelb.textContainerInset = UIEdgeInsetsMake(10, 0, 0, 15);
	noticelb.font = [Fonts regular:10];

	UIButton *b = [UIButton buttonWithType:UIButtonTypeCustom];
	b.frame = makeRect(SCREENWIDTH - 88, 0, 60, BTN_HEIGHT);
	[b setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
	[noticelb addSubview:b];
	[b onClick:self action:@selector(deletePwdReqView:)];
	return noticelb;
}

- (void)deletePwdReqView:(UIButton *)btn {
	[btn.superview removeFromSuperview];
	popView = nil;
}

- (void)clickReqLabel:(UILabel *)sender {
	if (popView != nil) {
		return;
	}
	UITextView *tv = [self pwdReqView];
	tv.text = localStr(@"pwdstandard");
	[self.view addSubview:tv];
	[[[[[[tv layoutMaker] leftParent:EDGE] rightParent:-EDGE] heightEq:45] below:sender offset:16] install];

	popView = tv;

}


- (void)textFieldDidEndEditing:(UITextField *)textField {

	BOOL err = NO;
	if ([nameEdit.text trimed].length < 1) {
		[nameEdit themeError];
		err = YES;
	} else {
		[nameEdit themeNormal];
	}
	if ([emailEdit.text trimed].length < 1 || !emailEdit.text.matchEmail) {
		[emailEdit themeError];
		err = YES;
	} else {
		[emailEdit themeNormal];
	}
	if (pwdEdit.text.length == 0) {
		[pwdEdit themeError];
		err = YES;
	} else {
		[pwdEdit themeNormal];
	}
	regButton.enabled = !err;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    //The maximum user name of the registration page is 50 characters.
    if(textField.tag==TAG_NAME_FIELD){
        NSString *toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        if ([toBeString length] > 50) {
            textField.text = [toBeString substringToIndex:50];
            return NO;
        }
    }
    return YES;
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
	NSString *email = [emailEdit.text trimed];
	NSString *pwd = [pwdEdit.text trimed];
	NSString *fullName = [nameEdit.text trimed];

	if (!email.matchEmail) {
		[emailEdit themeError];
		return;

	}
	if (!pwd.matchPassword) {
		[pwdEdit themeError];
		[self alertOK:nil msg:localStr(@"pwdstandard") okText:nil onOK:nil];
		return;
	}
	if (checkButton.hidden || !checkButton.isSelected) {
		[self doReg:email pwd:pwd fullName:fullName];
		return;
	}


	Confirm *cf = [Confirm new];
	cf.title = alertTitle;
	cf.msg = alertHint;
	cf.cancelText = localStr(@"notallow");
	[cf show:self onOK:^() {
		NSError *error;
        if ([self->context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
            [self->context evaluatePolicy:LAPolicyDeviceOwnerAuthentication localizedReason:localStr(@"authenticateHint") reply:
					^(BOOL success, NSError *authenticationError) {
						if (success) {
							[self doReg:email pwd:pwd fullName:fullName];
						}
					}];
		}

	}];


}

- (void)doReg:(NSString *)email pwd:(NSString *)pwd fullName:(NSString *)fullName {

	backTask(^() {
		HttpResult *r = [Proto register:email pwd:pwd name:fullName student:self.student];
        if (r.code == 0) {//register success
            if (r.OK) {
                keychainPutPwd(email, pwd);
            }
            if (Proto.isLogined) {
                foreTask(^() {
                    [AppDelegate.instance switchToMainPage];
                });
            }
        }else if (r.code == 1002)
        {
            NSString *content = [NSString stringWithFormat:@"%@%@%@",localStr(@"showFir"),email,localStr(@"showLast")];
            [self Den_showAlertWithTitle:localStr(@"emailUse") message:content appearanceProcess:^(DenAlertController * _Nonnull alertMaker) {
                alertMaker.
                addActionCancelTitle(@"Try Again").
                addActionDefaultTitle(localStr(@"logIn"));
            } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, DenAlertController * _Nonnull alertSelf) {
                if ([action.title isEqualToString:localStr(@"logIn")]) {
                    [self clickLogin:nil];
                }
            }];
        }
        
        if (self.student) {
            [DenGlobalInfo sharedInstance].identity = @"student";
        }else
        {
            [DenGlobalInfo sharedInstance].identity = @"user";
        }
	});


}

- (BOOL)isSupportBiometrics {

	NSError *error;
	BOOL success;
	success = [context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error];
	return success;

}


- (void)clickLinkedin:(id)sender {
	NSLog(@"clickLinkedin ");
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
					// Whole User Info

                    NSString *token = userInfo[@"access_token"];
                    //send the token to the server
                    HttpResult *result = [Proto sendLinkedInInfo:token];
                    NSLog(@"%@", result);
                    if (result.code == 0) {//go to the register page
                        
                        [self linkedinLogin:result.resultMap[@"userId"] token:result.resultMap[@"tokenValue"]];
                    }

				}                         failUserInfo:^(NSError *error) {
					NSLog(@"error : %@", error.userInfo.description);
				}];
			} else {

				linkedIn.cancelButtonText = @"Close"; // Or any other language But Default is Close

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

                                                NSString *token = userInfo[@"access_token"];
                                                //send the token to the server
                                                HttpResult *result = [Proto sendLinkedInInfo:token];
                                                NSLog(@"%@", result);
                                                if (result.code == 0) {//go to the register page
                                                    
                                                    [self linkedinLogin:result.resultMap[@"userId"] token:result.resultMap[@"tokenValue"]];
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

- (void)clickLogin:(id)sender {
	LoginController *c = [LoginController new];
    c.student = self.student;
	[self openPage:c];
}

- (void)linkedinLogin:(NSString *)userid token:(NSString *)token {
    
    backTask(^() {
        [Proto linkedinLogin:token userid:userid];
        if (Proto.isLogined) {
            foreTask(^() {
                [AppDelegate.instance switchToMainPage];
            });
        }
    });
    
}

@end
