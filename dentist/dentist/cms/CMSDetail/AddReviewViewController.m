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

#define edge 16
@interface AddReviewViewController ()<UITextViewDelegate>
{
    UIView *vi;
    UIView *bgVi;
    UILabel *remainLab;
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

    
    [self buildSubViews];
    
    [self buildAuthor];
    
    [self bulidTextVi];
    // Do any additional setup after loading the view.
}

- (void)onBack:(UIButton *)btn {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)buildSubViews
{
    vi = [UIView new];
    vi.backgroundColor = [Colors bgColorNor];
    [self.view addSubview:vi];
    [[[[vi.layoutMaker sizeEq:SCREENWIDTH h:150] leftParent:0] topParent:NAVHEIGHT] install];
    
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
    
    XHStarRateView *star = [[XHStarRateView alloc] initWithFrame:CGRectMake(SCREENWIDTH/2-80, 105, 160, 30)];
    star.isAnimation = NO;
    star.rateStyle = HalfStar;
    star.tag = 1;
    [vi addSubview:star];
//    [[[star.layoutMaker below:timeLab offset:10] leftParent:SCREENWIDTH/2-80] install];
}

- (void)buildAuthor
{
    bgVi = [UIView new];
    bgVi.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgVi];
    [[[[bgVi.layoutMaker sizeEq:SCREENWIDTH h:48] below:vi offset:0] leftParent:0] install];
    
    UIImageView *headerImg = [UIImageView new];
    [bgVi addSubview:headerImg];
    [[[[headerImg.layoutMaker sizeEq:32 h:32] leftParent:edge] centerYParent:0] install];
    [headerImg loadUrl:@"http://app800.cn/i/p.png" placeholderImage:@"user_img"];
    headerImg.layer.cornerRadius = 16;
    headerImg.layer.masksToBounds = YES;
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"Writing review as Matt Murdock"];
    [str addAttribute:NSForegroundColorAttributeName value:Colors.textAlternate range:NSMakeRange(0,18)];
    [str addAttribute:NSForegroundColorAttributeName value:Colors.textMain range:NSMakeRange(19,str.length - 19)];
    
    UILabel *nameLabel = [bgVi addLabel];
    nameLabel.font = [Fonts semiBold:12];
    nameLabel.attributedText = str;
    [[[[nameLabel.layoutMaker toRightOf:headerImg offset:edge] topParent:edge] heightEq:20] install];
 
    UILabel *lineLab = [bgVi addLabel];
    lineLab.backgroundColor = Colors.cellLineColor;
    [[[[lineLab.layoutMaker sizeEq:SCREENWIDTH h:1] topParent:47] leftParent:0] install];
}

- (void)bulidTextVi
{
    UIView *textVi = [UIView new];
    textVi.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:textVi];
    [[[[textVi.layoutMaker sizeEq:SCREENWIDTH h:SCREENHEIGHT-310] below:vi offset:0] leftParent:0] install];

    UILabel *reLabel = [textVi addLabel];
    reLabel.font = [Fonts semiBold:12];
    reLabel.text = @"Write a brief review";
    reLabel.textColor = Colors.textAlternate;
    [[[[reLabel.layoutMaker leftParent:edge] topParent:18] heightEq:20] install];

    UITextView *textView = [textVi addTextView];
    textView.font = [Fonts regular:15];
    textView.editable = YES;
    textView.delegate = self;
    textView.returnKeyType = UIReturnKeyDone;
    [[[[[textView.layoutMaker sizeEq:SCREENWIDTH h:SCREENHEIGHT-330] leftParent:edge] rightParent:-edge] below:reLabel offset:edge] install];
    
    remainLab = [textVi addLabel];
    remainLab.font = [Fonts semiBold:12];
    remainLab.text = @"500 characters remaining";
    remainLab.textColor = Colors.textDisabled;
    [[[[remainLab.layoutMaker rightParent:-edge] bottomParent:-edge] heightEq:20] install];

    UILabel *lineLab = [textVi addLabel];
    lineLab.backgroundColor = Colors.cellLineColor;
    [[[[lineLab.layoutMaker sizeEq:SCREENWIDTH h:1] bottomParent:-1] leftParent:0] install];

    
    
    
    UIButton *submit = [self.view addButton];
    submit.backgroundColor =Colors.textDisabled;
    [submit addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    submit.titleLabel.font = [Fonts regular:15];
    [submit setTitle:@"Submit Review" forState:UIControlStateNormal];
    [[[[[submit.layoutMaker leftParent:22] rightParent:-22] bottomParent:-28] heightEq:40] install];
}

- (void)submitBtnClick
{
    [self Den_showAlertWithTitle:@"Submit Successful" message:nil appearanceProcess:^(DenAlertController * _Nonnull alertMaker) {
        alertMaker.
        addActionCancelTitle(@"OK");
    } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, DenAlertController * _Nonnull alertSelf) {
        if ([action.title isEqualToString:@"OK"]) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
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
    if (range.location > 500)
    {
        return  NO;
     }else
     {
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
