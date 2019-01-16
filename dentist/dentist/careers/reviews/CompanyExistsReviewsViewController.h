//
//  CompanyExistsReviewsViewController.h
//  dentist
//
//  Created by Shirley on 2018/12/16.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CompanyExistsReviewsViewController : UIViewController

+ (void)openBy:(UIViewController*)vc;
- (void)viewDidLoad;
- (void)addNavBar;
- (void)backToFirst;
- (void)searchClick;
- (void)buildView;
- (void)setupRefresh;
- (void)showTopIndicator;
- (void)hideTopIndicator;
- (void)firstRefresh;
- (void)getDatas:(BOOL)isMore;
- (void)reloadData:(NSArray*)newDatas isMore:(BOOL)isMore;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
@end

NS_ASSUME_NONNULL_END
