//
//  ContactTableViewCell.h
//  dentist
//
//  Created by Jacksun on 2018/8/22.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactTableViewCell : UITableViewCell
@property (strong, nonatomic)UILabel *notice;
@property (strong, nonatomic)UITextField *emailField;
@property (strong, nonatomic)UITextView *content;
@end
