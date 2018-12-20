//
//  CareerAlertsAddViewController.m
//  dentist
//
//  Created by feng zhenrong on 2018/12/20.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "CareerAlertsAddViewController.h"
#import "Proto.h"
#import "UIViewController+myextend.h"
#import "TextFieldImageView.h"
#import <CoreLocation/CoreLocation.h>
#import "DentistPickerView.h"
#import "DsoToast.h"

@interface CareerAlertsAddViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,CLLocationManagerDelegate>
{
    UITableView *myTable;
    CLLocationManager *locationmanager;
    NSArray *locationArr;
    NSString *latitude;
    NSString *longitude;
    NSArray *latLongArr;
    NSString *requestMiles;
    NSString *currentCity;
    NSInteger distance;
    NSInteger frequency;
    NSString *alertTitle;
}
@end

@implementation CareerAlertsAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    UINavigationItem *item = self.navigationItem;
    item.title = @"CREATE JOB ALERT";
    item.leftBarButtonItem = [self navBarImage:@"back_arrow" target:self action:@selector(onback)];
     item.rightBarButtonItem = [self navBarText:@"Cancel" target:self action:@selector(onback)];//[self navBarImageBtn:addimage target:self action:@selector(addClick)];
    CGFloat _topBarH = 0;
    if (self.navigationController != nil) {
        _topBarH = NAVHEIGHT;
    }
    myTable = [UITableView new];
    [self.view addSubview:myTable];
    myTable.dataSource = self;
    myTable.delegate = self;
    myTable.scrollEnabled=NO;
    [myTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    myTable.tableFooterView=[self makeFooterView];
   [[[[[myTable.layoutMaker leftParent:0] rightParent:0] topParent:_topBarH] bottomParent:0] install];
    
    UITapGestureRecognizer *tapViewBG =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
    [myTable addGestureRecognizer:tapViewBG];
}

- (void)onTap:(id)sender{
    [self.view endEditing:YES];
}

-(void)onback{
    NSArray *viewcontrollers=self.navigationController.viewControllers;
    if (viewcontrollers.count>1) {
        if ([viewcontrollers objectAtIndex:viewcontrollers.count-1]==self) {
            //push方式
            [self.navigationController popViewControllerAnimated:NO];
        }
    }
    else{
        //present方式
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}

- (UIView *)makeFooterView {
    UIView *panel = [UIView new];
    panel.frame = makeRect(0, 0, SCREENWIDTH, 80);
    panel.backgroundColor=[UIColor clearColor];
    
    UIButton *updateButton = panel.addButton;
    [updateButton styleWhite];
    [updateButton title:localStr(@"Save")];
    [updateButton styleDisabled];
    [[[[[updateButton.layoutMaker leftParent:20] rightParent:-20] heightEq:40] centerYParent:0] install];
    [updateButton onClick:self action:@selector(clickSave:)];
    return panel;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 82;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = @"CareerAlertsAddTableCell";
    UITableViewCell *cell = [tableView  cellForRowAtIndexPath:indexPath];
    UILabel *titleLabel;
    TextFieldImageView *newtext;
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier: cellID];
        cell.selectionStyle=UITableViewCellAccessoryNone;     //选中时效果
        titleLabel=[UILabel new];
        titleLabel.font=[Fonts semiBold:16];
        titleLabel.textColor=Colors.textMain;
        [cell.contentView addSubview:titleLabel];
        [[[[[titleLabel.layoutMaker topParent:10] leftParent:20] rightParent:-20] heightEq:20] install];
        newtext=[TextFieldImageView new];
        newtext.edit.delegate = self;
        [newtext.edit returnDone];
        [cell.contentView addSubview:newtext];
        [[[[[newtext.layoutMaker leftParent:20] rightParent:-20] below:titleLabel offset:10] heightEq:40] install];
    }
    newtext.edit.tag=indexPath.row;
    if (indexPath.row==0) {
        titleLabel.text=@"Job title or keyword (optional)";
    }else if (indexPath.row==1){
        newtext.iconView.image=[UIImage imageNamed:@"icons8-marker"];
        titleLabel.text=@"Location";
    }else if (indexPath.row==2){
        newtext.iconView.image=[UIImage imageNamed:@"arrow_small"];
        titleLabel.text=@"Distance";
    }else if (indexPath.row==3){
        newtext.iconView.image=[UIImage imageNamed:@"arrow_small"];
        titleLabel.text=@"Frequency";
    }
    
    return cell;
}

