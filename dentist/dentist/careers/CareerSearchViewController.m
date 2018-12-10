//
//  CareerSearchViewController.m
//  dentist
//
//  Created by feng zhenrong on 2018/12/3.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "CareerSearchViewController.h"
#import "Proto.h"
#import "FindJobsTableViewCell.h"
#import "FindJobsSponsorTableViewCell.h"
#import "DSODetailPage.h"
#import "UIViewController+myextend.h"
#import "DsoToast.h"
#import "JobDetailViewController.h"
#import "AppDelegate.h"
#import "UITableView+JRTableViewPlaceHolder.h"
#import "CDZPicker.h"
#import <CoreLocation/CoreLocation.h>


#define edge 12
@interface CareerSearchViewController ()<UITableViewDelegate,UITableViewDataSource,JobsTableCellDelegate,UIScrollViewDelegate,UISearchBarDelegate,UISearchControllerDelegate,UISearchResultsUpdating,UITextFieldDelegate,CLLocationManagerDelegate>
{
    NSMutableArray *infoArr;
    UITableView *myTable;
    UILabel *jobCountTitle;
    BOOL isdownrefresh;
    UISearchController *searchController;
    NSString *searchKeywords;
    NSArray *locationArr;
    
    UITextField *locationField;
    UITextField *milesField;
    CLLocationManager *locationmanager;
}
/*** searchbar ***/
@property (nonatomic,strong) UISearchBar *searchBar;
@end

@implementation CareerSearchViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UINavigationItem *item = [self navigationItem];
    self.view.backgroundColor = rgb255(246, 245, 245);
    item.rightBarButtonItem= [self navBarText:@"Search" target:self action:@selector(searchBtnClick)];
    item.leftBarButtonItem = [self navBarBack:self action:@selector(onBack:)];
    locationArr = [NSArray arrayWithObjects:@"5 miles",@"10 miles",@"25 miles",@"50 miles",@"100 miles", nil];
    
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectZero];
    _searchBar.placeholder = @"Search...";
    _searchBar.delegate = self;
    _searchBar.showsCancelButton=NO;
    [_searchBar becomeFirstResponder];
    for (id obj in [_searchBar subviews]) {
        if ([obj isKindOfClass:[UIView class]]) {
            for (id obj2 in [obj subviews]) {
                if ([obj2 isKindOfClass:[UIButton class]]) {
                    UIButton *btn = (UIButton *)obj2;
                    [btn setTitle:@"Cancel" forState:UIControlStateNormal];
                }
            }
        }
    }
    item.titleView=_searchBar;
    if (@available(iOS 11.0, *)) {
        [[_searchBar.heightAnchor constraintEqualToConstant:44.0] setActive:YES];
    }
    myTable = [UITableView new];
    [self.view addSubview:myTable];
    myTable.dataSource = self;
    myTable.delegate = self;
    myTable.rowHeight = UITableViewAutomaticDimension;
    myTable.estimatedRowHeight = 100;
    [myTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [myTable registerClass:[FindJobsTableViewCell class] forCellReuseIdentifier:NSStringFromClass([FindJobsTableViewCell class])];
    [myTable registerClass:[FindJobsSponsorTableViewCell class] forCellReuseIdentifier:NSStringFromClass([FindJobsSponsorTableViewCell class])];
    myTable.backgroundColor = rgb255(246, 245, 245);
    [[[myTable.layoutMaker sizeEq:SCREENWIDTH h:SCREENHEIGHT-NAVHEIGHT-TABLEBAR_HEIGHT] topParent:NAVHEIGHT+50] install];
    [self createEmptyNotice];
    [self createLocation];
    [self getCurrentLocation];//get the location
}

- (void)searchBtnClick
{
    
}

- (void)onBack:(UIButton *)btn {
    
    [self.searchBar resignFirstResponder];
    _searchBar.showsCancelButton = NO;
    NSArray *viewcontrollers=self.navigationController.viewControllers;
    if (viewcontrollers.count>1) {
        if ([viewcontrollers objectAtIndex:viewcontrollers.count-1]==self) {
            //push方式
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    else{
        //present方式
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return infoArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row<=1) {
        FindJobsSponsorTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([FindJobsSponsorTableViewCell class]) forIndexPath:indexPath];
        cell.delegate=self;
        cell.indexPath=indexPath;
        if (self->infoArr && self->infoArr.count>indexPath.row) {
            if (indexPath.row<=4) {
                cell.isNew=YES;
            }else{
                cell.isNew=NO;
            }
            cell.info=self->infoArr[indexPath.row];
        }
        return cell;
    }else{
        FindJobsTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([FindJobsTableViewCell class]) forIndexPath:indexPath];
        cell.delegate=self;
        cell.indexPath=indexPath;
        if (self->infoArr && self->infoArr.count>indexPath.row) {
            
            
            if (indexPath.row<=4) {
                cell.isNew=YES;
            }else{
                cell.isNew=NO;
            }
            cell.info=self->infoArr[indexPath.row];
        }
        return cell;
    }
    
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    JobModel *jobModel = infoArr[indexPath.row];
    [JobDetailViewController presentBy:self jobId:jobModel.id closeBack:^{
        foreTask(^{
            if (self->myTable) {
                [self->myTable reloadData];
            }
        });
        
    }];
}

