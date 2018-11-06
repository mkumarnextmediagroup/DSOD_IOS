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
    headLabel = self.addLabel;
    headLabel.font = [Fonts regular:13];
    [[[[[headLabel.layoutMaker leftParent:edge] rightParent:edge] heightEq:20] topParent:8] install];
    
    subHeadLabel = self.addLabel;
    [subHeadLabel textColorMain];
    subHeadLabel.numberOfLines = 2;
    subHeadLabel.font = [Fonts regular:13];
    [[[[subHeadLabel.layoutMaker leftParent:edge] sizeEq:SCREENWIDTH - 132 - edge *2 h:45] below:headLabel offset:2] install];
}

- (void)bindInfo:(UniteArticles *)article
{
    headLabel.text = article.issueHeading;
    subHeadLabel.text = article.issueSubHeading;
}

@end
