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


+(void)openBy:(UIViewController*)vc dsoId:(NSString*)dsoId successCallbak:(void(^)(void))addReviewSuccessCallbak;
- (void)viewDidLoad;
- (void)keyboardWillShow:(NSNotification *)aNotification;
- (void)keyboardWillHide:(NSNotification *)aNotification;
- (void)addNavBar;
- (void)buildViews;
- (void)employeeChange:(UIButton*)button;
- (void)selectChanged:(UIButton*)button;
- (void)submitBtnClick;
- (BOOL)textViewShouldBeginEditing:(UITextView*)textView;
- (void) textViewDidEndEditing:(UITextView*)textView;
- (NSString*)text:(UITextView*)textView;
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
