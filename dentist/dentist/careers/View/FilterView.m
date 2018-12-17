//
//  FilterView.m
//  dentist
//
//  Created by Jacksun on 2018/11/29.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "FilterView.h"
#import "Common.h"
#import "UITextField+styled.h"
#import "CDZPicker.h"
#import <CoreLocation/CoreLocation.h>

#define edge 20
#define Xleft 15
#define AliX  8

@interface FilterView()<UITextFieldDelegate,CLLocationManagerDelegate>

@end

@implementation FilterView
{
    UIScrollView *mScroll;
    UITextField *skillField;
    UITextField *salaryField;
    UITextField *experField;
    UITextField *locationField;
    UITextField *jobField;
    UITextField *comField;
    UITextField *selectField;
    UIPickerView *myPicker;
    CLLocationManager *locationmanager;//locaiton
    
    NSArray *experArr;
    NSArray *salaryArr;
    NSArray *locationArr;
    
    NSMutableDictionary *infoDic;
}

static FilterView *instance;
static dispatch_once_t onceToken;

+(void)attemptDealloc{
    instance = nil;
    onceToken = 0;
}

+ (instancetype)initFilterView
{
    dispatch_once(&onceToken, ^{
        instance = [[FilterView alloc] init];
        instance.frame = CGRectMake(0, SCREENHEIGHT, SCREENWIDTH, SCREENHEIGHT-NAVHEIGHT);
        instance.backgroundColor = [UIColor whiteColor];
        [instance createCloseBtn];
        [instance createSkill];
        [instance createSalary];
        [instance createExperence];
        [instance createLocation];
        [instance createJobTitle];
        [instance createCompany];
        [instance createFunBtn];
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window.rootViewController.view addSubview:instance];
    });
    
    return instance;
}

- (void)showFilter
{
    infoDic = [[NSMutableDictionary alloc] initWithCapacity:10];
    experArr = [NSArray arrayWithObjects:@"1-5 years",@"6-10 years",@"11-15 years",@"15-20 years",@"20+ years", nil];
    salaryArr = [NSArray arrayWithObjects:@"$100K - $200K",@"$200K - $400K",@"$400 - $500K",@"$500K plus", nil];
    locationArr = [NSArray arrayWithObjects:@"5 miles",@"10 miles",@"25 miles",@"50 miles",@"100 miles", nil];
    
    if (self.frame.origin.y == SCREENHEIGHT) {
        [UIView animateWithDuration:.3 animations:^{
            self.frame = CGRectMake(0, NAVHEIGHT, SCREENWIDTH, SCREENHEIGHT-NAVHEIGHT);
        }];
    }else
    {
        [UIView animateWithDuration:.3 animations:^{
            self.frame = CGRectMake(0, SCREENHEIGHT, SCREENWIDTH, SCREENHEIGHT-NAVHEIGHT);
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
            [FilterView attemptDealloc];
        }];
    }
}

- (void)getCurrentLocation
{
    //判断定位功能是否打开
    if ([CLLocationManager locationServicesEnabled]) {
        locationmanager = [[CLLocationManager alloc]init];
        locationmanager.delegate = self;
        [locationmanager requestAlwaysAuthorization];
        [locationmanager requestWhenInUseAuthorization];
        
        //设置寻址精度
        locationmanager.desiredAccuracy = kCLLocationAccuracyBest;
        locationmanager.distanceFilter = 5.0;
        [locationmanager startUpdatingLocation];
    }
}

- (void)createCloseBtn
{
    mScroll = self.addScrollView;
    [[[mScroll.layoutMaker sizeEq:SCREENWIDTH h:SCREENHEIGHT] topParent:0] install];
    
    UIButton *closeBtn = mScroll.addButton;
//    closeBtn.backgroundColor = [UIColor blueColor];
    [closeBtn setImage:[UIImage imageNamed:@"close_select"] forState:UIControlStateNormal];
    [[[[closeBtn.layoutMaker sizeEq:50 h:50] topParent:10] leftParent:SCREENWIDTH-60] install];
    [closeBtn addTarget:self action:@selector(closeSelf) forControlEvents:UIControlEventTouchUpInside];
}

- (void)closeSelf
{
    [self removeFromSuperview];
    [FilterView attemptDealloc];
}

