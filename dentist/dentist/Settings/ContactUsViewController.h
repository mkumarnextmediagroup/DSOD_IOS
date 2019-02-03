//
//  ContactUsViewController.h
//  dentist
//
//  Created by Shirley on 2019/1/6.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ContactUsViewController : UIViewController

/**
 Open contact us page
 
 @param vc UIViewController
 */
+(void)openBy:(UIViewController*)vc;

/**
 add navigation bar
 */
-(void)addNavBar;

/**
 build views
 */
-(void)buildViews;

/**
 close page
 */
-(void)dismiss;

/**
 Submit button click event
 1、upload image
 2、add feedback
 */
-(void)submitBtnClick;

/**
 Call the interface to upload image
 
 @param image Selected image
 */
- (void)uploadAttach:(UIImage *)image;

/**
 Call the interface to dd feedback
 */
-(void)addFeedback;

/**
 show photo and name
 
 @param image UIImage
 @param name iamge name
 */
-(void)showPhoto:(UIImage*)image name:(NSString*)name;

/**
 delete attachment ，reset UI
 */
-(void)delAttachment;

/**
 Click to add an attachment
 */
-(void)addAttachMent;

/**
 Choose to get the attachment source type
 
 @param sourceType UIImagePickerControllerSourceType
 */
- (void)clickTheBtnWithSourceType:(UIImagePickerControllerSourceType)sourceType;

/**
 open image picker
 
 @param sourceType UIImagePickerControllerSourceType
 */
- (void)presentImagePickerViewController:(UIImagePickerControllerSourceType)sourceType;

/**
 image picker callback
 
 @param picker UIImagePickerController
 @param info selected image info dictionary
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info ;

/**
 save iamge to local
 
 @param image UIImage
 @return Saved image path
 */
- (NSString*)saveImageDocuments:(UIImage *)image;

/**
 begin edit textview
 
 @param textView UITextView
 @return should begin
 */
- (BOOL)textViewShouldBeginEditing:(UITextView*)textView ;

/**
 end edit textview
 
 @param textView UITextView
 */
- (void) textViewDidEndEditing:(UITextView*)textView ;

/**
 get text of textview
 
 @param textView UITextView
 @return text of textview
 */
-(NSString*)text:(UITextView*)textView;

/**
 UITextViewDelegate
 textView:shouldChangeTextInRange:replacementText:
 
 @param textView UITextView
 @param range NSRange
 @param text text
 @return You can enter the return YES, not the return NO.
 */
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;




@end

NS_ASSUME_NONNULL_END
