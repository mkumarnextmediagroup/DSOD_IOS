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
@property (nonatomic,strong) UIColor *itemBgColor;
@property (nonatomic,copy) void(^titleOnClickListener)(NSString*_id);


-(void)setData:(FAQSModel*)model isOpen:(BOOL)isOpen;



@end

NS_ASSUME_NONNULL_END
