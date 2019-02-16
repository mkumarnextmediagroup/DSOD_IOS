//
//  NotificationsViewController.h
//  dentist
//
//  Created by feng zhenrong on 2019/1/8.
//  Copyright © 2019年 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NotificationModel.h"

@interface NotificationsViewController : UIViewController
@property (nonatomic,strong) NotificationModel *model;

/**
 close page
 */
-(void)back;

/**
 UITableViewDataSource
 heightForRowAtIndexPath
 
 @param tableView UITableView
 @param indexPath NSIndexPath
 @return height for row
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 UITableViewDataSource
 numberOfRowsInSection
 
 @param tableView UITableView
 @param section section index
 @return number of rows in section
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

/**
 UITableViewDataSource
 cellForRowAtIndexPath
 
 @param tableView UITableView
 @param indexPath NSIndexPath
 @return UITableViewCell
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 UITableViewDataSource
 didSelectRowAtIndexPath
 
 @param tableView UITableView
 @param indexPath NSIndexPath
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 status change event
 
 @param status ON is YES，OFF is NO
 @param indexPath NSIndexPath
 @param view UITableViewCell
 */
-(void)SwitchChangeAction:(BOOL)status indexPath:(NSIndexPath *)indexPath view:(UIView *)view;


@end

