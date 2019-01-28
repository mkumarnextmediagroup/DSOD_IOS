//
//  UploadResumeView.h
//  dentist
//
//  Created by Jacksun on 2018/12/18.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol UploadResumeViewDelegate <NSObject>

@optional
- (void)uploadResume;
@end

@interface UploadResumeView : UIView

@property (nonatomic,copy) NSString *issueNumber;
@property (nonatomic,weak) id<UploadResumeViewDelegate> delegate;
@property (nonatomic,strong) UIProgressView *progressView;
+ (instancetype)initUploadView:(UIViewController *)viewControl;
+ (void)hide;
- (void)show;
- (void)scrollToUpload;
- (void)scrollToSubmit;
- (void)scrollToDone:(BOOL)isAnimate;
- (void)sigleTappedPickerView:(UIGestureRecognizer *)sender;
- (void)closeBtnClick;
- (void)initUploadView;
- (void)createSubmitView;
- (void)createDoneView;
- (void)uploadBtnClick:(UIButton *)btn;

@end

NS_ASSUME_NONNULL_END
