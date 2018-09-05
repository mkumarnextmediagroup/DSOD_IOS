//
//  EditHederTableViewCell.m
//  dentist
//
//  Created by Jacksun on 2018/9/5.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "EditHederTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "Common.h"

@implementation EditHederTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UILabel *noticeLab = [[UILabel alloc] init];
        noticeLab.textColor = Colors.textAlternate;
        noticeLab.font = [Fonts regular:12];
        noticeLab.text = @"profile photo";
        noticeLab.textAlignment = NSTextAlignmentCenter;
        [self addSubview:noticeLab];
        [[[[noticeLab.layoutMaker sizeEq:100 h:20] topParent:22] leftParent:(SCREENWIDTH - 100)/2] install];
        
        _headerImg = [[UIImageView alloc] init];
        _headerImg.image = [UIImage imageNamed:@"headerImage"];
        [_headerImg sd_setImageWithURL:[NSURL URLWithString:@""]
                   placeholderImage:[UIImage imageNamed:@"default_avatar"]];
        [self addSubview:_headerImg];
        [[[[_headerImg.layoutMaker sizeEq:115 h:115] topParent:44] leftParent:(SCREENWIDTH - 115)/2] install];

        UIButton *editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [editBtn setImage:[UIImage imageNamed:@"edit_photo"] forState:UIControlStateNormal];
        [self addSubview:editBtn];
        [[[[editBtn.layoutMaker sizeEq:38 h:38] toRightOf:_headerImg offset:-19] below:_headerImg offset:-19] install];
        
        UILabel *lineLab = [[UILabel alloc] init];
        lineLab.backgroundColor = Colors.cellLineColor;
        [self addSubview:lineLab];
        [[[[lineLab.layoutMaker sizeEq:SCREENWIDTH h:1] below:self offset:-1] leftParent:0] install];
        
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
