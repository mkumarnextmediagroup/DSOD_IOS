//
//  SeetingLabelAndCheckedTableViewCell.m
//  dentist
//
//  Created by Shirley on 2019/1/5.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "SettingLabelAndCheckedTableViewCell.h"
#import "Common.h"

@implementation SettingLabelAndCheckedTableViewCell{
    
    UIView   *contentView;
    UILabel *textLabel;
    UIImageView *checkedImg;
    
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
    
    textLabel = contentView.addLabel;
    textLabel.font = [Fonts regular:13];
    textLabel.textColor = [UIColor blackColor];
    [[[textLabel.layoutMaker leftParent:edge]centerYParent:0]install];
    
    checkedImg = contentView.addImageView;
    checkedImg.imageName = @"check2";
    [[[checkedImg.layoutMaker rightParent:-edge]centerYParent:0]install];
    
    UILabel *line = contentView.lineLabel;
    [[[[[line.layoutMaker topParent:60]leftParent:0]sizeEq:SCREENWIDTH h:1]bottomParent:0] install];
}

- (void)setText:(NSString *)text isChecked:(BOOL)isChecked{
    textLabel.text = text;
    textLabel.textColor = isChecked ? rgbHex(0x879AA8) : rgbHex(0x000000);
    checkedImg.hidden = !isChecked;
    
}


@end
