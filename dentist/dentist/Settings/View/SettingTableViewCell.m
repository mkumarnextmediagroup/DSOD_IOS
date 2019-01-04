//
//  SettingTableViewCell.m
//  dentist
//
//  Created by Jacksun on 2019/1/4.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "SettingTableViewCell.h"
#import "Common.h"

#define edge 18
@implementation SettingTableViewCell
{
    UIButton *iconBtn;
    UILabel  *finLabel;
    UIView   *footerVi;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        footerVi = [self addView];
        footerVi.backgroundColor = rgb255(250, 251, 253);
        [[[[footerVi.layoutMaker sizeEq:SCREENWIDTH h:55] leftParent:0] bottomParent:0] install];
        
        iconBtn = [footerVi addButton];
        [[[[iconBtn.layoutMaker sizeEq:30 h:30] leftParent:edge] topParent:13] install];
        
        finLabel = [footerVi addLabel];
        finLabel.font = [Fonts semiBold:14];
        finLabel.textColor = [UIColor blackColor];
        [[[[finLabel.layoutMaker toRightOf:iconBtn offset:edge] topParent:13] sizeEq:200 h:30] install];
        
    }
    return self;
}

- (void)setImageAndTitle:(UIImage *)image title:(NSString *)title
{
    [iconBtn setImage:image forState:UIControlStateNormal];
    finLabel.text = title;
}

- (void)setLastCellImageAndTitle:(UIImage *)image title:(NSString *)title
{
    [iconBtn setImage:image forState:UIControlStateNormal];
    footerVi.backgroundColor = rgb255(250, 251, 253);
    finLabel.textColor = rgb255(140, 158, 172);
    finLabel.text = title;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
