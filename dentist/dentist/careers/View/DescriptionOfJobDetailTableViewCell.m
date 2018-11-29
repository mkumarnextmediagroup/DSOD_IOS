//
//  DescriptionOfJobDetailTableViewCell.m
//  dentist
//
//  Created by Shirley on 2018/11/29.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "DescriptionOfJobDetailTableViewCell.h"
#import "common.h"

@implementation DescriptionOfJobDetailTableViewCell{

    UILabel *descLabel;
    
    int edge;
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        edge = 18;
        [self buildView];
    }
    return self;
}

-(void)buildView{
    //Website
    descLabel = self.addLabel;
    descLabel.font = [Fonts regular:16];
    descLabel.numberOfLines = 1;
    [[[[[descLabel.layoutMaker leftParent:edge]rightParent:-edge] topParent:edge] bottomParent:-edge]install];
}


-(void)setData:(JobModel*)model{
    
    descLabel.text = model.jobDescription;
}

@end
