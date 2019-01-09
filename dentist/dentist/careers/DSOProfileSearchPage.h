//
//  DSOProfileSearchPage.h
//  dentist
//
//  Created by Jacksun on 2018/12/24.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DSOProfileSearchPage : UIViewController

@property (nonatomic,assign)BOOL isDSOProfile;

- (void)searchBtnClick;
- (void)onBack:(UIButton *)btn;
- (void)createTableviewAndSearchField:(UINavigationItem *)item;
- (void)createEmptyNotice;
- (BOOL)textFieldShouldReturn:(UITextField *)textField;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
@end

NS_ASSUME_NONNULL_END
