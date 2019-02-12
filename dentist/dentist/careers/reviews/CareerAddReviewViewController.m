//
//  CareerAddReviewViewController.m
//  dentist
//
//  Created by Shirley on 2018/12/14.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "CareerAddReviewViewController.h"
#import "Common.h"
#import "XHStarRateView.h"
#import "Proto.h"

@interface CareerAddReviewViewController ()<UITextViewDelegate>

@property (nonatomic,strong) NSString *dsoId;
@property (nonatomic,copy)  void(^addReviewSuccessCallbak)(void);

@end

@implementation CareerAddReviewViewController{
    
    int edge;
    UIScrollView *scrollView;
    UIView *contentView;
    
    XHStarRateView *starRateView;
    UIButton *currentEmployeeBtn;
    UIButton *formerEmployeeBtn;
    UITextView *reviewTitleTextView;
    UITextView *prosTextView;
    UITextView *consTextView;
    UITextView *adviceTextView;
    UIButton *recommendsBtn;
    UIButton *approveBtn;
    UIButton *submitBtn;
}


/**
 open add review page

 @param vc UIViewController
 @param dsoId dso id
 @param addReviewSuccessCallbak Add a comment success callback function
 */
+(void)openBy:(UIViewController*)vc dsoId:(NSString*)dsoId successCallbak:(void(^)(void))addReviewSuccessCallbak{
    
    CareerAddReviewViewController *addReviewVC = [CareerAddReviewViewController new];
    addReviewVC.dsoId = dsoId;
    addReviewVC.addReviewSuccessCallbak = addReviewSuccessCallbak;
    [vc pushPage:addReviewVC];
    
}


/**
 view did load
 add navigation bar
 build views
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    edge = 18;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = UIColor.whiteColor;
    
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



/**
 show keyboard notification
 更改布局高度，防止键盘遮挡
 Change layout height to prevent keyboard occlusion

 @param aNotification NSNotification
 */
- (void)keyboardWillShow:(NSNotification *)aNotification{
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    
    UIView *view = [contentView findFirstResponder];
    float scrollY = self->scrollView.contentOffset.y;
    scrollY = scrollY > 0 ? scrollY : 0;
    if(view == prosTextView){
        scrollY = scrollY > 50 ? scrollY : 50 ;
    }if(view == consTextView){
        scrollY = scrollY > 200 ? scrollY : 200 ;
    }else if(view == adviceTextView){
        scrollY = scrollY > 250 ? scrollY : 250 ;
    }
    
    [UIView animateWithDuration:0.25f animations:^{
        [self.view setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width,  keyboardRect.origin.y)];
        [self->scrollView setContentOffset:CGPointMake(0,scrollY) animated:YES];
    }];
    
    
}

/**
 hide keyboard notification
 Restore layout height
 
 @param aNotification NSNotification
 */
- (void)keyboardWillHide:(NSNotification *)aNotification{
    
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    
    [UIView animateWithDuration:0.25f animations:^{
        [self.view setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width,  keyboardRect.origin.y)];
    }];
}

/**
 remove observer
 */
- (void)dealloc{
    [ [NSNotificationCenter defaultCenter]removeObserver:self ];
}

/**
 add navigation bar
 */
-(void)addNavBar{
    UINavigationItem *item = [self navigationItem];
    item.title = @"ADD REVIEW";
    item.leftBarButtonItem = [self navBarBack:self action:@selector(dismiss)];
    
}

/**
 build views
 */
