//
//  ContactTableViewCell.m
//  dentist
//
//  Created by Jacksun on 2018/8/22.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "ContactTableViewCell.h"
#import "Fonts.h"

@implementation ContactTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _notice = [UILabel new];
        _notice.frame = CGRectMake(20, 0, SCREENWIDTH - 40, 49);
        _notice.font = [Fonts regular:15];
        _notice.textColor = [UIColor lightGrayColor];
        [self addSubview:_notice];
        
        _emailField = [UITextField new];
        _emailField.frame = CGRectMake(20, 40, SCREENWIDTH - 40, 40);
        _emailField.textColor = [UIColor blackColor];
//        _emailField.placeholder = @"enter you email";
        _emailField.font = [Fonts regular:17];
        [self addSubview:_emailField];
        _emailField.hidden = YES;
        
        _content = [UITextView new];
        _content.frame = CGRectMake(20, 40, SCREENWIDTH - 40, 180);
        _content.textColor = [UIColor blackColor];
        _content.font = [Fonts regular:17];
        [self addSubview:_content];
        _content.hidden = YES;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