- (void)createSkill
{
    UIButton *skillBtn = mScroll.addButton;
    [skillBtn setImage:[UIImage imageNamed:@"skills_career"] forState:UIControlStateNormal];
    [skillBtn setTitle:@"  Skills" forState:UIControlStateNormal];
    skillBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [skillBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    skillBtn.titleLabel.font = [Fonts regular:15];
    [[[[skillBtn.layoutMaker sizeEq:180 h:25] topParent:50] leftParent:edge] install];
    
    skillField = mScroll.addEditFilter;
    skillField.delegate = self;
    [[[[skillField.layoutMaker sizeEq:SCREENWIDTH-edge*2 h:30] leftParent:edge] below:skillBtn offset:AliX] install];
}

- (void)createSalary
{
    UIButton *salaryBtn = mScroll.addButton;
    [salaryBtn setImage:[UIImage imageNamed:@"salary_career"] forState:UIControlStateNormal];
    [salaryBtn setTitle:@"  Salary" forState:UIControlStateNormal];
    salaryBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [salaryBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    salaryBtn.titleLabel.font = [Fonts regular:15];
    [[[[salaryBtn.layoutMaker sizeEq:180 h:25] leftParent:edge] below:skillField offset:Xleft] install];
    
    salaryField = mScroll.addEditFilter;
    [salaryField setRightViewWithTextField:salaryField imageName:@"down_list"];
    salaryField.delegate = self;
    [[[[salaryField.layoutMaker sizeEq:SCREENWIDTH-edge*2 h:30] leftParent:edge] below:salaryBtn offset:AliX] install];
}

- (void)createExperence
{
    UIButton *experBtn = mScroll.addButton;
    [experBtn setImage:[UIImage imageNamed:@"experence_career"] forState:UIControlStateNormal];
    [experBtn setTitle:@"  Experence" forState:UIControlStateNormal];
    experBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [experBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    experBtn.titleLabel.font = [Fonts regular:15];
    [[[[experBtn.layoutMaker sizeEq:180 h:25] leftParent:edge] below:salaryField offset:Xleft] install];
    
    experField = mScroll.addEditFilter;
    [experField setRightViewWithTextField:experField imageName:@"down_list"];
    experField.delegate = self;
    [[[[experField.layoutMaker sizeEq:SCREENWIDTH-edge*2 h:30] leftParent:edge] below:experBtn offset:AliX] install];
}

- (void)createLocation
{
    UIButton *locationBtn = mScroll.addButton;
    [locationBtn setImage:[UIImage imageNamed:@"location_career"] forState:UIControlStateNormal];
    [locationBtn setTitle:@"  Location" forState:UIControlStateNormal];
    locationBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [locationBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    locationBtn.titleLabel.font = [Fonts regular:15];
    [[[[locationBtn.layoutMaker sizeEq:180 h:25] leftParent:edge] below:experField offset:Xleft] install];
    
    UIButton *currLocaBtn = mScroll.addButton;
    [currLocaBtn setTitle:@"Current Location" forState:UIControlStateNormal];
    currLocaBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [currLocaBtn setTitleColor:[Colors primary] forState:UIControlStateNormal];
    currLocaBtn.titleLabel.font = [Fonts regular:12];
    [currLocaBtn addTarget:self action:@selector(getCurrentLocation) forControlEvents:UIControlEventTouchUpInside];
    [[[[currLocaBtn.layoutMaker sizeEq:100 h:25] below:experField offset:Xleft] leftParent:SCREENWIDTH-100-edge] install];

    
    locationField = mScroll.addEditFilter;
    locationField.delegate = self;
    [[[[locationField.layoutMaker sizeEq:(SCREENWIDTH-edge*2)/3*2-10 h:30] leftParent:edge] below:locationBtn offset:AliX] install];
    
    selectField = mScroll.addEditFilter;
    selectField.delegate = self;
    [selectField setRightViewWithTextField:selectField imageName:@"down_list"];
    [[[[selectField.layoutMaker sizeEq:(SCREENWIDTH-edge*2)/3*1 h:30] toRightOf:locationField offset:10] below:locationBtn offset:AliX] install];
}

- (void)createJobTitle
{
    UIButton *jobBtn = mScroll.addButton;
    [jobBtn setImage:[UIImage imageNamed:@"job_career"] forState:UIControlStateNormal];
    [jobBtn setTitle:@"  Job title" forState:UIControlStateNormal];
    jobBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [jobBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    jobBtn.titleLabel.font = [Fonts regular:15];
    [[[[jobBtn.layoutMaker sizeEq:180 h:25] leftParent:edge] below:locationField offset:Xleft] install];
    
    jobField = mScroll.addEditFilter;
    jobField.delegate = self;
    [[[[jobField.layoutMaker sizeEq:SCREENWIDTH-edge*2 h:30] leftParent:edge] below:jobBtn offset:AliX] install];
    
    NSMutableParagraphStyle *style = [jobField.defaultTextAttributes[NSParagraphStyleAttributeName] mutableCopy];
    style.minimumLineHeight = jobField.font.lineHeight - (jobField.font.lineHeight - [UIFont systemFontOfSize:14.0].lineHeight) / 2.0;
    jobField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Type here..."attributes:@{NSForegroundColorAttributeName: [UIColor grayColor],NSFontAttributeName:[UIFont systemFontOfSize:12.0],NSParagraphStyleAttributeName : style}];
}

- (void)createCompany
{
    UIButton *comBtn = mScroll.addButton;
    [comBtn setImage:[UIImage imageNamed:@"company_career"] forState:UIControlStateNormal];
    [comBtn setTitle:@"  Company" forState:UIControlStateNormal];
    comBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [comBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    comBtn.titleLabel.font = [Fonts regular:15];
    [[[[comBtn.layoutMaker sizeEq:180 h:25] leftParent:edge] below:jobField offset:Xleft] install];
    
    comField = mScroll.addEditFilter;
    comField.delegate = self;
    [[[[comField.layoutMaker sizeEq:SCREENWIDTH-edge*2 h:30] leftParent:edge] below:comBtn offset:AliX] install];
    
    NSMutableParagraphStyle *style = [comField.defaultTextAttributes[NSParagraphStyleAttributeName] mutableCopy];
    style.minimumLineHeight = comField.font.lineHeight - (comField.font.lineHeight - [UIFont systemFontOfSize:14.0].lineHeight) / 2.0;
    comField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Type here..."attributes:@{NSForegroundColorAttributeName: [UIColor grayColor],NSFontAttributeName:[UIFont systemFontOfSize:12.0],NSParagraphStyleAttributeName : style}];
}

- (void)createFunBtn
{
    UIButton *clearBtn = mScroll.addButton;
    [clearBtn setTitle:@"Clear All" forState:UIControlStateNormal];
    [clearBtn setTitleColor:[Colors primary] forState:UIControlStateNormal];
    clearBtn.titleLabel.font = [Fonts regular:15];
    [clearBtn addTarget:self action:@selector(clearBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [[[[clearBtn.layoutMaker sizeEq:SCREENWIDTH-edge*2 h:30] leftParent:edge] below:comField offset:25] install];

    UIButton *updateBtn = mScroll.addButton;
    [updateBtn setTitle:@"Update" forState:UIControlStateNormal];
    [updateBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    updateBtn.titleLabel.font = [Fonts bold:15];
    [updateBtn setBackgroundColor:[Colors primary]];
    [[[[updateBtn.layoutMaker sizeEq:SCREENWIDTH-edge*2 h:44] leftParent:edge] below:clearBtn offset:25] install];
    [updateBtn addTarget:self action:@selector(updateBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [mScroll layoutIfNeeded];
    [self layoutIfNeeded];
    mScroll.contentSize = CGSizeMake(SCREENWIDTH, CGRectGetMaxY(updateBtn.frame)+160);
    //NSLog(@"%f",CGRectGetMaxY(updateBtn.frame)+200);
}

- (void)clearBtnClick
{
    NSLog(@"clear button click");
    if(self.delegate && [self.delegate respondsToSelector:@selector(searchCondition:)]){
        [self.delegate searchCondition:nil];
        //after update dismiss the filter
        [self showFilter];
    }
}

- (void)updateBtnClick
{
    [self addTheInfoToSearch];
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(searchCondition:)]){
        [self.delegate searchCondition:infoDic];
        //after update dismiss the filter
        [self showFilter];
    }
    NSLog(@"update button click");
}

- (void)addTheInfoToSearch
{
    if (skillField.text.length != 0) {
        NSDictionary *info = [[NSDictionary alloc] initWithObjectsAndKeys:skillField.text,@"skill", nil];
        [infoDic addEntriesFromDictionary:info];
    }
    if (salaryField.text.length != 0){
        NSDictionary *info = [[NSDictionary alloc] initWithObjectsAndKeys:salaryField.text,@"salary", nil];
        [infoDic addEntriesFromDictionary:info];
    }
    if (experField.text.length != 0){
        NSDictionary *info = [[NSDictionary alloc] initWithObjectsAndKeys:experField.text,@"experence", nil];
        [infoDic addEntriesFromDictionary:info];
    }
    if (jobField.text.length != 0){
        NSDictionary *info = [[NSDictionary alloc] initWithObjectsAndKeys:jobField.text,@"jobTitle", nil];
        [infoDic addEntriesFromDictionary:info];
    }
    if (comField.text.length != 0){
        NSDictionary *info = [[NSDictionary alloc] initWithObjectsAndKeys:comField.text,@"company", nil];
        [infoDic addEntriesFromDictionary:info];
    }
    if (selectField.text.length != 0){
        NSDictionary *info = [[NSDictionary alloc] initWithObjectsAndKeys:selectField.text,@"miles", nil];
        [infoDic addEntriesFromDictionary:info];
    }
}

#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == salaryField || textField == experField || textField == selectField) {
        [self endEditing:YES];
        [self createPickView:textField];
        [UIView animateWithDuration:.3 animations:^{
            self->myPicker.frame = CGRectMake(0, SCREENHEIGHT - 216 - 65, SCREENWIDTH, 216);
        }];
        
        return NO;
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self endEditing:YES];
    return YES;
}

- (void)createPickView:(UITextField *)textFiled
{
    CDZPickerBuilder *builder = [CDZPickerBuilder new];
    builder.showMask = YES;
    builder.cancelTextColor = UIColor.redColor;
    if (textFiled == salaryField) {
        [CDZPicker showSinglePickerInView:self withBuilder:builder strings:salaryArr confirm:^(NSArray<NSString *> * _Nonnull strings, NSArray<NSNumber *> * _Nonnull indexs) {
            textFiled.text = strings[0];
            NSLog(@"strings:%@ indexs:%@",strings,indexs);
        }cancel:^{
            //your code
        }];
    }else if (textFiled == experField)
    {
        [CDZPicker showSinglePickerInView:self withBuilder:builder strings:experArr confirm:^(NSArray<NSString *> * _Nonnull strings, NSArray<NSNumber *> * _Nonnull indexs) {
            textFiled.text = strings[0];
            NSLog(@"strings:%@ indexs:%@",strings,indexs);
        }cancel:^{
            //your code
        }];
    }else
    {
        [CDZPicker showSinglePickerInView:self withBuilder:builder strings:locationArr confirm:^(NSArray<NSString *> * _Nonnull strings, NSArray<NSNumber *> * _Nonnull indexs) {
            textFiled.text = strings[0];
            NSLog(@"strings:%@ indexs:%@",strings,indexs);
        }cancel:^{
            //your code
        }];
    }
    
}

#pragma mark CLLoactionDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    [locationmanager stopUpdatingHeading];
    //旧址
    CLLocation *currentLocation = [locations lastObject];
    CLGeocoder *geoCoder = [[CLGeocoder alloc]init];
    //打印当前的经度与纬度
    NSLog(@"%f,%f",currentLocation.coordinate.latitude,currentLocation.coordinate.longitude);
    NSString *latitude = [NSString stringWithFormat:@"%f",currentLocation.coordinate.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%f",currentLocation.coordinate.longitude];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:latitude,@"latitude",longitude,@"longitude", nil];
    [infoDic addEntriesFromDictionary:dic];
    //反地理编码
    [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count > 0) {
            CLPlacemark *placeMark = placemarks[0];
            NSString *currentCity = placeMark.locality;
            if (!currentCity) {
                currentCity = @"无法定位当前城市";
            }
            
            /*看需求定义一个全局变量来接收赋值*/
            NSLog(@"----%@",placeMark.country);//当前国家
            NSLog(@"%@",currentCity);//当前的城市
            self->locationField.text = currentCity;
            
        }
    }];
    
}

//定位失败后调用此代理方法
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    //设置提示提醒用户打开定位服务
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"允许定位提示" message:@"请在设置中打开定位" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"打开定位" style:UIAlertActionStyleDefault handler:nil];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:okAction];
    [alert addAction:cancelAction];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window.rootViewController presentViewController:alert animated:YES completion:nil];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
