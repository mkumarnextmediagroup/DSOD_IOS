//
//  UploadResumeView.m
//  dentist
//
//  Created by Jacksun on 2018/12/18.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "UploadResumeView.h"
#import "Common.h"

@interface UploadResumeView()<UIGestureRecognizerDelegate>
{
    UIView *uploadView;
    UIView *submitView;
    UIView *doneView;
    UIButton *okBtn;
}

@end

static UploadResumeView *instance;
static dispatch_once_t onceToken;
#define edge 22
@implementation UploadResumeView

+ (instancetype)initUploadView:(UIViewController *)viewControl
{
    dispatch_once(&onceToken, ^{
        instance = [[UploadResumeView alloc] init];
        instance.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
        [instance initUploadView];
        [instance createSubmitView];
        [instance createDoneView];
        [viewControl.view addSubview:instance];
        instance.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
    });
    
    return instance;
}

+(void)attemptDealloc{
    instance = nil;
    onceToken = 0;
}

+(void)hide
{
    if (instance) {
        instance.frame = CGRectMake(SCREENWIDTH, 0, SCREENWIDTH, SCREENHEIGHT);
        [instance removeFromSuperview];
    }
    
    [self attemptDealloc];
}

- (void)show
{
    [UIView animateWithDuration:.3 animations:^{
        instance.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
    }];
}

- (void)sigleTappedPickerView:(UIGestureRecognizer *)sender
{
    CGPoint touchPoint = [sender locationInView:instance];
    CGRect clickArea = [instance convertRect:uploadView.bounds fromView:uploadView];
    
    if (CGRectContainsPoint(clickArea, touchPoint)) {
        NSLog(@"click in area");
    }else
    {
        NSLog(@"out of area");
        [UploadResumeView hide];
    }
}

