//
//  EducationCategoryTableViewCell.m
//  dentist
//
//  Created by feng zhenrong on 2019/2/14.
//  Copyright © 2019年 thenextmediagroup.com. All rights reserved.
//

#import "EducationCategoryTableViewCell.h"
#import "Common.h"

@implementation EducationCategoryTableViewCell
{
    UILabel *titleLabel;
    UILabel *desLabel;
    UILabel *lineLabel;
}

/**
 init cell layout
 
 @param style UITableViewCellStyle
 @param reuseIdentifier  reuseIdentifier
 @return instance
 */
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        titleLabel = self.contentView.addLabel;
        titleLabel.font = [Fonts regular:17];
        titleLabel.textColor =Colors.black1A191A;
        [[[[[titleLabel.layoutMaker rightParent:-20] leftParent:18] centerYParent:-10] heightEq:20] install];
        desLabel = self.contentView.addLabel;
        desLabel.font = [Fonts regular:13];
        desLabel.textColor = Colors.textMain;
        [desLabel adjustsFontSizeToFitWidth];
        [[[[[desLabel.layoutMaker rightParent:-20] leftParent:18] below:titleLabel offset:0] heightEq:20] install];
        lineLabel=self.lineLabel;
        [[[[[lineLabel.layoutMaker leftParent:0] rightParent:0] bottomParent:0] heightEq:1] install];
    }
    return self;
}

/**
 设置数据
 Set data
 
 @param title text
 @param des description text
 @param status status
 */
-(void)setModel:(NSString *)title des:(NSString *)des
{
    titleLabel.text=title;
    desLabel.text=des;
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
