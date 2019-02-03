//
//  VideoQualityViewController.h
//  dentist
//
//  Created by Shirley on 2019/1/5.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VideoQualityViewController : UIViewController

/**
 Open setting video quality page
 @param vc UIViewController
 */
+(void)openBy:(UIViewController*)vc;


/**
 get video quality data source array
 @return data source array
 */
+(NSArray<NSDictionary*>*)videoQualityArray;

/**
 get selected video quality text
 @return video quality text
 */
+(NSString*)getCheckedVideoQualityText;

/**
 Save the selected video quality locally
 */
+(void)saveCheckedVideoQualityText:(NSString*)text;

/**
 add navigation bar
 */
-(void)addNavBar;

/**
 build views
 */
-(void)buildViews;

/**
 UITableViewDataSource
 number of rows in section
 
 @param tableView UITableView
 @param section section index
 @return number of rows
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

/**
 UITableViewDataSource
 cell for row at index path
 
 @param tableView UITableView
 @param indexPath NSIndexPath
 @return UITableViewCell
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 UITableViewDelegate
 did select row at indexPath
 
 @param tableView UITableView
 @param indexPath NSIndexPath
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;


@end

NS_ASSUME_NONNULL_END
