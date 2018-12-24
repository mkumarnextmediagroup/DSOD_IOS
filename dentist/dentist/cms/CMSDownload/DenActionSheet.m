//
//  DenActionSheet.m
//  mayc
//
//  Created by 孙兴国 on 2018/9/27.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "DenActionSheet.h"
#import "AppDelegate.h"
#import "UIViewExt.h"
#import "Common.h"

#define labelTextColor [UIColor blackColor] // 文本的字体颜色
#define labelHeight 50 // 每个按钮的高度

#define titleFont [Fonts regular:12] // 标题字体大小
#define titleTextColor rgbHex(0x9b9b9b) // 标题颜色

#define LastButtonDistans 10    // 与最后一个按钮的距离

@implementation DenActionSheet

- (instancetype)initWithDelegate:(id)delegate title:(NSString *)title cancelButton:(NSString *)cancelButton imageArr:(NSArray *)imageArr otherTitle:(NSString *)otherTitle, ...
{
    
    self = [super init];
    if (self) {
        self.delgate = delegate;
        
        // 装其他参数的数组
        NSMutableArray *args = [NSMutableArray array];
        // 定义一个指向参数的列表指针
        va_list params;
        va_start(params, otherTitle);
        if (otherTitle) {
            // 把第一个参数添加到数组里面
            [args addObject:otherTitle];
            
            id arg;
            // va_list 指向下一个地址
            while ((arg = va_arg(params, id))) { if (arg) { [args addObject:arg]; } }
            // 置空
            va_end(params);
        }
        self.titleNameArr = [NSMutableArray array];
        self.imageArr = imageArr;
        if (title != nil) {
             [self.titleNameArr addObject:title];
        }
        
        [self.titleNameArr addObjectsFromArray:args];
        
        if (cancelButton != nil) {
            [self.titleNameArr addObject:cancelButton];
        }
        
        if (title.length != 0) {
            _titleName = title;
        }
        [self _initSubViews:cancelButton];
    }
    
    return self;
}

-(void)updateActionTitle:(NSArray *)titlearr
{
    for (UIView *view in _parentView.subviews) {
        if (view.tag>=100 && [view isKindOfClass:[UILabel class]]) {
            UILabel *label=(UILabel *)view;
            if (titlearr.count>(label.tag-100)) {
                label.text=titlearr[label.tag-100];
            }
        }
    }
}

- (void)_initSubViews:(NSString *)cancelBtn
{
    self.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
    self.backgroundColor = [UIColor blackColor];
    self.alpha = .6;
    
    // 父视图高
    CGFloat parentViewHeight = self.titleNameArr.count * labelHeight + self.titleNameArr.count;
    
    // 创建装Label的父视图
    _parentView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT, SCREENWIDTH, parentViewHeight)];
    _parentView.backgroundColor = [UIColor whiteColor];
    
    // 创建Label
    for (NSInteger i = 0; i < self.titleNameArr.count; i++) {
        UILabel *myLabel = [_parentView addLabel];
        [[[[myLabel.layoutMaker leftParent:18] topParent:i * (labelHeight+1)] sizeEq:SCREENWIDTH - 18 h:labelHeight] install];
        myLabel.userInteractionEnabled = YES;
        myLabel.tag = 100+i;
        myLabel.text = self.titleNameArr[i];
        myLabel.textAlignment = NSTextAlignmentLeft;
        myLabel.font = [Fonts regular:12];
        myLabel.textColor = labelTextColor;
        
        UILabel *line = [_parentView addLabel];
        [[[[line.layoutMaker sizeEq:SCREENWIDTH h:1] topParent:i * labelHeight] leftParent:self.linePaddingLeft] install];
        line.backgroundColor = Colors.cellLineColor;
        
        UIImageView *iconImg = [_parentView addImageView];
        [iconImg setImage:[UIImage imageNamed:self.imageArr[i]]];
        [[[[iconImg.layoutMaker sizeEq:70 h:labelHeight] leftParent:SCREENWIDTH-70] topParent:i * (labelHeight+1)] install];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [myLabel addGestureRecognizer:tap];
        [_parentView addSubview:myLabel];
        
        // 如果有标题的话
        if (self.titleName.length > 0) {
            if (i == 0) {
                myLabel.font = titleFont;
                myLabel.textColor = titleTextColor;
                
            }
        }
        
        if (i == self.titleNameArr.count - 1 && cancelBtn != nil) {
            myLabel.top += LastButtonDistans*2;
        }
    }
}

#pragma mark - tapAction
- (void)tapAction:(UIGestureRecognizer *)gesture {
    UILabel *label = (UILabel *)gesture.view;
    if (self.delgate && [_delgate respondsToSelector:@selector(myActionSheet:parentView:subLabel:index:)]) {
        [self.delgate myActionSheet:self parentView:_parentView subLabel:label index:(label.tag-100)];
    }
    [self hiddenAnimation];
}

- (void)show
{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate.window.rootViewController.view addSubview:self];
    
    [UIView animateWithDuration:.35 animations:^{
        
        self->_parentView.top = SCREENHEIGHT - self->_parentView.height;
    }];
    [delegate.window.rootViewController.view addSubview:_parentView];
}

- (void)show:(UIView *)superview
{
    if (superview) {
        [superview addSubview:self];
        
        [UIView animateWithDuration:.35 animations:^{
            
            self->_parentView.top = SCREENHEIGHT - self->_parentView.height;
        }];
        [superview addSubview:_parentView];
    }else{
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [delegate.window.rootViewController.view addSubview:self];
        
        [UIView animateWithDuration:.35 animations:^{
            
            self->_parentView.top = SCREENHEIGHT - self->_parentView.height;
        }];
        [delegate.window.rootViewController.view addSubview:_parentView];
    }
    
}

- (void)hiddenAnimation
{
    [UIView animateWithDuration:.35 animations:^{
        self->_parentView.top = SCREENHEIGHT;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self hiddenAnimation];
}

@end
