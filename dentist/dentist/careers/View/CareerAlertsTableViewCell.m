//
//  CareerAlertsTableViewCell.m
//  dentist
//
//  Created by feng zhenrong on 2018/12/19.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "CareerAlertsTableViewCell.h"
#import "Common.h"
@implementation CareerAlertsTableViewCell
{
    UILabel *titleLabel;
    UILabel *desLabel;
    UIButton *alerImageView;
    UIButton *editImageView;
    UILabel *lineLabel;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        editImageView = self.contentView.addButton;
        [editImageView setImage:[UIImage imageNamed:@"write"] forState:UIControlStateNormal];
        [[[[editImageView.layoutMaker rightParent:-25] centerYParent:0 ] sizeEq:30 h:30] install];
        [editImageView addTarget:self action:@selector(edit:) forControlEvents:UIControlEventTouchUpInside];
        
        alerImageView = self.contentView.addButton;
        [alerImageView setImage:[UIImage imageNamed:@"icons8-appointment_reminders_filled"] forState:UIControlStateNormal];
        [[[[alerImageView.layoutMaker toLeftOf:editImageView offset:-30] centerYParent:0 ] sizeEq:30 h:30] install];
        [alerImageView addTarget:self action:@selector(alert:) forControlEvents:UIControlEventTouchUpInside];
        
        titleLabel = self.contentView.addLabel;
        titleLabel.font = [Fonts semiBold:16];
        [titleLabel textColorMain];
        [[[[[titleLabel.layoutMaker toLeftOf:alerImageView offset:-10] leftParent:36] bottomOf:alerImageView offset:-(30.0/2)] heightEq:20] install];
        desLabel = self.contentView.addLabel;
        desLabel.font = [Fonts semiBold:13];
        desLabel.textColor = Colors.textDisabled;
        [[[[[desLabel.layoutMaker toLeftOf:alerImageView offset:-10] leftParent:36] topOf:alerImageView offset:(30.0/2)+5] heightEq:20] install];
        lineLabel=self.contentView.lineLabel;
        [[[[[lineLabel.layoutMaker leftParent:0] rightParent:0] bottomParent:0] heightEq:1] install];
    }
    return self;
}

-(void)setAlerModel:(JobAlertsModel *)alerModel
{
    _alerModel=alerModel;
    if (_alerModel) {
        titleLabel.text=[NSString stringWithFormat:@"%@",_alerModel.keyword];
        desLabel.text=[NSString stringWithFormat:@"%@ | %@ miles",alerModel.location,@(_alerModel.distance)];
        if(alerModel.status){
            [alerImageView setImage:[UIImage imageNamed:@"icons8-appointment_reminders_filled"] forState:UIControlStateNormal];
        }else{
            [alerImageView setImage:[UIImage imageNamed:@"icons8-no_reminders"] forState:UIControlStateNormal];
        }
    }
    

}

-(void)edit:(UIButton *)sender
{
    if (_alerModel) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(JobAlertsEditAction:)]) {
            [self.delegate JobAlertsEditAction:_alerModel];
        }
    }
    
}

-(void)alert:(UIButton *)sender
{
    if (_alerModel) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(JobAlertsAction:)]) {
            [self.delegate JobAlertsAction:_alerModel];
        }
    }
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
