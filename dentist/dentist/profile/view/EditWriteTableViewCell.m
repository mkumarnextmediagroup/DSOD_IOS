//
//  EditWriteTableViewCell.m
//  dentist
//
//  Created by Jacksun on 2018/9/5.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "EditWriteTableViewCell.h"
#import "Common.h"

@implementation EditWriteTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _titleLab = [[UILabel alloc] init];
        _titleLab.text = localStr(@"dental");
        _titleLab.font = [Fonts regular:12];
        _titleLab.textColor = Colors.textAlternate;
        [self addSubview:_titleLab];
        [[[[_titleLab.layoutMaker sizeEq:120 h:34] leftParent:16] topParent:10] install];
        
        _imageBtn = [UIButton new];
        [_imageBtn setImage:[UIImage imageNamed:@"write"] forState:UIControlStateNormal];
        [self addSubview:_imageBtn];
        [[[[_imageBtn.layoutMaker sizeEq:42 h:42] rightParent:0] topParent:34] install];
        
        _contentField = [[UITextField alloc] init];
        _contentField.font = [Fonts regular:15];
        _contentField.textColor = UIColor.blackColor;
        [self addSubview:_contentField];
        [[[[_contentField.layoutMaker sizeEq:260 h:42] leftParent:16] topParent:34] install];
        _contentField.hidden = YES;
        
        
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
