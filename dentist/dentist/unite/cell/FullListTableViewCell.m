//
//  FullListTableViewCell.m
//  dentist
//
//  Created by 孙兴国 on 2018/11/22.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "FullListTableViewCell.h"
#import "Common.h"

#define edge 16
@implementation FullListTableViewCell
{
    UILabel *headLabel;
    UILabel *subHeadLabel;
    UILabel *expertLabel;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self buildViews];
    }
    return self;
}

- (void)buildViews
{
    headLabel = self.contentView.addLabel;
    headLabel.font = [Fonts regular:14];
    headLabel.numberOfLines = 0;
    [[[[headLabel.layoutMaker leftParent:edge] rightParent:-edge] topParent:8] install];
    [headLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(edge);
        make.right.equalTo(self.contentView).offset(-edge);
        make.top.equalTo(self.contentView).offset(8);
    }];
    
    
    subHeadLabel = self.contentView.addLabel;
    [subHeadLabel textColorMain];
    subHeadLabel.numberOfLines = 0;
    subHeadLabel.font = [Fonts regular:13];
    [[[[subHeadLabel.layoutMaker leftParent:edge] rightParent:-edge] below:headLabel offset:0] install];

    expertLabel = self.contentView.addLabel;
    expertLabel.font = [Fonts regular:13];
    expertLabel.numberOfLines = 0;
    [expertLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(edge);
        make.right.equalTo(self.contentView).offset(-edge);
        make.top.equalTo(self->subHeadLabel.mas_bottom).offset(10);
        make.bottom.equalTo(self.contentView).offset(-8).priorityHigh();
    }];
}

- (void)bindInfo:(DetailModel *)infoModel
{
    if (_isLastInfo) {
        UILabel *line = self.contentView.addLabel;
        line.backgroundColor = [Colors cellLineColor];
        [[[[[line.layoutMaker leftParent:0] rightParent:0] heightEq:1] below:expertLabel offset:5] install];
    }
    
    headLabel.text = infoModel.title;
    subHeadLabel.text = infoModel.subTitle;
    expertLabel.text = infoModel.excerpt;

}

@end
