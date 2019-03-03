//
//  LMSResourceTableViewCell.h
//  dentist
//
//  Created by Shirley on 2019/2/28.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DentistDownloadModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface LMSResourceTableViewCell : UITableViewCell


@property (nonatomic,strong) UIViewController *vc;
@property (nonatomic,copy) void(^cancelDownloadCallback)(void);
@property (nonatomic,copy) void(^removeDownloadCallback)(void);



/**
 show data
 
 @param model download info m
 @param number sort number
 @param resourceType resource type （1.Video 2.audio 3.ScormCourse 4.file  100.test）
 @param showDownloadBtn Control download button display
 */
-(void)showData:(DentistDownloadModel*)model number:(int)number resourceType:(NSInteger)resourceType showDownloadBtn:(BOOL)showDownloadBtn;

/**
 Update download progress
 
 @param model DentistDownloadModel
 */
- (void)updateViewWithModel:(DentistDownloadModel *)model;

    
@end

NS_ASSUME_NONNULL_END
