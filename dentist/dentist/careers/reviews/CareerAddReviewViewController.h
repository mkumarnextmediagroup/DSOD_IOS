//
//  CareerAddReviewViewController.h
//  dentist
//
//  Created by Shirley on 2018/12/11.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CareerAddReviewViewController : UIViewController

/**
 open add review page
 
 @param vc UIViewController
 @param dsoId dso id
 @param addReviewSuccessCallbak Add a comment success callback function
 */
+(void)openBy:(UIViewController*)vc dsoId:(NSString*)dsoId successCallbak:(void(^)(void))addReviewSuccessCallbak;

/**
 view did load
 add navigation bar
 build views
 */
- (void)viewDidLoad;
/**
 show keyboard notification
 更改布局高度，防止键盘遮挡
 Change layout height to prevent keyboard occlusion
 
 @param aNotification NSNotification
 */
- (void)keyboardWillShow:(NSNotification *)aNotification;
/**
 hide keyboard notification
 Restore layout height
 
 @param aNotification NSNotification
 */
- (void)keyboardWillHide:(NSNotification *)aNotification;
/**
 add navigation bar
 */
- (void)addNavBar;
/**
 build views
 */
- (void)buildViews;
/**
 current employee button and former employee click event
 Only one button can be selected for two buttons
 
 @param button Current response button
 */
- (void)employeeChange:(UIButton*)button;
/**
 
 recommends button and approve button click event
 toggle selected state
 
 @param button Current response button
 */
- (void)selectChanged:(UIButton*)button;
/**
 submit button click event
 Submit data to the server, add a comment
 */
- (void)submitBtnClick;
/**
 UITextViewDelegate
 用于实现默认提示语功能
 Used to implement the default prompt function
 
 @param textView UITextView
 @return default YES
 */
- (BOOL)textViewShouldBeginEditing:(UITextView*)textView;
/**
 UITextViewDelegate
 用于实现默认提示语功能
 Used to implement the default prompt function
 
 @param textView UITextView
 */
- (void) textViewDidEndEditing:(UITextView*)textView;
/**
 获得UITextView的真实内容
 Get the real content of UITextView
 
 @param textView UITextView
 @return text
 */
- (NSString*)text:(UITextView*)textView;
/**
 Control maximum word limit
 
 @param textView UITextView
 @param range NSRange
 @param text text
 @return Can input return YES, no input can return NO
 */
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