#pragma mark ---UISearchBarDelegate
//MARK:dismiss button clicked，do this method
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    self.searchBar.text=@"";
    [self.searchBar resignFirstResponder];
    _searchBar.showsCancelButton = NO;
    [self dismissViewControllerAnimated:YES completion:nil];
}
//MARK:keyboard search button clicked，do this method
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    searchKeywords=searchBar.text;
    [self.searchBar resignFirstResponder];
    _searchBar.showsCancelButton = NO;

    [self showIndicator];
    [Proto queryAllJobs:0 jobTitle:searchKeywords completed:^(NSArray<JobModel *> *array, NSInteger totalCount) {
        foreTask(^{
            [self hideIndicator];
            self->infoArr = [NSMutableArray arrayWithArray:array];
            [self->myTable reloadData];
        });
    }];
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat height = scrollView.frame.size.height;
    CGFloat contentOffsetY = scrollView.contentOffset.y;
    CGFloat consizeheight=scrollView.contentSize.height;
    CGFloat bottomOffset = (consizeheight - contentOffsetY);
    if (bottomOffset <= height-50 && contentOffsetY>0)
    {
        NSLog(@"==================================下啦刷选;bottomOffset=%@;height-50=%@",@(bottomOffset),@(height-50));
        if (!isdownrefresh) {
            isdownrefresh=YES;
            [self showIndicator];
            [Proto queryAllJobs:self->infoArr.count jobTitle:searchKeywords completed:^(NSArray<JobModel *> *array, NSInteger totalCount) {
                self->isdownrefresh=NO;
                foreTask(^{
                    [self hideIndicator];
                    NSLog(@"%@",array);
                    if(array && array.count>0){
                        [self->infoArr addObjectsFromArray:array];
                    }
                    [self->myTable reloadData];
                    
                });
            }];
            
        }
        
    }
}

- (void)createEmptyNotice
{
    [myTable jr_configureWithPlaceHolderBlock:^UIView * _Nonnull(UITableView * _Nonnull sender) {
        UIView *headerVi = [UIView new];
        headerVi.backgroundColor = [UIColor clearColor];
        UIButton *headBtn = headerVi.addButton;
        [headBtn setImage:[UIImage imageNamed:@"career_searchIcon"] forState:UIControlStateNormal];
        headBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        headBtn.titleLabel.font = [Fonts regular:13];
        [[[headBtn.layoutMaker centerXParent:0] topParent:135] install];
        return headerVi;
    } normalBlock:^(UITableView * _Nonnull sender) {
        [self->myTable setScrollEnabled:YES];
    }];
}

- (void)createLocation
{
    UIView *locationVi = self.view.addView;
    locationVi.layer.masksToBounds = YES;
    locationVi.layer.cornerRadius = 4;
    locationVi.backgroundColor = [UIColor whiteColor];
    [[[[locationVi.layoutMaker sizeEq:SCREENWIDTH-edge*2 h:35] leftParent:edge] topParent:NAVHEIGHT + 8] install];
    
    locationField = locationVi.addEditRaw;
    locationField.textColor = [UIColor grayColor];
    locationField.delegate = self;
    locationField.font = [UIFont systemFontOfSize:14];
    UIButton *locationBtn = [UIButton new];
    locationBtn.frame = CGRectMake(0, 0, edge*2, 35);
    [locationBtn addTarget:self action:@selector(getCurrentLocation) forControlEvents:UIControlEventTouchUpInside];
    [locationBtn setImage:[UIImage imageNamed:@"location_filled"] forState:UIControlStateNormal];
    locationField.leftView = locationBtn;
    locationField.leftViewMode = UITextFieldViewModeAlways;
    [[[[locationField.layoutMaker leftParent:0] sizeEq:200 h:35] topParent:0] install];
    
    UILabel *lineLab = locationVi.addLabel;
    lineLab.backgroundColor = rgb255(246, 245, 245);
    [[[[lineLab.layoutMaker toRightOf:locationField offset:2] topParent:0] sizeEq:1 h:35] install];
    
    milesField = locationVi.addEditRaw;
    milesField.textColor = [UIColor grayColor];
    milesField.font = [UIFont systemFontOfSize:14];
    milesField.delegate = self;
    milesField.text = [NSString stringWithFormat:@"within %@",locationArr[2]];
    milesField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 35)];
    milesField.leftViewMode = UITextFieldViewModeAlways;
    [milesField setRightViewWithTextField:milesField imageName:@"down_list"];
    [[[[[milesField.layoutMaker toRightOf:lineLab offset:2] heightEq:35] topParent:0] rightParent:0] install];
}

- (void)createPickView:(UITextField *)textFiled
{
    CDZPickerBuilder *builder = [CDZPickerBuilder new];
    builder.showMask = YES;
    builder.defaultIndex = 2;
    builder.cancelTextColor = UIColor.redColor;
    if (textFiled == milesField) {
        [CDZPicker showSinglePickerInView:self.view withBuilder:builder strings:locationArr confirm:^(NSArray<NSString *> * _Nonnull strings, NSArray<NSNumber *> * _Nonnull indexs) {
            textFiled.text = [NSString stringWithFormat:@"within %@",strings[0]];
            NSLog(@"strings:%@ indexs:%@",strings,indexs);
        }cancel:^{
            //your code
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

#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == milesField) {
        
        [_searchBar endEditing:YES];
        [self.view endEditing:YES];
        //show pickselect
        [self createPickView:milesField];
        
        return NO;
    }else
    {
        return YES;
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
//    NSString *latitude = [NSString stringWithFormat:@"%f",currentLocation.coordinate.latitude];
//    NSString *longitude = [NSString stringWithFormat:@"%f",currentLocation.coordinate.longitude];
//    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:latitude,@"latitude",longitude,@"longitude", nil];
//    [infoDic addEntriesFromDictionary:dic];
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

@end
