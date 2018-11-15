//
//  AddReviewViewController.m
//  dentist
//
//  Created by 孙兴国 on 2018/10/16.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "AddReviewViewController.h"
#import "Common.h"
#import "UIView+customed.h"
#import "XHStarRateView.h"
#import "Proto.h"

#define edge 16
@interface AddReviewViewController ()<UITextViewDelegate>
{
    UIScrollView *scrollView;
    UIView *vi;
    UIView *bgVi;
    UILabel *remainLab;
    UITextView *commentTextView;
    XHStarRateView *star;
    
    NSString *fullName;
}
@end

@implementation AddReviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self createNav];
    
    self.navigationController.navigationBarHidden = NO;
    UINavigationItem *item = self.navigationItem;
    item.title = @"ADD A REVIEW";
    item.leftBarButtonItem = [self navBarBack:self action:@selector(onBack:)];

    scrollView = [UIScrollView new];
    scrollView.contentSize = CGSizeMake(SCREENWIDTH, SCREENHEIGHT-NAVHEIGHT);
    [self.view addSubview:scrollView];
    [scrollView layoutFill];
    [[scrollView.layoutUpdate topParent:NAVHEIGHT]install];
    
    [self buildSubViews];

    [self buildAuthor];

    [self bulidTextVi];
    

    
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
        [self->scrollView setContentOffset:CGPointMake(0,150) animated:YES];
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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)onBack:(UIButton *)btn {
    [self.navigationController popViewControllerAnimated:YES];
}

//height：150
- (void)buildSubViews
{
    vi = [UIView new];
    vi.backgroundColor = [Colors bgColorNor];
    [scrollView addSubview:vi];
    [[[[vi.layoutMaker sizeEq:SCREENWIDTH h:150] leftParent:0] topParent:0] install];
    
    UILabel *rateLab = vi.addLabel;
    rateLab.font = [Fonts regular:12];
    rateLab.text = @"Rate the article";
    rateLab.textAlignment = NSTextAlignmentCenter;
    rateLab.textColor = Colors.textAlternate;
    [[[[rateLab.layoutMaker sizeEq:100 h:20] leftParent:SCREENWIDTH/2-50] topParent:18] install];
    
    UILabel *noticLab = vi.addLabel;
    noticLab.font = [Fonts regular:14];
    noticLab.textColor = [UIColor blackColor];
    noticLab.text = @"Preventing damage to tooth enamel";
    noticLab.textAlignment = NSTextAlignmentCenter;
    [[[noticLab.layoutMaker sizeEq:SCREENWIDTH h:20] below:rateLab offset:18] install];
    
    UILabel *timeLab = vi.addLabel;
    timeLab.font = [Fonts regular:14];
    timeLab.textColor = Colors.textMain;
    timeLab.text = @"August 2018";
    timeLab.textAlignment = NSTextAlignmentCenter;
    [[[timeLab.layoutMaker sizeEq:SCREENWIDTH h:20] below:noticLab offset:0] install];
    
    star = [[XHStarRateView alloc] initWithFrame:CGRectMake(SCREENWIDTH/2-80, 105, 160, 30)];
    star.isAnimation = NO;
    star.rateStyle = HalfStar;
    star.tag = 1;
    [vi addSubview:star];

}

//height：48
- (void)buildAuthor
{
    bgVi = [UIView new];
    bgVi.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:bgVi];
    [[[[bgVi.layoutMaker sizeEq:SCREENWIDTH h:48] below:vi offset:0] leftParent:0] install];
    
    UIImageView *headerImg = [UIImageView new];
    [bgVi addSubview:headerImg];
    [[[[headerImg.layoutMaker sizeEq:32 h:32] leftParent:edge] centerYParent:0] install];
    headerImg.layer.cornerRadius = 16;
    headerImg.layer.masksToBounds = YES;
    
    
    
    UILabel *nameLabel = [bgVi addLabel];
    nameLabel.font = [Fonts semiBold:12];
    [[[[nameLabel.layoutMaker toRightOf:headerImg offset:edge] topParent:edge] heightEq:20] install];
 
    UILabel *lineLab = [bgVi addLabel];
    lineLab.backgroundColor = Colors.cellLineColor;
    [[[[lineLab.layoutMaker sizeEq:SCREENWIDTH h:1] topParent:47] leftParent:0] install];
    
    

    backTask(^{
        UserInfo *userInfo = [Proto lastUserInfo];
        if(!userInfo.fullName){
            userInfo = [Proto getProfileInfo];
        }
        
        foreTask(^{
            fullName = userInfo.fullName;
            
            [headerImg loadUrl:userInfo.photo_url placeholderImage:@"user_img"];
            
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"Writing review as %@" ,userInfo.fullName?userInfo.fullName:@""]];
            [str addAttribute:NSForegroundColorAttributeName value:Colors.textAlternate range:NSMakeRange(0,18)];
            [str addAttribute:NSForegroundColorAttributeName value:Colors.textMain range:NSMakeRange(19,str.length - 19)];
            nameLabel.attributedText = str;
        });
    });
}