- (void)initUploadView
{
    uploadView = [instance addView];
    uploadView.backgroundColor = [UIColor whiteColor];
    [[[[uploadView.layoutMaker leftParent:edge] sizeEq:SCREENWIDTH-edge*2 h:320] centerYParent:0] install];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sigleTappedPickerView:)];
    [singleTap setNumberOfTapsRequired:1];
    [instance addGestureRecognizer:singleTap];
    singleTap.delegate = self;
    
    UILabel *conLabel = [uploadView addLabel];
    conLabel.font = [Fonts semiBold:14];
    conLabel.textAlignment = NSTextAlignmentCenter;
    conLabel.textColor = Colors.textDisabled;
    conLabel.text = @"Add a resume to your";
    [[[[conLabel.layoutMaker topParent:42] leftParent:30] sizeEq:SCREENWIDTH-60-edge*2 h:30] install];
    
    UILabel *conLabel2 = [uploadView addLabel];
    conLabel2.font = [Fonts semiBold:14];
    conLabel2.textAlignment = NSTextAlignmentCenter;
    conLabel2.textColor = Colors.textDisabled;
    conLabel2.text = @"profile";
    [[[[conLabel2.layoutMaker below:conLabel offset:-5] leftParent:30] sizeEq:SCREENWIDTH-60-edge*2 h:20] install];
    
    UIImageView *imgVi = [uploadView addImageView];
    imgVi.image = [UIImage imageNamed:@"upload-resume"];
    [[[imgVi.layoutMaker below:conLabel2 offset:3] centerXParent:0] install];
    
    UIButton *uploadBtn = [uploadView addButton];
    [uploadBtn addTarget:self action:@selector(uploadBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [uploadBtn setTitle:@"Upload Resume" forState:UIControlStateNormal];
    uploadBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [uploadBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    uploadBtn.backgroundColor = Colors.textDisabled;
    uploadBtn.semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;
    uploadBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [[[[uploadBtn.layoutMaker sizeEq:SCREENWIDTH-60-edge*2 h:36] leftParent:30] below:imgVi offset:20] install];
    
    UILabel *introLab = [uploadView addLabel];
    introLab.font = [Fonts semiBold:13];
    introLab.textAlignment = NSTextAlignmentCenter;
    introLab.textColor = [UIColor blackColor];
    introLab.text = @"Mirosoft Word or PDF only(15M)";
    [[[[introLab.layoutMaker below:uploadBtn offset:15] leftParent:30] sizeEq:SCREENWIDTH-60-edge*2 h:30] install];
}

- (void)createSubmitView
{
    submitView = [instance addView];
    submitView.backgroundColor = [UIColor whiteColor];
    [[[[submitView.layoutMaker leftParent:-SCREENWIDTH] sizeEq:SCREENWIDTH-edge*2 h:320] centerYParent:0] install];
    
    UIImageView *imgVi = [submitView addImageView];
    imgVi.image = [UIImage imageNamed:@"submit_resume"];
//    imgVi.backgroundColor = [UIColor redColor];
    [[[[imgVi.layoutMaker topParent:75] sizeEq:100 h:100] centerXParent:0] install];
    
    
//    UIActivityIndicatorView *iv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
//    iv.tag = 998;
//    iv.color = UIColor.blueColor;
//    iv.backgroundColor = [UIColor clearColor];
//    [submitView addSubview:iv];
//    [[[[iv.layoutMaker sizeEq:10 h:10]rightParent:-10] topParent:10] install];
//    [iv startAnimating];
    
    _progressView = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
    [submitView addSubview:_progressView];
    [[[[_progressView.layoutMaker leftParent:20] rightParent:-20] below:imgVi offset:20]install];
    _progressView.progress = 0;
    
    UILabel *introLab = [submitView addLabel];
    introLab.numberOfLines = 0;
    introLab.font = [Fonts semiBold:14];
    introLab.textAlignment = NSTextAlignmentCenter;
    introLab.textColor = Colors.textDisabled;
    introLab.text = @"Submiting your resume...";
    [[[[introLab.layoutMaker bottomParent:-30] centerXParent:0] sizeEq:100 h:50] install];

}

- (void)createDoneView
{
    doneView = [instance addView];
    doneView.backgroundColor = [UIColor whiteColor];
    [[[[doneView.layoutMaker leftParent:-SCREENWIDTH] sizeEq:SCREENWIDTH-edge*2 h:320] centerYParent:0] install];
    
    UIImageView *imgVi = [doneView addImageView];
    imgVi.image = [UIImage imageNamed:@"submit_done"];
    //    imgVi.backgroundColor = [UIColor redColor];
    [[[[imgVi.layoutMaker topParent:75] sizeEq:100 h:100] centerXParent:0] install];
    
    UILabel *introLab = [doneView addLabel];
    introLab.numberOfLines = 0;
    introLab.font = [Fonts semiBold:14];
    introLab.textAlignment = NSTextAlignmentCenter;
    introLab.textColor = Colors.textDisabled;
    introLab.text = @"Resume Submited";
    [[[[introLab.layoutMaker bottomParent:-30] centerXParent:0] sizeEq:70 h:50] install];
    
    
    okBtn = [instance addButton];
    [okBtn addTarget:self action:@selector(okBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [okBtn setTitle:@"OK" forState:UIControlStateNormal];
    okBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [okBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    okBtn.backgroundColor = UIColor.whiteColor;
    okBtn.layer.masksToBounds = YES;
    okBtn.layer.cornerRadius = 5;
    okBtn.semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;
    okBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [[[[okBtn.layoutMaker sizeEq:SCREENWIDTH-60 h:36] leftParent:-SCREENWIDTH] bottomParent:-50] install];

    
}

- (void)okBtnClick
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(clickOkBtn)]){
        [self.delegate clickOkBtn];
    }
}

- (void)scrollToSubmit
{
    [[[[uploadView.layoutUpdate leftParent:SCREENWIDTH] sizeEq:SCREENWIDTH-edge*2 h:320] centerYParent:0] install];
    [[[[submitView.layoutUpdate leftParent:edge] sizeEq:SCREENWIDTH-edge*2 h:320] centerYParent:0] install];

    [UIView animateWithDuration:1 animations:^{
        [self layoutIfNeeded];
    }];
}

- (void)scrollToDone:(BOOL)isAnimate
{
    
    [[[[submitView.layoutUpdate leftParent:SCREENWIDTH] sizeEq:SCREENWIDTH-edge*2 h:320] centerYParent:0] install];
    [[[[doneView.layoutUpdate leftParent:edge] sizeEq:SCREENWIDTH-edge*2 h:320] centerYParent:0] install];
    [[[[okBtn.layoutUpdate sizeEq:SCREENWIDTH-60 h:36] leftParent:30] bottomParent:-50] install];
    if (isAnimate) {
        [UIView animateWithDuration:1 animations:^{
            [self layoutIfNeeded];
        }];
        
    }
}


- (void)uploadBtnClick:(UIButton *)btn
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(uploadResume)]){
        [self.delegate uploadResume];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
