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
        [instance initSliderView];
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
     CGPoint touchPoint = [sender locationInView:uploadView];
    if (CGRectContainsPoint(self.frame, touchPoint)) {
        NSLog(@"1111");
    }else
    {
        NSLog(@"2222");
    }
}

- (void)initSliderView
{
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sigleTappedPickerView:)];
    [singleTap setNumberOfTapsRequired:1];
    [self addGestureRecognizer:singleTap];
    singleTap.delegate = self;
    
    uploadView = [instance addView];
    uploadView.backgroundColor = [UIColor whiteColor];
    [[[[uploadView.layoutMaker leftParent:edge] sizeEq:SCREENWIDTH-edge*2 h:320] centerYParent:0] install];
    
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
