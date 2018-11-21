//
//  UniteArticleTableViewCell.m
//  dentist
//
//  Created by Jacksun on 2018/11/5.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "UniteArticleTableViewCell.h"
#import "Common.h"

#define edge 30
@implementation UniteArticleTableViewCell
{
    UILabel *categoryLab;
    UILabel *headLabel;
    UILabel *subHeadLabel;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self buildViews];
    }
    return self;
}

- (void)createCategory
{
    categoryLab = self.contentView.addLabel;
    categoryLab.font = [Fonts regular:13];
    categoryLab.numberOfLines = 2;
    categoryLab.textColor = Colors.textAlternate;
    [[[[[categoryLab.layoutMaker leftParent:edge] rightParent:-edge] heightEq:44] topParent:8] install];

}

- (void)buildViews
{
    headLabel = self.contentView.addLabel;
    headLabel.font = [Fonts regular:13];
    headLabel.numberOfLines = 0;
    headLabel.preferredMaxLayoutWidth = SCREENWIDTH - 132 - edge *2;
    [[[[headLabel.layoutMaker leftParent:edge] rightParent:-edge] topParent:8] install];
    
    subHeadLabel = self.contentView.addLabel;
    [subHeadLabel textColorMain];
    subHeadLabel.numberOfLines = 0;
    subHeadLabel.preferredMaxLayoutWidth = SCREENWIDTH - 132 - edge *2;
    subHeadLabel.font = [Fonts regular:13];
    [[[[subHeadLabel.layoutMaker leftParent:edge]  rightParent:-edge] below:headLabel offset:2] install];

//    if (i == infoArr.count-1) {
//        UILabel *line = self.contentView.addLabel;
//        line.backgroundColor = [Colors cellLineColor];
//        [[[[[line.layoutMaker leftParent:0] rightParent:0] heightEq:1] below:subHeadLabel offset:15] install];
//    }
    
}

- (void)createSearchSubView
{
    headLabel = self.contentView.addLabel;
    headLabel.font = [Fonts regular:13];
    headLabel.numberOfLines = 0;
    headLabel.preferredMaxLayoutWidth = SCREENWIDTH - 132 - edge *2;
    [[[[headLabel.layoutMaker leftParent:edge] rightParent:-edge] topParent:8] install];
    
    subHeadLabel = self.contentView.addLabel;
    [subHeadLabel textColorMain];
    subHeadLabel.numberOfLines = 0;
    subHeadLabel.preferredMaxLayoutWidth = SCREENWIDTH - 132 - edge *2;
    subHeadLabel.font = [Fonts regular:13];
    [[[[subHeadLabel.layoutMaker leftParent:edge]  rightParent:-edge] below:headLabel offset:0] install];
    
    UILabel *line = self.contentView.addLabel;
    line.backgroundColor = [Colors cellLineColor];
    [[[[[line.layoutMaker leftParent:0] rightParent:0] heightEq:1] below:subHeadLabel offset:8] install];
}

- (void)bindInfo:(DetailModel *)infoModel
{
    headLabel.text = infoModel.title;
    subHeadLabel.text = infoModel.subTitle;
}

@end
