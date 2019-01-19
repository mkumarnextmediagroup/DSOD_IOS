//
//  ContactUsViewController.m
//  dentist
//
//  Created by Shirley on 2019/1/6.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "ContactUsViewController.h"
#import "Common.h"
#import "Proto.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface ContactUsViewController ()<UITextViewDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@end

@implementation ContactUsViewController{
    int edge;
    UIScrollView *scrollView;
    UIView *contentView;
    
    UITextView *emailTextView;
    UITextView *questionTextView;
    UIButton *submitBtn;
    
    
    UIImageView *photoImageView;
    UILabel *attachLabel;
    UIImageView *delImageView;
    
    UIImage *attachImage;
    NSString *attachmentId;

}

+(void)openBy:(UIViewController*)vc{
    ContactUsViewController *newVC = [ContactUsViewController new];
    [vc presentViewController:newVC animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addNavBar];
    
    [self buildViews];
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}



- (void)keyboardWillShow:(NSNotification *)aNotification{
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    
    [UIView animateWithDuration:0.25f animations:^{
        [self.view setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width,  keyboardRect.origin.y)];
    }];
    
    
}

- (void)keyboardWillHide:(NSNotification *)aNotification{
    
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    
    [UIView animateWithDuration:0.25f animations:^{
        [self.view setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width,  keyboardRect.origin.y)];
    }];
}

- (void)dealloc{
    [ [NSNotificationCenter defaultCenter]removeObserver:self ];
}

