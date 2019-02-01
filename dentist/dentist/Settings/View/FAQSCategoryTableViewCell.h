//
//  FAQSCategoryTableViewCell.h
//  dentist
//
//  Created by Shirley on 2019/1/14.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FAQSCategoryTableViewCell : UITableViewCell

/**
 设置数据
 set datas
 
 @param text text
 @param isLastItem is last item
 */
-(void)setText:(NSString*)text isLastItem:(BOOL)isLastItem;

@end

NS_ASSUME_NONNULL_END
