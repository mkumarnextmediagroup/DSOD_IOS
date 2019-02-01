//
//  UniteArticleTableViewCell.m
//  dentist
//
//  Created by Jacksun on 2018/11/5.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "UniteArticleTableViewCell.h"
#import "Common.h"

#define edge 16
@implementation UniteArticleTableViewCell
{
    UILabel *headLabel;
    UILabel *subHeadLabel;
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
    headLabel.font = [Fonts regular:13];
    headLabel.numberOfLines = 2;
    headLabel.textColor = UIColor.blackColor;
    headLabel.preferredMaxLayoutWidth = SCREENWIDTH - 132 - edge *2;
    [[[[headLabel.layoutMaker leftParent:edge] rightParent:-edge] topParent:8] install];
    
    subHeadLabel = self.contentView.addLabel;
    [subHeadLabel textColorMain];
    subHeadLabel.numberOfLines = 2;
    subHeadLabel.preferredMaxLayoutWidth = SCREENWIDTH - 132 - edge *2;
    subHeadLabel.font = [Fonts regular:13];
    [subHeadLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(edge);
        make.right.equalTo(self.contentView).offset(-edge);
        make.top.equalTo(self->headLabel.mas_bottom).offset(10);
        make.bottom.equalTo(self.contentView).offset(-8).priorityLow();
    }];
}

- (void)bindInfo:(DetailModel *)infoModel {
    if (_isLastInfo) {
        UILabel *line = self.contentView.lineLabel;
        [[[[[line.layoutMaker leftParent:0] rightParent:0] heightEq:1] below:subHeadLabel offset:5] install];
    }
    headLabel.text = infoModel.title;
    subHeadLabel.text = infoModel.subTitle;
}

@end
