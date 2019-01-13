//
//  GeneralTableViewCell.m
//  dentist
//
//  Created by feng zhenrong on 2019/1/11.
//  Copyright © 2019年 thenextmediagroup.com. All rights reserved.
//

#import "GeneralTableViewCell.h"
#import "Common.h"
@implementation GeneralTableViewCell
{
    UILabel *titleLabel;
    UILabel *desLabel;
    UISwitch *switchBtn;
    UILabel *lineLabel;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        switchBtn = [UISwitch new];
        [self.contentView addSubview:switchBtn];
        switchBtn.layer.cornerRadius = switchBtn.frame.size.height/2.0;
        switchBtn.layer.masksToBounds=true;
        [[[switchBtn.layoutMaker rightParent:-25] centerYParent:0 ] install];
        switchBtn.backgroundColor=Colors.bgDisabled;
        // 设置控件开启状态填充色
        switchBtn.onTintColor = Colors.textDisabled;
        // 设置控件关闭状态填充色
        switchBtn.tintColor = Colors.bgDisabled;
        // 设置控件开关按钮颜色
        switchBtn.thumbTintColor = [UIColor whiteColor];
        
        //        [switchBtn addTarget:self action:@selector(edit:) forControlEvents:UIControlEventTouchUpInside];
        
        titleLabel = self.contentView.addLabel;
        titleLabel.font = [Fonts regular:15];
        titleLabel.textColor =[UIColor blackColor];
        [[[[[titleLabel.layoutMaker toLeftOf:switchBtn offset:-10] leftParent:18] centerYParent:-10] heightEq:20] install];
        desLabel = self.contentView.addLabel;
        desLabel.font = [Fonts regular:12];
        desLabel.textColor = Colors.textColor3900;
        [desLabel adjustsFontSizeToFitWidth];
        [[[[[desLabel.layoutMaker toLeftOf:switchBtn offset:-10] leftParent:18] below:titleLabel offset:0] heightEq:20] install];
        lineLabel=self.contentView.lineLabel;
        [[[[[lineLabel.layoutMaker leftParent:0] rightParent:0] bottomParent:0] heightEq:1] install];
    }
    return self;
}

-(void)setIsSwitch:(BOOL)isSwitch
{
    _isSwitch=isSwitch;
    switchBtn.hidden=!isSwitch;
}

-(void)setModel:(NSString *)title des:(NSString *)des status:(BOOL)status
{
    titleLabel.text=title;
    desLabel.text=des;
    switchBtn.on=status;
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
