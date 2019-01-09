//
//  CareerAlertsAddViewController.h
//  dentist
//
//  Created by feng zhenrong on 2018/12/20.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JobAlertsModel.h"
#import <CoreLocation/CoreLocation.h>
NS_ASSUME_NONNULL_BEGIN

@interface CareerAlertsAddViewController : UIViewController
@property (nonatomic,copy) JobAlertsModel *model;
@property (nonatomic,copy) void(^alertsAddSuceess)(JobAlertsModel * _Nullable oldmodel,JobAlertsModel * _Nullable newmodel);

- (void)setModel:(JobAlertsModel *)model;
- (void)onTap:(id)sender;
- (void)onback;
- (UIView *)makeFooterView;
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)clickSave:(UIButton *)sender;
- (void)getCurrentLocation;
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;
- (void)textFieldDidBeginEditing:(UITextField *)textField;
- (BOOL)textFieldShouldReturn:(UITextField *)textField;
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations;
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error;
@end

NS_ASSUME_NONNULL_END