-(void)clickSave:(UIButton *)sender
{
    UITableViewCell *cell = [self->myTable  cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    for (UIView *view in cell.contentView.subviews) {
        if ([view isKindOfClass:[TextFieldImageView class]]) {
            TextFieldImageView *textview=(TextFieldImageView *)view;
            self->alertTitle=textview.edit.text;
        }
    }
    UIView *dsontoastview=[DsoToast toastViewForMessage:@"adding JobsRemind……" ishowActivity:YES];
    [self.navigationController.view showToast:dsontoastview duration:30.0 position:CSToastPositionBottom completion:nil];
    [Proto addJobRemind:self->alertTitle location:self->currentCity position:self->latLongArr distance:self->distance frequency:self->frequency status:YES completed:^(HttpResult *result) {
        foreTask(^{
            [self.navigationController.view hideToast];
            if (result.OK) {
                if (self.alertsAddSuceess) {
                    self.alertsAddSuceess();
                }
                [self onback];
            }else{
                NSString *message=result.msg;
                if([NSString isBlankString:message]){
                    message=@"Failed";
                }
                UIWindow *window = [[UIApplication sharedApplication] keyWindow];
                [window makeToast:message
                         duration:1.0
                         position:CSToastPositionBottom];
                [self.navigationController popViewControllerAnimated:YES];
            }
        });
    }];
}

- (void)getCurrentLocation
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Current Location" message:@"You allow to use your current location to create a job alert" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //判断定位功能是否打开
        if ([CLLocationManager locationServicesEnabled]) {
            self->locationmanager = [[CLLocationManager alloc]init];
            self->locationmanager.delegate = self;
            [self->locationmanager requestAlwaysAuthorization];
            [self->locationmanager requestWhenInUseAuthorization];
            
            //设置寻址精度
            self->locationmanager.desiredAccuracy = kCLLocationAccuracyBest;
            self->locationmanager.distanceFilter = 5.0;
            [self->locationmanager startUpdatingLocation];
        }
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField.tag==1) {
        [self.view endEditing:YES];
        [self getCurrentLocation];
        return NO;
    }else if (textField.tag==2){
        [self.view endEditing:YES];
        DentistPickerView *picker = [[DentistPickerView alloc]init];
        picker.array=@[@"5 miles",@"10 miles",@"25 miles",@"50 miles",@"100 miles"];
        picker.leftTitle=localStr(@"Choose distance");
        picker.righTtitle=localStr(@"Cancel");
        [picker show:^(NSString *result,NSString *resultname) {
            
        } rightAction:^(NSString *result,NSString *resultname) {
            
        } selectAction:^(NSString *result,NSString *resultname) {
            textField.text=resultname;
            if(![NSString isBlankString:resultname]){
                self->distance=[[resultname stringByReplacingOccurrencesOfString:@" miles" withString:@""] integerValue];
            }
        }];
        return NO;
    }else if (textField.tag==3){
        [self.view endEditing:YES];
        DentistPickerView *picker = [[DentistPickerView alloc]init];
        picker.array=@[@"Daily",@"Weekly",@"Bi-Weekly",@"Monthly"];
        picker.leftTitle=localStr(@"Choose frequency");
        picker.righTtitle=localStr(@"Cancel");
        [picker show:^(NSString *result,NSString *resultname) {
            
        } rightAction:^(NSString *result,NSString *resultname) {
            
        } selectAction:^(NSString *result,NSString *resultname) {
            textField.text=resultname;
            if (![NSString isBlankString:resultname]) {
                if ([resultname isEqualToString:@"Daily"]) {
                    self->frequency=1;
                }else if ([resultname isEqualToString:@"Weekly"]) {
                    self->frequency=5;
                }else if ([resultname isEqualToString:@"Bi-Weekly"]) {
                    self->frequency=7;
                }else if ([resultname isEqualToString:@"Monthly"]) {
                    self->frequency=30;
                }
            }
            
        }];
        return NO;
    }
    
    return YES;
}

//MARK:点击文本操作，tableview位置上移
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    UIView *view = textField.superview;
    
    while (![view isKindOfClass:[UITableViewCell class]]) {
        
        view = [view superview];
        
    }
    
    UITableViewCell *cell = (UITableViewCell*)view;
    
    CGRect rect = [cell convertRect:cell.frame toView:self.view];
    
    CGFloat keyboardh=216+80;
    if (rect.origin.y / 2 + rect.size.height>=self.view.frame.size.height-keyboardh) {
        
        myTable.contentInset = UIEdgeInsetsMake(0, 0, keyboardh, 0);
        
        [myTable scrollToRowAtIndexPath:[myTable indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
        
    }
}

//MARK:点击文本操作，tableview位置恢复
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    UIView *view = textField.superview;
    
    while (![view isKindOfClass:[UITableViewCell class]]) {
        
        view = [view superview];
        
    }
    
    UITableViewCell *cell = (UITableViewCell*)view;
    
    CGRect rect = [cell convertRect:cell.frame toView:self.view];
    
    CGFloat keyboardh=216+80;
    if (rect.origin.y / 2 + rect.size.height>=self.view.frame.size.height-keyboardh) {
        
        myTable.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        [myTable scrollToRowAtIndexPath:[myTable indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
        
    }
    
    return YES;
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
    latitude = [NSString stringWithFormat:@"%f",currentLocation.coordinate.latitude];
    longitude = [NSString stringWithFormat:@"%f",currentLocation.coordinate.longitude];
    //    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:latitude,@"latitude",longitude,@"longitude", nil];
    latLongArr = [NSArray arrayWithObjects:longitude,latitude, nil];
    //    [infoDic addEntriesFromDictionary:dic];
    //反地理编码
    [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count > 0) {
            CLPlacemark *placeMark = placemarks[0];
            self->currentCity = placeMark.locality;
            if (!self->currentCity) {
                self->currentCity = @"无法定位当前城市";
            }
            
            /*看需求定义一个全局变量来接收赋值*/
            NSLog(@"----%@",placeMark.country);//当前国家
            NSLog(@"%@",self->currentCity);//当前的城市
            UITableViewCell *cell = [self->myTable  cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
            for (UIView *view in cell.contentView.subviews) {
                if ([view isKindOfClass:[TextFieldImageView class]]) {
                    TextFieldImageView *textview=(TextFieldImageView *)view;
                    textview.edit.text=self->currentCity;
                }
            }
            
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


@end