-(void)addNavBar{
    
    UIView *topVi = self.view.addView;
    topVi.backgroundColor = UIColor.whiteColor;
    [[[[[topVi.layoutMaker leftParent:0] rightParent:0] topParent:0]sizeEq:SCREENWIDTH h:NAVHEIGHT] install];

    UIView *titleView = topVi.addView;
    [[[[[titleView.layoutMaker leftParent:0] rightParent:0] topParent:24]bottomParent:0] install];

    UILabel *titleLabel = [titleView addLabel];
    titleLabel.font = [Fonts regular:15];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.text = @"CONTACT US";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [[[titleLabel.layoutMaker centerXParent:0]centerYParent:0] install];
    
    UIButton *closeBtn = [titleView addButton];
    [closeBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [[[[closeBtn.layoutMaker rightParent:-10] centerYParent:0] sizeEq:40 h:40] install];
    
    UILabel *lineLabel = topVi.lineLabel;
    [[[[[lineLabel.layoutMaker bottomParent:0]leftParent:0]rightParent:0]heightEq:1]install];
}

-(void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)buildViews{
    edge = 18;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = UIColor.whiteColor;
    
    scrollView = [UIScrollView new];
    scrollView.alwaysBounceVertical = YES;
    [self.view addSubview:scrollView];
    [scrollView layoutFill];
    [[scrollView.layoutUpdate topParent:NAVHEIGHT]install];
    
    contentView = scrollView.addView;
    [[[[[[contentView.layoutMaker topParent:0]leftParent:0] rightParent:0] bottomParent:0]widthEq:SCREENWIDTH] install];
    
    
    UILabel *haveQuestionLabel = contentView.addLabel;
    haveQuestionLabel.font = [Fonts regular:12];
    haveQuestionLabel.textColor = rgbHex(0x9B9B9B);
    haveQuestionLabel.text = @"Have a question for us?";
    [[[[haveQuestionLabel.layoutMaker leftParent:edge ]topParent:edge]rightParent:-edge]install];
    
    UILabel *line1 = contentView.lineLabel;
    [[[[[line1.layoutMaker below:haveQuestionLabel offset:edge]leftParent:0]rightParent:0]heightEq:1]install];
    
    UILabel *emailLabel = contentView.addLabel;
    emailLabel.font = [Fonts regular:12];
    emailLabel.textColor = rgbHex(0x9B9B9B);
    emailLabel.text = @"Your email address";
    [[[[emailLabel.layoutMaker leftParent:edge ]below:line1 offset:edge]rightParent:-edge]install];
    
    emailTextView = contentView.addTextView;
    emailTextView.font = [Fonts regular:12];
    emailTextView.editable = YES;
    emailTextView.scrollEnabled = NO;
    emailTextView.delegate = self;
    emailTextView.textColor = rgbHex(0x8e8e8e);
    emailTextView.text = @"Type here...";
    emailTextView.tag=0;
    emailTextView.returnKeyType = UIReturnKeyNext;
    emailTextView.contentInset = UIEdgeInsetsMake(0, 0, 0,0);
    [[[[[emailTextView.layoutMaker below:emailLabel offset:5]leftParent:13]rightParent:-13]heightEq:45] install];
    
    emailTextView.textColor = rgbHex(0x4a4a4a);
    emailTextView.tag=1;
    emailTextView.text = [Proto lastAccount];
    
    UILabel *line2 = contentView.lineLabel;
    [[[[[line2.layoutMaker below:emailTextView offset:0]leftParent:0]rightParent:0]heightEq:1]install];
    
    UILabel *questionLabel = contentView.addLabel;
    questionLabel.font = [Fonts regular:12];
    questionLabel.textColor = rgbHex(0x9B9B9B);
    questionLabel.text = @"Write your question or comment";
    [[[[questionLabel.layoutMaker leftParent:edge ]below:line2 offset:edge]rightParent:-edge]install];
    
    
    questionTextView = contentView.addTextView;
    questionTextView.font = [Fonts regular:12];
    questionTextView.editable = YES;
    questionTextView.delegate = self;
    questionTextView.textColor = rgbHex(0x8e8e8e);
    questionTextView.text = @"Type here...";
    questionTextView.tag=0;
    questionTextView.returnKeyType = UIReturnKeyDone;
    questionTextView.contentInset = UIEdgeInsetsMake(5, 0, 5, 0);
    [[[[[questionTextView.layoutMaker leftParent:13] rightParent:-13] below:questionLabel offset:0]heightEq:160] install];
    
    UILabel *line3 = contentView.lineLabel;
    [[[[[line3.layoutMaker below:questionTextView offset:0]leftParent:0]rightParent:0]heightEq:1]install];
    
    UIView *attachView = contentView.addView;
    [attachView onClickView:self action:@selector(addAttachMent)];
    [[[[attachView.layoutMaker below:line3 offset:0]leftParent:0]rightParent:0]install];
    
    photoImageView = attachView.addImageView;
    photoImageView.imageName = @"photo";
    [[[[[photoImageView.layoutMaker leftParent:edge] topParent:5]bottomParent:-5] sizeEq:40 h:40]install];
    
    delImageView = attachView.addImageView;
    delImageView.imageName = @"close_select";
    [delImageView onClickView:self action:@selector(delAttachment)];
    [[[[delImageView.layoutMaker rightParent:0] centerYOf:photoImageView offset:0]sizeEq:50 h:50]install];
    
    attachLabel = attachView.addLabel;
    attachLabel.font = [Fonts regular:12];
    attachLabel.textColor = rgbHex(0x4a4a4a);
    attachLabel.text = @"Add an attachment";
    attachLabel.numberOfLines = 2;
    [[[[attachLabel.layoutMaker toRightOf:photoImageView offset:edge]toLeftOf:delImageView offset:10] centerYOf:photoImageView offset:0]install];
    
    
    
    
    UILabel *line4 = contentView.lineLabel;
    [[[[[line4.layoutMaker below:attachView offset:0]leftParent:0]rightParent:0]heightEq:1]install];

    UILabel *tipsLabel = contentView.addLabel;
    tipsLabel.font = [Fonts semiBold:16];
    tipsLabel.textColor = rgbHex(0x4a4a4a);
    tipsLabel.text = @"We will do our best to get back \nto you in less then 24 hrs.";
    [[[tipsLabel.layoutMaker  leftParent:edge]below:line4 offset:50] install];
    
    submitBtn = contentView.addButton;
    submitBtn.backgroundColor =Colors.textDisabled;
    [submitBtn addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    submitBtn.titleLabel.font = [Fonts regular:15];
    [submitBtn setTitle:@"Send message" forState:UIControlStateNormal];
    [[[[[[submitBtn.layoutMaker below:tipsLabel offset:50]leftParent:edge]rightParent:-edge]bottomParent:-30]heightEq:40] install];
    
    [contentView.layoutUpdate.bottom.greaterThanOrEqualTo(submitBtn) install];
}


-(void)submitBtnClick{
    [self showLoading];
    
    if(attachImage){
        [self uploadAttach:attachImage];
    }else{
        [self addFeedback];
    }
}

- (void)uploadAttach:(UIImage *)image{
    
    NSString *localFile = [self saveImageDocuments:image];
    if (localFile != nil) {
        [Proto settingUploadPictrue:localFile completed:^(BOOL success, NSString *msg, NSString *attachId) {
            if(success){
                self-> attachmentId = attachId;
                [self addFeedback];
            }else{
                [self hideLoading];
                Alert *alert = [Alert new];
                alert.title = msg;
                [alert show:self];
            }
        }];
    }
}

-(void)addFeedback{
    [Proto addFeedback:[self text:questionTextView] email:[self text:emailTextView] attachmentId:attachmentId completed:^(BOOL success, NSString *msg) {
        [self hideLoading];
        
        [self Den_showAlertWithTitle:success?@"Message sent successfully":msg message:nil appearanceProcess:^(DenAlertController * _Nonnull alertMaker) {
            alertMaker.addActionCancelTitle(@"OK");
        } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, DenAlertController * _Nonnull alertSelf) {
            if (success) {
                [self dismiss];
            }
        }];
    }];
}

-(void)showPhoto:(UIImage*)image name:(NSString*)name{
    attachImage = image;
    photoImageView.image = image;
    [photoImageView scaleFill];
    attachLabel.text = name;
    delImageView.hidden = NO;
}

-(void)delAttachment{
    attachImage = nil;
    attachmentId = nil;
    photoImageView.imageName = @"photo";
    [photoImageView alignCenter];
    attachLabel.text = @"Add an attachment";
    delImageView.hidden = YES;
}

-(void)addAttachMent{
    [self Den_showActionSheetWithTitle:nil message:nil appearanceProcess:^(DenAlertController *_Nonnull alertMaker) {
        alertMaker.
        addActionCancelTitle(@"cancel").
        addActionDefaultTitle(@"Camera").
        addActionDefaultTitle(@"Gallery");
    }                     actionsBlock:^(NSInteger buttonIndex, UIAlertAction *_Nonnull action, DenAlertController *_Nonnull alertSelf) {
        if ([action.title isEqualToString:@"cancel"]) {
            NSLog(@"cancel");
        } else if ([action.title isEqualToString:@"Camera"]) {
            NSLog(@"Camera");
            [self clickTheBtnWithSourceType:UIImagePickerControllerSourceTypeCamera];
        } else if ([action.title isEqualToString:@"Gallery"]) {
            NSLog(@"Gallery");
            [self clickTheBtnWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        }
    }];
}

- (void)clickTheBtnWithSourceType:(UIImagePickerControllerSourceType)sourceType
{
    [DenCamera clickTheBtnWithSourceType:sourceType block:^(NSString *isAllow) {
        NSLog(@"%@",isAllow);
        if ([isAllow isEqualToString:@"CameraRefuse"]) {
            Alert *alert = [Alert new];
            alert.title = @"Unauthorized use of camera";
            alert.msg = @"Please open it in IOS “settings”-“privacy”-“camera”";
            [alert show:self];
            
        }else if ([isAllow isEqualToString:@"PhotoRefuse"]){
            Alert *alert = [Alert new];
            alert.title = @"Unauthorized use of photo";
            alert.msg = @"Please open it in IOS “settings”-“privacy”-“photo”";
            [alert show:self];
            
        }else if ([isAllow isEqualToString:@"allow"]){
            [self presentImagePickerViewController:sourceType];
        }
    }];
}

- (void)presentImagePickerViewController:(UIImagePickerControllerSourceType)sourceType {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.sourceType = sourceType;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSString *imageName = @"";
    
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        imageName = @"IMG_NEW.JPG";
        
    }else{
        NSURL *imageURL = [info valueForKey:UIImagePickerControllerReferenceURL];
        PHFetchResult * fetchResult = [PHAsset fetchAssetsWithALAssetURLs: @[imageURL] options: nil];
        PHAsset * asset = fetchResult.firstObject;
        PHAssetResource * resource = [[PHAssetResource assetResourcesForAsset: asset] firstObject];
        
        imageName = resource.originalFilename;
    }
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    [self showPhoto:image name:imageName];
    [self dismissViewControllerAnimated:NO completion:nil];
    
}


- (NSString*)saveImageDocuments:(UIImage *)image {
    
    CGFloat f = (image.size.width > 600 ? 600.0 : image.size.width ) / image.size.width;
    //拿到图片
    UIImage *imagesave = [image scaledBy:f];
    NSString *path_sandox = NSHomeDirectory();
    //设置一个图片的存储路径
    NSString *imagePath = [NSString stringWithFormat:@"%@/Documents/%@",path_sandox ,@"test.png"];
    
    [UIImagePNGRepresentation(imagesave) writeToFile:imagePath atomically:YES];
    
    return imagePath;
}

- (BOOL)textViewShouldBeginEditing:(UITextView*)textView {
    if (textView.tag==0) {
        textView.text = @"";
        textView.textColor = rgbHex(0x4a4a4a);
        textView.tag=1;
    }
    return YES;
}

- (void) textViewDidEndEditing:(UITextView*)textView {
    if(textView.text.length == 0){
        textView.textColor = rgbHex(0x8e8e8e);
        textView.text = @"Type here...";
        textView.tag=0;
    }
}

-(NSString*)text:(UITextView*)textView{
    if(textView.tag == 1){
        return textView.text;
    }else{
        return @"";
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"] ){
        if(textView == emailTextView){
            [questionTextView becomeFirstResponder];
        }else{
            [textView resignFirstResponder];
        }
        return NO;
    }
    
    int maxLength = 50;
    if(textView == questionTextView){
        maxLength = 300;
    }
    
    if (textView.text.length - range.length + text.length > maxLength && ![text isEqualToString:@""]){
        return  NO;
    }else{
        return YES;
    }
}
@end
