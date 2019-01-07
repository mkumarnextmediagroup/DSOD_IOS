//
//  TextFieldImageView.m
//  dentist
//
//  Created by feng zhenrong on 2018/12/20.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "TextFieldImageView.h"
#import "Fonts.h"
#import "Common.h"

@implementation TextFieldImageView

- (instancetype)init {
    self = [super init];
    //设置圆角边框
    self.layer.cornerRadius = 3;
    
    self.layer.masksToBounds = YES;
    
    //设置边框及边框颜色
    self.layer.borderWidth = 1;
    
    self.layer.borderColor =rgb255(214, 219, 223).CGColor;
    Padding *p = self.padding;
    p.left = 16;
    p.right = 16;
    p.top = 5;
    p.bottom = 5;
    self.layoutParam.height = 78;
    
    self.backgroundColor = UIColor.whiteColor;

    _edit = self.addEditRaw;
    _iconView = self.addImageView;
    
    _edit.font = [Fonts regular:15];
    _edit.tag = 145;
    [_edit textColorBlack];
    [[[[_iconView.layoutMaker sizeEq:16 h:16] rightParent:-p.right] centerYParent:0] install];
    [[[[[_edit.layoutMaker topParent:p.top] leftParent:p.left] bottomParent:-p.bottom] toLeftOf:_iconView offset:10] install];
    
    
    return self;
}

- (void)resetLayout {
    Padding *p = self.padding;
    [[[[_iconView.layoutRemaker sizeEq:16 h:16] rightParent:-p.right] centerYParent:0] install];
    [[[[[_edit.layoutRemaker leftParent:p.left] topParent:p.top] bottomParent:-p.bottom] toLeftOf:_iconView offset:10] install];
    
}

-(void)themeError{
    //设置边框及边框颜色
    self.layer.borderWidth = 1;
    
    self.layer.borderColor =Colors.borderError.CGColor;
}

-(void)themeNormal{
    //设置边框及边框颜色
    self.layer.borderWidth = 1;
    
    self.layer.borderColor =rgb255(214, 219, 223).CGColor;
}

@end
