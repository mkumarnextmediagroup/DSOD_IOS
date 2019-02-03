//
//  FAQSViewController.h
//  dentist
//
//  Created by Shirley on 2019/1/6.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FAQSCategoryModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FAQSViewController : UIViewController



/**
 Open FAQS page

 @param vc UIViewController
 @param categoryModel FAQSCategoryModel
 */
+(void)openBy:(UIViewController*)vc categoryModel:(FAQSCategoryModel*)categoryModel;

/**
 add navigation bar
 */
-(void)addNavBar;

/**
 build views
 */
-(void)buildViews;

/**
 open contact us page
 */
-(void)buttonOnClick;

/**
 UITableViewDataSource
 numberOfRowsInSection
 
 @param tableView UITableView
 @param section section index
 @return number of rows
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

/**
 UITableViewDataSource
 
 @param tableView UITableView
 @param indexPath NSIndexPath
 @return UITableViewCell
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
