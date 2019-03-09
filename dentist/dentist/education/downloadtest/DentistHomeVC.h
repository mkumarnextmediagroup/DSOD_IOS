//
//  DentistHomeVC.h
//  DentistProject
//
//  Created by feng zhenrong on 2019/2/28.
//  Copyright © 2019年 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DentistDownload.h"

@interface DentistHomeVC : UIViewController

- (NSMutableArray<DentistDownloadModel *> *)dataSource;
- (void)viewDidLoad;
- (void)back;
- (void)viewWillAppear:(BOOL)animated;
- (void)getInfo;
- (void)getCacheData;
- (void)creatControl;
- (void)addNotification;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)downLoadProgress:(NSNotification *)notification;
- (void)downLoadStateChange:(NSNotification *)notification;
@end
