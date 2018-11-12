//
//  DentistPickerView.m
//  dentist
//
//  Created by cstLBY on 2018/9/19.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "DentistPickerView.h"
#import "Common.h"
#import "IdName.h"
#define DSPickBackColor [UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1]
#define DSSCREENWIDTH  [UIScreen mainScreen].bounds.size.width
#define DSSCREENHEIGHT [UIScreen mainScreen].bounds.size.height
#define DSPickHeight 250

@interface DentistPickerView()<UIPickerViewDelegate,UIPickerViewDataSource>
/** view */
@property (nonatomic,strong) UIView *backView;
/** view */
@property (nonatomic,strong) UIView *topView;
/** left button */
@property (nonatomic,strong) UIButton *leftBtn;
/** right button */
@property (nonatomic,strong) UIButton *rightBtn;

/** pickerView */
@property (nonatomic,strong) UIPickerView *pickerView;
/** srting */
@property (nonatomic,strong) NSString *result;
/** srting */
@property (nonatomic,strong) NSString *resultname;
@property (nonatomic,strong) UIActivityIndicatorView *iv;

@end
@implementation DentistPickerView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(0, 0, DSSCREENWIDTH, DSSCREENHEIGHT+DSPickHeight)];
    
    if (self)
    {
        self.backgroundColor =[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.4];
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.backView=[[UIView alloc] initWithFrame:CGRectMake(0, DSPickHeight, DSSCREENWIDTH, DSSCREENHEIGHT-DSPickHeight)];
    self.backView.backgroundColor=[UIColor clearColor];
    [self addSubview:self.backView];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(quit)];
    [self.backView addGestureRecognizer:tap];
    
    self.topView = [[UIView alloc]initWithFrame:CGRectMake(0, DSSCREENHEIGHT, DSSCREENWIDTH, DSPickHeight)];
    self.topView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.topView];
    
