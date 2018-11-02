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
#import "Proto.h"
#import "IdName.h"

#define DSFilterHeight (SCREENHEIGHT-NAVHEIGHT)
@interface DentistFilterView()
@property (nonatomic,strong) NSArray<IdName *> *categoryArray;
@property (nonatomic,strong) NSArray<IdName *> *contentArray;
@end

@implementation DentistFilterView

-(instancetype)init
{
    self = [super init];
    
    if (self)
    {
        self.frame=CGRectMake(0, SCREENHEIGHT, SCREENWIDTH, DSFilterHeight);
        self.backgroundColor =[UIColor whiteColor];
        _categorytext=nil;//@"DSOs";
        _typetext=nil;//@"Videos";
//        backTask(^() {
//            self.contentArray=[Proto queryContentTypes];
//            self.categoryArray=[Proto queryCategoryTypes];
//            foreTask(^() {
//
//            });
//        });
        
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    UILabel *titleLabel=[self addLabel];
    titleLabel.font = [Fonts semiBold:15];
    titleLabel.textColor=Colors.textContent;
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
    categoryLabel.font = [Fonts regular:12];
    categoryLabel.textColor=Colors.textAlternate;
    categoryLabel.text=localStr(@"Category");
    [[[[[categoryLabel.layoutMaker leftParent:20] below:titleLabel offset:30] rightParent:-10] heightEq:20] install];
    UITextField *categoryTextField=self.addEditRounded;
    categoryTextField.delegate = self;
    categoryTextField.hint = localStr(@"");
    categoryTextField.tag=1;
    [categoryTextField returnNext];
    categoryTextField.font = [Fonts regular:15];
    categoryTextField.textColor=rgb255(0, 0, 0);
    [categoryTextField setValue:rgb255(0, 0, 0) forKeyPath:@"_placeholderLabel.textColor"];
    [[[[[categoryTextField.layoutMaker leftParent:20] below:categoryLabel offset:10] rightParent:-20] heightEq:44] install];
    UIImage *img=[UIImage imageNamed:@"arrow"];
    UIImageView *selectimageview=[UIImageView new];
    [categoryTextField addSubview:selectimageview];
    selectimageview.image=[UIImage imageWithCGImage:img.CGImage scale:1.0 orientation:UIImageOrientationRight];
    [[[[[selectimageview.layoutMaker rightParent:-14] topParent:14] heightEq:16] widthEq:16] install];
    
    //type
    UILabel *typeLabel=[self addLabel];
    typeLabel.font = [Fonts regular:12];
    typeLabel.textColor=Colors.textAlternate;
    typeLabel.text=localStr(@"Content Type");
    [[[[[typeLabel.layoutMaker leftParent:20] below:categoryTextField offset:20] rightParent:-10] heightEq:20] install];
    UITextField *typeTextField=self.addEditRounded;
    typeTextField.delegate = self;
    typeTextField.hint = localStr(@"");
    typeTextField.tag=2;
    [typeTextField returnDone];
    typeTextField.font = [Fonts regular:15];
    typeTextField.textColor=rgb255(0, 0, 0);
    [typeTextField setValue:rgb255(0, 0, 0) forKeyPath:@"_placeholderLabel.textColor"];
    [[[[[typeTextField.layoutMaker leftParent:20] below:typeLabel offset:10] rightParent:-20] heightEq:44] install];
    
    UIImageView *selectimageview2=[UIImageView new];
    [typeTextField addSubview:selectimageview2];
    selectimageview2.image=[UIImage imageWithCGImage:img.CGImage scale:1.0 orientation:UIImageOrientationRight];
    [[[[[selectimageview2.layoutMaker rightParent:-14] topParent:14] heightEq:16] widthEq:16] install];
    
    UIButton *updateButton = self.addButton;
    [updateButton styleWhite];
    [updateButton title:localStr(@"Update")];
    [updateButton styleSecondary];
    [[[[[updateButton.layoutMaker leftParent:20] bottomParent:-25] rightParent:-20] heightEq:40] install];
    [updateButton onClick:self action:@selector(clickUpdate:)];
    
    UILabel *clearLabel=[self addLabel];
    clearLabel.font = [Fonts regular:15];
    clearLabel.textColor=Colors.textDisabled;
    clearLabel.text=localStr(@"Clear all");
    clearLabel.textAlignment=NSTextAlignmentCenter;
    [[[[[clearLabel.layoutMaker leftParent:20] above:updateButton offset:-20] rightParent:-20] heightEq:20] install];
    UIButton *clearbutton=[self addButton];
     [[[[[clearbutton.layoutMaker leftParent:20] above:updateButton offset:-20] rightParent:-20] heightEq:20] install];
    [clearbutton addTarget:self action:@selector(clearAction) forControlEvents:UIControlEventTouchUpInside];
//    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clearAction)];
//    [clearLabel addGestureRecognizer:tap];
}

-(void)clearAction
{
    _categorytext=nil;
    _typetext=nil;
    [UIView animateWithDuration:0.5 animations:^{
        //将view.frame 设置在屏幕下方
        self.frame=CGRectMake(0, SCREENHEIGHT, SCREENWIDTH, DSFilterHeight);
    } completion:^(BOOL finished) {
        if (self.selectBlock) {
            self.selectBlock(self.categorytext,self.typetext);
        }
        [self removeFromSuperview];
    }];
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
//弹出
-(void)show:(DentistFilterViewCloseActionBlock)closeActionBlock select:(DentistFilterViewSelectActionBlock)selectActionBlock;
{
    self.closeBlock = closeActionBlock;
    self.selectBlock = selectActionBlock;
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
    _categorytext=nil;
    _typetext=nil;
    [UIView animateWithDuration:0.5 animations:^{
        //将view.frame 设置在屏幕下方
        self.frame=CGRectMake(0, SCREENHEIGHT, SCREENWIDTH, DSFilterHeight);
    } completion:^(BOOL finished) {
        if (self.closeBlock) {
            self.closeBlock(self.categorytext,self.typetext);
        }
        [self removeFromSuperview];
    }];
}

-(void)clickUpdate:(UIButton *)sender
{
    [UIView animateWithDuration:0.5 animations:^{
        //将view.frame 设置在屏幕下方
        self.frame=CGRectMake(0, SCREENHEIGHT, SCREENWIDTH, DSFilterHeight);
    } completion:^(BOOL finished) {
        if (self.selectBlock) {
            self.selectBlock(self.categorytext,self.typetext);
        }
        [self removeFromSuperview];
    }];
}
#pragma mark textfielddelegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField.tag==1) {
        DentistPickerView *picker = [[DentistPickerView alloc]init];
        
        picker.leftTitle=localStr(@"Category");
        picker.righTtitle=localStr(@"Cancel");
        [picker show:^(NSString *result,NSString *resultname) {
            
        } rightAction:^(NSString *result,NSString *resultname) {
            
        } selectAction:^(NSString *result,NSString *resultname) {
            textField.text=resultname;
            self.categorytext=result;
        }];
        [Proto queryCategoryTypes:^(NSArray<IdName *> *array) {
            if (!self.categoryArray) {
                self.categoryArray = array;
            }
            foreTask(^() {
                picker.arrayDic=self.categoryArray;
            });
        }];
        
    }else{
        DentistPickerView *picker = [[DentistPickerView alloc]init];
        picker.arrayDic=self.contentArray;
        picker.leftTitle=localStr(@"Content Type");
        picker.righTtitle=localStr(@"Cancel");
        [picker show:^(NSString *result,NSString *resultname) {
            
        } rightAction:^(NSString *result,NSString *resultname) {
            
        } selectAction:^(NSString *result,NSString *resultname) {
            textField.text=resultname;
            self.typetext=result;
        }];
        [Proto queryContentTypes:^(NSArray<IdName *> *array) {
            if (!self.contentArray) {
                self.contentArray = array;
            }
            foreTask(^() {
                picker.arrayDic=self.contentArray;
            });
        }];
    }
    return NO;
}

@end
