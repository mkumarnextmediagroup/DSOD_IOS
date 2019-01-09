//
//  CareerSearchViewController.h
//  dentist
//
//  Created by feng zhenrong on 2018/12/3.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CareerSearchViewController : UIViewController
- (void)viewWillAppear:(BOOL)animated;
- (void)viewDidLoad;
- (UIView *)makeHeaderView;
- (void)setJobCountTitle:(NSInteger)jobcount;
- (void)searchBtnClick;
- (void)onBack:(UIButton *)btn;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (BOOL)textFieldShouldReturn:(UITextField *)textField;
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
- (void)createEmptyNotice;
- (void)createLocation;
- (void)createPickView:(UITextField *)textFiled;
- (void)getCurrentLocation;
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations;
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error;
@end

NS_ASSUME_NONNULL_END