//    //为view上面的两个角做成圆角
//    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.topView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
//    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//    maskLayer.frame = self.topView.bounds;
//    maskLayer.path = maskPath.CGPath;
//    self.topView.layer.mask = maskLayer;
    CGSize strSize=CGSizeMake(MAXFLOAT, 40);
    NSDictionary *attr=@{NSFontAttributeName:[UIFont systemFontOfSize:13.0]};
    CGSize leftlableSize=CGSizeZero;
    CGSize rightlableSize=CGSizeZero;
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (self.leftTitle) {
        [self.leftBtn setTitle:self.leftTitle forState:UIControlStateNormal];
        leftlableSize=[self.leftTitle boundingRectWithSize:strSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size;
    }else{
        [self.leftBtn setTitle:@"" forState:UIControlStateNormal];
    }
    
    CGFloat leftbtnw=leftlableSize.width+30;
    [self.leftBtn setTitleColor:Colors.textAlternate forState:UIControlStateNormal];
    [self.leftBtn setFrame:CGRectMake(0, 5, leftbtnw, 40)];
    self.leftBtn.titleLabel.font=[Fonts regular:13];
    [self.leftBtn addTarget:self action:@selector(leftaction) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:self.leftBtn];
    
    self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightBtn.titleLabel.font=[Fonts semiBold:13];
    if (self.righTtitle) {
        [self.rightBtn setTitle:self.righTtitle forState:UIControlStateNormal];
        rightlableSize=[self.righTtitle boundingRectWithSize:strSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size;
    }else{
        [self.rightBtn setTitle:@"Cancel" forState:UIControlStateNormal];
    }
    CGFloat rightbtnw=rightlableSize.width+30;
    [self.rightBtn setTitleColor:Colors.textDisabled forState:UIControlStateNormal];
    [self.rightBtn setFrame:CGRectMake(DSSCREENWIDTH-rightbtnw, 5, rightbtnw, 40)];
    [self.rightBtn addTarget:self action:@selector(rightaction) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:self.rightBtn];
    
    UILabel *titlelb = [[UILabel alloc]initWithFrame:CGRectMake(leftbtnw+10, 0, DSSCREENWIDTH-(leftbtnw+rightbtnw)-20, 50)];
    titlelb.backgroundColor = [UIColor clearColor];
    titlelb.textAlignment = NSTextAlignmentCenter;
    titlelb.text = self.title;
    titlelb.font = [UIFont systemFontOfSize:20.0];
    [self.topView addSubview:titlelb];
    
    self.pickerView = [[UIPickerView alloc]init];
    [self.pickerView setFrame:CGRectMake(0, 50, DSSCREENWIDTH, DSPickHeight-50)];
    [self.pickerView setBackgroundColor:DSPickBackColor];
    [self.pickerView setDelegate:self];
    [self.pickerView setDataSource:self];
    [self.pickerView selectRow:0 inComponent:0 animated:YES];
    [self.topView addSubview:self.pickerView];
    
    if (self.iv == nil) {
        self.iv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        self.iv.tag = 998;
        [self.topView addSubview:self.iv];
        self.iv.backgroundColor = [UIColor clearColor];
        self.iv.hidesWhenStopped = YES;
        self.iv.center = self.center;
    }
    [self.topView bringSubviewToFront:self.iv];
    self.iv.hidden=YES;
    
}

-(void)setSelectRow:(NSInteger)selectRow
{
    _selectRow=selectRow;
    if (self.arrayDic && self.arrayDic.count>0)  {
        if (self.arrayDic.count>selectRow) {
            [self.pickerView selectRow:_selectRow inComponent:0 animated:YES];
        }
        
    }else{
        if (self.array.count>selectRow) {
            [self.pickerView selectRow:_selectRow inComponent:0 animated:YES];
        }
    }
    
}

//快速创建
+(instancetype)pickerView;
{
    return [[self alloc]init];
}

-(void)quit
{
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0;
        CGPoint point = self.center;
        point.y += DSPickHeight;
        self.center = point;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

//弹出
- (void)show
{
    [self showInView:[UIApplication sharedApplication].keyWindow];
}

-(void)show:(DentistPickerViewLeftActionBlock)leftActionBlock rightAction:(DentistPickerViewRightActionBlock)rightActionBlock selectAction:(DentistPickerViewdidSelectActionBlock)selectActionBlock
{
    self.leftBlock = leftActionBlock;
    self.rightBlock = rightActionBlock;
    self.selectBlock = selectActionBlock;
    [self showInView:[UIApplication sharedApplication].keyWindow];
}

- (void)showIndicator {
    [self.topView bringSubviewToFront:self.iv];
    self.iv.hidden = NO;
    [self.iv startAnimating];
}


- (void)hideIndicator {
    self.iv.hidden = YES;
    [self.iv stopAnimating];
}

//添加弹出移除的动画效果
- (void)showInView:(UIView *)view
{
    // 浮现
    [UIView animateWithDuration:0.5 animations:^{
        CGPoint point = self.center;
        point.y -= DSPickHeight;
        self.center = point;
    } completion:^(BOOL finished) {
        
    }];
    [view addSubview:self];
}

-(void)leftaction
{
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0;
        CGPoint point = self.center;
        point.y += DSPickHeight;
        self.center = point;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

-(void)rightaction
{
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0;
        CGPoint point = self.center;
        point.y += DSPickHeight;
        self.center = point;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

-(void)setArrayDic:(NSArray<IdName *> *)arrayDic
{
    _arrayDic=arrayDic;
    [self.pickerView reloadAllComponents];
}

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component.
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (self.arrayDic && self.arrayDic.count>0) {
        return [self.arrayDic count];
    }else{
        return [self.array count];
    }
    
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40;
}

#pragma mark - 代理
// 返回第component列第row行的标题
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (self.arrayDic && self.arrayDic.count>row) {
        IdName* iddic=self.arrayDic[row];
        return iddic.name;
    }else{
        return self.array[row];
    }
}

// 选中第component第row的时候调用
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (self.arrayDic && self.arrayDic.count>row) {
        IdName* iddic=self.arrayDic[row];
        self.result = iddic.id;
        self.resultname = iddic.name;
    }else{
        self.result = self.array[row];
        self.resultname = self.array[row];
    }
    if (self.selectBlock) {
        self.selectBlock(self.result,self.resultname);
    }
}

@end
