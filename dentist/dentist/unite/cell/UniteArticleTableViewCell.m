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
    UILabel *headLabel = self.addLabel;
    headLabel.font = [Fonts regular:13];
    headLabel.text = @"Transform your thinking";
    [[[[[headLabel.layoutMaker leftParent:edge] rightParent:edge] heightEq:20] topParent:edge] install];
    
    UILabel *subHeadLabel = self.addLabel;
    [subHeadLabel textColorMain];
    subHeadLabel.numberOfLines = 2;
    subHeadLabel.text = @"Understanding the DSO practise model";
    subHeadLabel.font = [Fonts regular:13];
    [[[[[subHeadLabel.layoutMaker leftParent:edge] rightParent:edge] heightEq:30] below:headLabel offset:18] install];
}

@end