-(void)buildViews{

    scrollView = [UIScrollView new];
    [self.view addSubview:scrollView];
    [scrollView layoutFill];
    [[scrollView.layoutUpdate topParent:NAVHEIGHT]install];
    
    
    contentView = scrollView.addView;
    [[[[[[contentView.layoutMaker topParent:0]leftParent:edge] rightParent:-edge] widthEq:SCREENWIDTH - 2* edge] bottomParent:0] install];
    
    UILabel *chooseRatingLabel = contentView.addLabel;
    chooseRatingLabel.text = @"Choose rating";
    chooseRatingLabel.font = [Fonts regular:14];
    chooseRatingLabel.textColor = rgbHex(0x879AA8);
    [[[chooseRatingLabel.layoutMaker centerXParent:0] topParent:edge]install];
    
    
    starRateView = [[XHStarRateView alloc] initWithFrame:CGRectMake((SCREENWIDTH-2*edge - 130) /2, 40, 130, 24)];
    starRateView.isAnimation = YES;
    starRateView.rateStyle = WholeStar;
    starRateView.tag = 1;
    [contentView addSubview:starRateView];

    
    
    float buttonWidth = (SCREENWIDTH - 2 * edge ) / 2;
    currentEmployeeBtn = contentView.addButton;
    currentEmployeeBtn.titleLabel.font = [Fonts regular:14];
    [currentEmployeeBtn setTitleColor:rgbHex(0x4a4a4a) forState:UIControlStateNormal];
    [currentEmployeeBtn setTitle:@"Current Employee" forState:UIControlStateNormal];
    [currentEmployeeBtn setImage:[UIImage imageNamed:@"checkbox"] forState:UIControlStateNormal];
    [currentEmployeeBtn setImage:[UIImage imageNamed:@"checkbox_on"] forState:UIControlStateSelected];
    currentEmployeeBtn.titleEdgeInsets = UIEdgeInsetsMake(0.0,5, 0.0, 0);
    currentEmployeeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [[[[currentEmployeeBtn.layoutMaker leftParent:0]below:starRateView offset:10] widthEq:buttonWidth] install];
    [currentEmployeeBtn onClick:self action:@selector(employeeChange:)];
    
    
    
    formerEmployeeBtn = contentView.addButton;
    formerEmployeeBtn.titleLabel.font = [Fonts regular:14];
    [formerEmployeeBtn setTitleColor:rgbHex(0x4a4a4a) forState:UIControlStateNormal];
    [formerEmployeeBtn setTitle:@"Former Employee" forState:UIControlStateNormal];
    [formerEmployeeBtn setImage:[UIImage imageNamed:@"checkbox"] forState:UIControlStateNormal];
    [formerEmployeeBtn setImage:[UIImage imageNamed:@"checkbox_on"] forState:UIControlStateSelected];
    formerEmployeeBtn.titleEdgeInsets = UIEdgeInsetsMake(0.0,5, 0.0, 0);
    formerEmployeeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [[[[formerEmployeeBtn.layoutMaker toRightOf:currentEmployeeBtn offset:0]below:starRateView offset:10] widthEq:buttonWidth] install];
    [formerEmployeeBtn onClick:self action:@selector(employeeChange:)];
    
    currentEmployeeBtn.argObject = formerEmployeeBtn;
    formerEmployeeBtn.argObject = currentEmployeeBtn;

    //Review Title
    UILabel *reviewTitleLabel = contentView.addLabel;
    reviewTitleLabel.text = @"Review Title";
    reviewTitleLabel.textColor = rgbHex(0x4a4a4a);
    reviewTitleLabel.font = [Fonts regular:14];
    [[[[reviewTitleLabel.layoutMaker leftParent:0] below:currentEmployeeBtn offset:10] rightParent:0]install];
    
    
    UIView *reviewTitlebg = contentView.addView;
    reviewTitlebg.backgroundColor = rgbHex(0xf8f8f8);
    reviewTitlebg.layer.cornerRadius = 3;
    [[[[reviewTitlebg.layoutMaker leftParent:0] rightParent:0] below:reviewTitleLabel offset:5 ] install];
    
    reviewTitleTextView = reviewTitlebg.addTextView;
    reviewTitleTextView.font = [Fonts regular:15];
    reviewTitleTextView.editable = YES;
    reviewTitleTextView.delegate = self;
    reviewTitleTextView.textColor = rgbHex(0x879AA8);
    reviewTitleTextView.text = @"Type here...";
    reviewTitleTextView.tag=0;
    reviewTitleTextView.returnKeyType = UIReturnKeyDone;
    reviewTitleTextView.contentInset = UIEdgeInsetsMake(3, 0, 3, 0);
    [[[[[[reviewTitleTextView.layoutMaker leftParent:5] rightParent:5] topParent:0]bottomParent:0] heightEq:45] install];
    
    
    //Pros
    UILabel *prosLabel = contentView.addLabel;
    prosLabel.text = @"Pros";
    prosLabel.textColor = rgbHex(0x4a4a4a);
    prosLabel.font = [Fonts regular:14];
    [[[[prosLabel.layoutMaker leftParent:0] below:reviewTitlebg offset:10] rightParent:0] install];
    
    
    UIView *prosbg = contentView.addView;
    prosbg.backgroundColor = rgbHex(0xf8f8f8);
    prosbg.layer.cornerRadius = 3;
    [[[[prosbg.layoutMaker leftParent:0] rightParent:0] below:prosLabel offset:5 ] install];

    prosTextView = prosbg.addTextView;
    prosTextView.font = [Fonts regular:15];
    prosTextView.editable = YES;
    prosTextView.delegate = self;
    prosTextView.textColor = rgbHex(0x879AA8);
    prosTextView.text = @"Type here...";
    prosTextView.tag=0;
    prosTextView.returnKeyType = UIReturnKeyDone;
    [[[[[[prosTextView.layoutMaker leftParent:5] rightParent:5] topParent:0]bottomParent:0] heightEq:80] install];


    //Cons
    UILabel *consLabel = contentView.addLabel;
    consLabel.text = @"Cons";
    consLabel.textColor = rgbHex(0x4a4a4a);
    consLabel.font = [Fonts regular:14];
    [[[[consLabel.layoutMaker leftParent:0] below:prosTextView offset:10] rightParent:0] install];


    UIView *consbg = contentView.addView;
    consbg.backgroundColor = rgbHex(0xf8f8f8);
    consbg.layer.cornerRadius = 3;
    [[[[consbg.layoutMaker leftParent:0] rightParent:0] below:consLabel offset:5 ] install];

    consTextView = consbg.addTextView;
    consTextView.font = [Fonts regular:15];
    consTextView.editable = YES;
    consTextView.delegate = self;
    consTextView.textColor = rgbHex(0x879AA8);
    consTextView.text = @"Type here...";
    consTextView.tag=0;
    consTextView.returnKeyType = UIReturnKeyDone;
    [[[[[[consTextView.layoutMaker leftParent:5] rightParent:5] topParent:0]bottomParent:0] heightEq:80] install];


    //Advice to Management
    UILabel *adviceLabel = contentView.addLabel;
    adviceLabel.text = @"Advice to Management";
    adviceLabel.textColor = rgbHex(0x4a4a4a);
    adviceLabel.font = [Fonts regular:14];
    [[[[adviceLabel.layoutMaker leftParent:0] below:consTextView offset:10] rightParent:0]install];


    UIView *advicebg = contentView.addView;
    advicebg.backgroundColor = rgbHex(0xf8f8f8);
    advicebg.layer.cornerRadius = 3;
    [[[[advicebg.layoutMaker leftParent:0] rightParent:0] below:adviceLabel offset:5 ] install];

    adviceTextView = advicebg.addTextView;
    adviceTextView.font = [Fonts regular:15];
    adviceTextView.editable = YES;
    adviceTextView.delegate = self;
    adviceTextView.textColor = rgbHex(0x879AA8);
    adviceTextView.text = @"Type here...";
    adviceTextView.tag=0;
    adviceTextView.returnKeyType = UIReturnKeyDone;
    adviceTextView.contentInset = UIEdgeInsetsMake(3, 0, 3, 0);
    [[[[[[adviceTextView.layoutMaker leftParent:5] rightParent:5] topParent:0]bottomParent:0] heightEq:45] install];


    recommendsBtn = contentView.addButton;
    recommendsBtn.titleLabel.font = [Fonts regular:14];
    [recommendsBtn setTitleColor:rgbHex(0x4a4a4a) forState:UIControlStateNormal];
    [recommendsBtn setTitle:@"Recommends" forState:UIControlStateNormal];
    [recommendsBtn setImage:[UIImage imageNamed:@"checkbox"] forState:UIControlStateNormal];
    [recommendsBtn setImage:[UIImage imageNamed:@"checkbox_on"] forState:UIControlStateSelected];
    recommendsBtn.titleEdgeInsets = UIEdgeInsetsMake(0.0,5, 0.0, 0);
    recommendsBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [[[[recommendsBtn.layoutMaker leftParent:0]below:advicebg offset:10] widthEq:buttonWidth] install];
    [recommendsBtn onClick:self action:@selector(selectChanged:)];


    approveBtn = contentView.addButton;
    approveBtn.titleLabel.font = [Fonts regular:14];
    [approveBtn setTitleColor:rgbHex(0x4a4a4a) forState:UIControlStateNormal];
    [approveBtn setTitle:@"Approve of CEO" forState:UIControlStateNormal];
    [approveBtn setImage:[UIImage imageNamed:@"checkbox"] forState:UIControlStateNormal];
    [approveBtn setImage:[UIImage imageNamed:@"checkbox_on"] forState:UIControlStateSelected];
    approveBtn.titleEdgeInsets = UIEdgeInsetsMake(0.0,5, 0.0, 0);
    approveBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [[[[approveBtn.layoutMaker toRightOf:recommendsBtn offset:0]below:advicebg offset:10] widthEq:buttonWidth] install];
    [approveBtn onClick:self action:@selector(selectChanged:)];


    UILabel *tipsLabel = contentView.addLabel;
    tipsLabel.text = @"Your review is completely anonymous";
    tipsLabel.textColor = rgbHex(0x787878);
    tipsLabel.font = [Fonts regular:11];
    [[[tipsLabel.layoutMaker below:recommendsBtn offset:10] centerXParent:0] install];


    submitBtn = contentView.addButton;
    submitBtn.backgroundColor =Colors.textDisabled;
    [submitBtn addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    submitBtn.titleLabel.font = [Fonts regular:15];
    [submitBtn setTitle:@"Submit" forState:UIControlStateNormal];
    [[[[[[submitBtn.layoutMaker leftParent:0] rightParent:0] below:tipsLabel offset:10] heightEq:44] bottomParent:-edge] install];


    [contentView.layoutUpdate.bottom.greaterThanOrEqualTo(submitBtn) install];
}

/**
 current employee button and former employee click event
 Only one button can be selected for two buttons

 @param button Current response button
 */
-(void)employeeChange:(UIButton*)button{
    UIButton *anotherBtn = ((UIButton*)button.argObject);
    anotherBtn.selected=NO;
    button.selected = !button.selected;
    
}

/**
 
 recommends button and approve button click event
 toggle selected state

 @param button Current response button
 */
-(void)selectChanged:(UIButton*)button{
    button.selected = !button.selected;
}


/**
 submit button click event
 Submit data to the server, add a comment
 */
-(void)submitBtnClick{
    [self.view endEditing:YES];
    [self showLoading];
    [Proto addCompanyComment:self.dsoId reviewTitle:[self text:reviewTitleTextView]
                        pros:[self text:prosTextView] cons:[self text:consTextView] advice:[self text:adviceTextView]
           isCurrentEmployee:currentEmployeeBtn.isSelected isFormerEmployee:formerEmployeeBtn.isSelected isRecommend:recommendsBtn.isSelected isApprove:approveBtn.isSelected rating:starRateView.currentScore completed:^(BOOL success, NSString *msg) {
        [self hideLoading];
        [self Den_showAlertWithTitle:success?@"Submit Successful":msg message:nil appearanceProcess:^(DenAlertController * _Nonnull alertMaker) {
                alertMaker.addActionCancelTitle(@"OK");
            } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, DenAlertController * _Nonnull alertSelf) {
                if (success) {
                    [super dismiss];
                    if(self.addReviewSuccessCallbak){
                        self.addReviewSuccessCallbak();
                    }
                }
            }
         ];
    }];
}


