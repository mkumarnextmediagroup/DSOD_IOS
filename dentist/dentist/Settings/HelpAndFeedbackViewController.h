//
//  HelpAndFeedbackViewController.h
//  dentist
//
//  Created by Shirley on 2019/1/6.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScrollPage.h"

NS_ASSUME_NONNULL_BEGIN

@interface HelpAndFeedbackViewController : UIViewController

/**
 Open help and feedback page
 @param vc UIViewController
 */
+(void)openBy:(UIViewController*)vc;

/**
 view did load
 build views and load FAQS data from server
 */
- (void)viewDidLoad;

/**
 add navigation bar
 */
-(void)addNavBar;

/**
 build views
 */
-(void)buildViews;

/**
 hide soft keyboard
 */
-(void)keyboardHide;

/**
 
 TextField Text Change callback
 @param textField searchTextField
 */
-(void)textFieldTextChange:(UITextField *)textField;

/**
 Search for matching content
 @param searchWord search word
 @return Matching Array
 */
-(NSArray*)filter:(NSString*)searchWord;

/**
 Whether it is search mode
 @return Search mode returns true otherwise returns faslse
 */
-(BOOL)isSearchMode;

/**
 scrollView did Scroll,soft keyboard
 
 @param scrollView UISscrollView
 */
-(void)scrollViewDidScroll:(UIScrollView *)scrollView;

/**
 UITableViewDataSource
 numberOfSectionsInTableView
 
 @param tableView UITableView
 @return number fo sections
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;


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
 heightForHeaderInSection
 
 @param tableView UITableView
 @param section section index
 @return height for header in section
 */
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;

/**
 UITableViewDataSource
 viewForHeaderInSection
 
 @param tableView UITableView
 @param section section index
 @return header view
 */
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;

/**
 UITableViewDataSource
 heightForRowAtIndexPath
 
 @param tableView UITableView
 @param indexPath NSIndexPath
 @return height for row at indexPath
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 UITableViewDataSource
 cellForRowAtIndexPath
 
 @param tableView UITableView
 @param indexPath NSIndexPath
 @return UITableViewCell
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 build category cell
 
 @param indexPath NSIndexPath
 @return FAQSCategoryTableViewCell
 */
-(UITableViewCell*)categoryCell:(NSIndexPath *)indexPath;

/**
 build faqs function cell
 
 @param indexPath NSIndexPath
 @return FAQSTableViewCell
 */
-(UITableViewCell*)faqsFunctionCell:(NSIndexPath *)indexPath;

/**
 UITableViewDataSource
 didSelectRowAtIndexPath
 
 @param tableView UITableView
 @param indexPath NSIndexPath
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
@end

NS_ASSUME_NONNULL_END
