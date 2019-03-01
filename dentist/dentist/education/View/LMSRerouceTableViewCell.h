//
//  LMSRerouceTableViewCell.h
//  dentist
//
//  Created by Shirley on 2019/2/28.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DentistDownloadModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface LMSRerouceTableViewCell : UITableViewCell


/**
 show data
 
 @param model download info m
 @param number sort number
 @param resourceType resource type （1.Video 2.audio 3.ScormCourse 4.file  100.test）
 @param showDownloadBtn Control download button display
 */
-(void)showData:(DentistDownloadModel*)model number:(int)number resourceType:(NSInteger)resourceType showDownloadBtn:(BOOL)showDownloadBtn;
    
@end

NS_ASSUME_NONNULL_END
