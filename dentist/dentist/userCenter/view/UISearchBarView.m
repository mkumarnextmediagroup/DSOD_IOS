//
//  UISearchBarView.m
//  CSTMall
//
//  Created by cst on 15/8/26.
//  Copyright (c) 2015年 cst. All rights reserved.
//

#import "UISearchBarView.h"
#import "UIUtil.h"

@interface UISearchBarView()<UITextFieldDelegate>

@end

@implementation UISearchBarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self createSubViews];
        
        UILabel *line = [UILabel new];
        line.frame = CGRectMake(0, frame.size.height - 1, SCREENWIDTH, .5);
        line.backgroundColor = rgb255(200, 199, 204);
        [self addSubview:line];

    }
    return self;
}

- (void)createSubViews
{
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setImage:[UIImage imageNamed:@"searchIcon"] forState:UIControlStateNormal];
    searchBtn.frame = CGRectMake(0, 2, 36, 36);

    _textField = [[UITextField alloc] initWithFrame:CGRectMake(18, 10, SCREENWIDTH - 36, 36)];
    _textField.background = [UIImage imageNamed:@"searchBarBg"];
    _textField.placeholder = @"Search ...";
    _textField.delegate = self;
    _textField.returnKeyType = UIReturnKeySearch;
    _textField.tintColor = [UIColor blueColor];
//    _textField.enablesReturnKeyAutomatically = YES;
    _textField.font = [UIFont systemFontOfSize:15];
    [self addSubview:_textField];
    [_textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    _textField.leftView = searchBtn;
    _textField.leftViewMode = UITextFieldViewModeAlways;
    
    
}

- (void)textFieldDidChange:(UITextField *)textField
{
    NSString *temp = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    //看剩下的字符串的长度是否为零
    if ([temp length] != 0)
    {
        if ([self.delegate respondsToSelector:@selector(updateTheSearchText:)]) {
            [_delegate updateTheSearchText:temp];
        }
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"textFieldDidBeginEditing");
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_textField resignFirstResponder];
    return YES;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
