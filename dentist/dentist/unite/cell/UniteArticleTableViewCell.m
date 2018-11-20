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

- (void)buildViews
{
    headLabel = self.contentView.addLabel;
    headLabel.font = [Fonts regular:13];
    headLabel.numberOfLines = 2;
    headLabel.preferredMaxLayoutWidth = SCREENWIDTH - 132 - edge *2;
    [[[[[headLabel.layoutMaker leftParent:edge] rightParent:-edge] heightEq:40] topParent:8] install];
    
    subHeadLabel = self.contentView.addLabel;
    [subHeadLabel textColorMain];
    subHeadLabel.numberOfLines = 2;
    subHeadLabel.preferredMaxLayoutWidth = SCREENWIDTH - 132 - edge *2;
    subHeadLabel.font = [Fonts regular:13];
    [[[[subHeadLabel.layoutMaker leftParent:edge] sizeEq:SCREENWIDTH - 132 - edge *2 h:45] below:headLabel offset:2] install];
}

- (void)bindInfo:(DetailModel *)article
{
    headLabel.text = article.title;
    subHeadLabel.text = article.subTitle;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGSize size = [subHeadLabel sizeThatFits:CGSizeMake(SCREENWIDTH - 132 - edge *2, 1000)];
    [[subHeadLabel.layoutUpdate heightEq:size.height] install];
    
    CGSize size2 = [headLabel sizeThatFits:CGSizeMake(SCREENWIDTH - 132 - edge *2, 1000)];
    [[headLabel.layoutUpdate heightEq:size2.height] install];
}

@end