- (void)bulidTextVi
{
    UIView *textVi = [UIView new];
    textVi.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:textVi];
    [[[[textVi.layoutMaker sizeEq:SCREENWIDTH h:SCREENHEIGHT-NAVHEIGHT-150-48] below:bgVi offset:0] leftParent:0] install];

    UILabel *reLabel = [textVi addLabel];
    reLabel.font = [Fonts semiBold:12];
    reLabel.text = @"Write a brief review";
    reLabel.textColor = Colors.textAlternate;
    [[[[reLabel.layoutMaker leftParent:edge] topParent:18] heightEq:20] install];

    
    commentTextView = [textVi addTextView];
    commentTextView.font = [Fonts regular:15];
    commentTextView.editable = YES;
    commentTextView.delegate = self;
    commentTextView.returnKeyType = UIReturnKeyDone;
    [[[[[commentTextView.layoutMaker leftParent:edge] rightParent:-edge] below:reLabel offset:edge] bottomParent:-130 ]install];
    
    remainLab = [textVi addLabel];
    remainLab.font = [Fonts semiBold:12];
    remainLab.text = @"500 characters remaining";
    remainLab.textColor = Colors.textDisabled;
    [[[[remainLab.layoutMaker rightParent:-edge] below:commentTextView offset:5] heightEq:20] install];
    
    UILabel *lineLab = [textVi addLabel];
    lineLab.backgroundColor = Colors.cellLineColor;
    [[[[lineLab.layoutMaker sizeEq:SCREENWIDTH h:1] below:remainLab offset:10] leftParent:0] install];
    
    UIButton *submit = [UIButton new];
    [textVi addSubview:submit];
    submit.backgroundColor =Colors.textDisabled;
    [submit addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    submit.titleLabel.font = [Fonts regular:15];
    [submit setTitle:@"Submit Review" forState:UIControlStateNormal];
    [[[[[submit.layoutMaker leftParent:22] rightParent:-22] below:lineLab offset:30] heightEq:40] install];


    
    

}

- (void)submitBtnClick{
    
    NSString *commentText = commentTextView.text;
    NSString *commentRating = [NSString stringWithFormat:@"%f" ,star.currentScore];
    
    [self showIndicator];
    backTask(^() {
        HttpResult *r = [Proto addComment:getLastAccount() contentId:self.contentId commentText:commentText commentRating:commentRating fullName:fullName];
        foreTask(^() {
            [self hideIndicator];
            
            [self Den_showAlertWithTitle:r.OK?@"Submit Successful":r.msg message:nil appearanceProcess:^(DenAlertController * _Nonnull alertMaker) {
                    alertMaker.addActionCancelTitle(@"OK");
                } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, DenAlertController * _Nonnull alertSelf) {
                        if ([action.title isEqualToString:@"OK"] && r.OK) {
                            if(self.addReviewSuccessCallbak){
                                self.addReviewSuccessCallbak();
                            }
                            [self.navigationController popViewControllerAnimated:YES];
                        }
                    }
             ];
        });
    });
    
    return;

}

- (void)textViewDidChange:(UITextView *)textView
{
    long leftLength = 500 - textView.text.length;
    if (leftLength <= 0) {
        leftLength = 0;
    }
    remainLab.text = [NSString stringWithFormat:@"%lu characters remaining", leftLength];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){
        
        [textView resignFirstResponder];
        return NO;
    }
    if (textView.text.length - range.length + text.length > 500 && ![text isEqualToString:@""]){
        return  NO;
     }else{
        return YES;
     }
    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