/**
 UITextViewDelegate
 用于实现默认提示语功能
 Used to implement the default prompt function

 @param textView UITextView
 @return default YES
 */
- (BOOL)textViewShouldBeginEditing:(UITextView*)textView {
    if (textView.tag==0) {
        textView.text = @"";
        textView.textColor = rgbHex(0x4a4a4a);
        textView.tag=1;
    }
    return YES;
}

/**
 UITextViewDelegate
 用于实现默认提示语功能
 Used to implement the default prompt function
 
 @param textView UITextView
 */
- (void) textViewDidEndEditing:(UITextView*)textView {
    if(textView.text.length == 0){
        textView.textColor = rgbHex(0x879AA8);
        textView.text = @"Type here...";
        textView.tag=0;
    }
}

/**
 获得UITextView的真实内容
 Get the real content of UITextView

 @param textView UITextView
 @return text
 */
-(NSString*)text:(UITextView*)textView{
    if(textView.tag == 1){
        return textView.text;
    }else{
        return @"";
    }
}

/**
 Control maximum word limit

 @param textView UITextView
 @param range NSRange
 @param text text
 @return Can input return YES, no input can return NO
 */
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){
        [textView resignFirstResponder];
        return NO;
    }

    int maxLength = 100;
    if(textView == reviewTitleTextView || textView == adviceTextView){
        maxLength = 100;
    }else{
        maxLength = 300;
    }
    
    
    if (textView.text.length - range.length + text.length > maxLength && ![text isEqualToString:@""]){
        return  NO;
    }else{
        return YES;
    }
}



@end
