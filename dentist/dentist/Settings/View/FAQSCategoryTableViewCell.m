//
//  FAQSCategoryTableViewCell.m
//  dentist
//
//  Created by Shirley on 2019/1/14.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "FAQSCategoryTableViewCell.h"
#import "Common.h"

@implementation FAQSCategoryTableViewCell{
    UIView   *contentView;

    UILabel *textLabel;
    UIImageView *openImg;
    UIView *titleView;

    int edge;
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        edge = 18;
        [self buildViews];
    }
    return self;
}

-(void)buildViews{
    
    contentView= self.addView;
    [[[[[contentView.layoutMaker leftParent:0]topParent:0]rightParent:0]bottomParent:0] install];
    
    titleView = contentView.addView;
    [[[[[titleView.layoutMaker topParent:0]leftParent:0]rightParent:0]heightEq:55]install];
    
    textLabel = titleView.addLabel;
    textLabel.font = [Fonts regular:15];
    textLabel.textColor = rgbHex(0x4A4A4A);
    [[[textLabel.layoutMaker leftParent:edge]centerYParent:0]install];
    
    openImg = titleView.addImageView;
    openImg.imageName = @"arrow";
    [openImg scaleFill];
    [[[[openImg.layoutMaker rightParent:-edge]centerYParent:0]sizeEq:16 h:16] install];
    
    
    UILabel *line = contentView.lineLabel;
    [[[[[line.layoutMaker leftParent:0]below:titleView offset:0]bottomParent:0] sizeEq:SCREENWIDTH h:1] install];
}

-(void)setText:(NSString *)text{
    textLabel.text = text;
}

@end
