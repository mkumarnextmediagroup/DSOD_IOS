//
//  DentistFilterView.m
//  dentist
//
//  Created by cstLBY on 2018/9/19.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "DentistFilterView.h"
#import "Common.h"
#import "AppDelegate.h"
#import "DentistPickerView.h"

#define DSFilterHeight (SCREENHEIGHT-NAVHEIGHT)

@implementation DentistFilterView

-(instancetype)init
{
    self = [super init];
    
    if (self)
    {
        self.frame=CGRectMake(0, SCREENHEIGHT, SCREENWIDTH, DSFilterHeight);
        self.backgroundColor =[UIColor whiteColor];
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    UILabel *titleLabel=[self addLabel];
    titleLabel.font = [Fonts regular:15];
    [titleLabel textColorMain];
    titleLabel.text=localStr(@"Filter");
    titleLabel.textAlignment=NSTextAlignmentCenter;
    [[[[[titleLabel.layoutMaker topParent:20] leftParent:20] rightParent:-20] heightEq:25] install];
    //关闭按钮
    UIButton *closeButton = [self addButton];
    [closeButton setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [[[[closeButton.layoutMaker topParent:20] rightParent:-10] sizeEq:24 h:24] install];
    [closeButton onClick:self action:@selector(clickClose:)];
    
    //category
    UILabel *categoryLabel=[self addLabel];
    categoryLabel.font = [Fonts regular:15];
    categoryLabel.textColor=rgb255(155, 155, 155);
    categoryLabel.text=localStr(@"Category");
    [[[[[categoryLabel.layoutMaker leftParent:20] below:titleLabel offset:30] rightParent:-10] heightEq:20] install];
    UITextField *categoryTextField=self.addEditRounded;
    categoryTextField.delegate = self;
    categoryTextField.hint = localStr(@"DSOs");
    categoryTextField.tag=1;
    [categoryTextField returnNext];
    categoryTextField.textColor=rgb255(0, 0, 0);
    [[[[[categoryTextField.layoutMaker leftParent:20] below:categoryLabel offset:10] rightParent:-20] heightEq:40] install];
    
    //type
    UILabel *typeLabel=[self addLabel];
    typeLabel.font = [Fonts regular:15];
    typeLabel.textColor=rgb255(155, 155, 155);
    typeLabel.text=localStr(@"Content Type");
    [[[[[typeLabel.layoutMaker leftParent:20] below:categoryTextField offset:20] rightParent:-10] heightEq:20] install];
    UITextField *typeTextField=self.addEditRounded;
    typeTextField.delegate = self;
    typeTextField.hint = localStr(@"Videos");
    typeTextField.tag=2;
    [typeTextField returnDone];
    categoryTextField.textColor=rgb255(0, 0, 0);
    [[[[[typeTextField.layoutMaker leftParent:20] below:typeLabel offset:10] rightParent:-20] heightEq:40] install];
}

//弹出
-(void)show
{
    AppDelegate * appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    [appDelegate.window.rootViewController.view addSubview:self];
    [UIView animateWithDuration:0.5 animations:^{
        //将view.frame 设置在屏幕上方
        self.frame=CGRectMake(0, NAVHEIGHT, SCREENWIDTH, DSFilterHeight);
    }];
}
//弹出
-(void)show:(DentistFilterViewCloseActionBlock)closeActionBlock
{
    self.closeBlock = closeActionBlock;
    AppDelegate * appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    [appDelegate.window.rootViewController.view addSubview:self];
    [UIView animateWithDuration:0.5 animations:^{
        //将view.frame 设置在屏幕上方
        self.frame=CGRectMake(0, NAVHEIGHT, SCREENWIDTH, DSFilterHeight);
    }];
}
#pragma mark 关闭刷选页面
-(void)clickClose:(UIButton *)sender
{
    [UIView animateWithDuration:0.5 animations:^{
        //将view.frame 设置在屏幕下方
        self.frame=CGRectMake(0, SCREENHEIGHT, SCREENWIDTH, DSFilterHeight);
    } completion:^(BOOL finished) {
        if (self.closeBlock) {
            self.closeBlock();
        }
        [self removeFromSuperview];
    }];
}
#pragma mark textfielddelegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField.tag==1) {
        DentistPickerView *picker = [[DentistPickerView alloc]init];
        picker.array = @[@"DSOs",@"DSOs1",@"DSOs2",@"DSOs3",@"DSOs4",@"DSOs5",@"DSOs6"];
        picker.leftTitle=localStr(@"Category");
        picker.righTtitle=localStr(@"Cancel");
        [picker show:^(NSString *result) {
            
        } rightAction:^(NSString *result) {
            
        } selectAction:^(NSString *result) {
            textField.text=result;
        }];
    }else{
        DentistPickerView *picker = [[DentistPickerView alloc]init];
        picker.array = @[@"Videos",@"Videos1",@"Videos2",@"Videos3",@"Videos4",@"Videos5",@"Videos6"];
        picker.leftTitle=localStr(@"Content");
        picker.righTtitle=localStr(@"Cancel");
        [picker show:^(NSString *result) {
            
        } rightAction:^(NSString *result) {
            
        } selectAction:^(NSString *result) {
            textField.text=result;
        }];
    }
    return NO;
}

@end
