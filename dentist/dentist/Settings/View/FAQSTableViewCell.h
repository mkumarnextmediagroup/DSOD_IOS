//
//  FAQSTableViewCell.h
//  dentist
//
//  Created by Shirley on 2019/1/13.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FAQSModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FAQSTableViewCell : UITableViewCell
/**
 item background color，default white
 */
@property (nonatomic,strong) UIColor *itemBgColor;

/**
 title on click listener
 */
@property (nonatomic,copy) void(^titleOnClickListener)(NSString*_id);

/**
 设置数据
 set datas
 
 @param model FAQSModel instance
 @param isOpen Whether to expand the display details
 @param isLastItem is last item
 */
-(void)setData:(FAQSModel*)model isOpen:(BOOL)isOpen isLastItem:(BOOL)isLastItem;



@end

NS_ASSUME_NONNULL_END
