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
    UILabel *toplineLabel;
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
        toplineLabel=self.lineLabel;
        toplineLabel.hidden=YES;
        [[[[[toplineLabel.layoutMaker leftParent:0] rightParent:0] topParent:0] heightEq:1] install];
        switchBtn = [UISwitch new];
        [self.contentView addSubview:switchBtn];
        switchBtn.layer.cornerRadius = switchBtn.frame.size.height/2.0;
        switchBtn.layer.masksToBounds=true;
        [[[switchBtn.layoutMaker rightParent:-25] centerYParent:0 ] install];
        [switchBtn addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    
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
        lineLabel=self.lineLabel;
        [[[[[lineLabel.layoutMaker leftParent:0] rightParent:0] bottomParent:0] heightEq:1] install];
    }
    return self;
}

/**
 切换状态
 Switch state
 
 @param isSwitch is on
 */
-(void)setIsSwitch:(BOOL)isSwitch
{
    _isSwitch=isSwitch;
    switchBtn.hidden=!isSwitch;
}

/**
 设置最上面的线的状态
 Set the state of the top line

 @param isShowTopLine isShowTopLine is true display is false hidden
 */
-(void)setIsShowTopLine:(BOOL)isShowTopLine
{
    _isShowTopLine=isShowTopLine;
    toplineLabel.hidden=!isShowTopLine;
}


/**
 设置数据
 Set data
 
 @param title text
 @param des description text
 @param status status
 */
-(void)setModel:(NSString *)title des:(NSString *)des status:(BOOL)status
{
    titleLabel.text=title;
    desLabel.text=des;
    switchBtn.on=status;
}

/**
 切换状态
 Switch state
 
 @param status is on
 */
-(void)setModelSwitch:(BOOL)status
{
    switchBtn.on=status;
}

-(void)styleGlay
{
    [switchBtn setEnabled:NO];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


/**
 Switch event
 
 @param sender UISwitch instance
 */
-(void)switchAction:(UISwitch *)sender{
    BOOL isButtonOn = [sender isOn];
    if (self.delegate && [self.delegate respondsToSelector:@selector(SwitchChangeAction:indexPath:view:)]) {
        [self.delegate SwitchChangeAction:isButtonOn indexPath:_indexPath view:self];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
