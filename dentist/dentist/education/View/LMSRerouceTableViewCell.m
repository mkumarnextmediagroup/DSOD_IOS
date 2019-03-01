//
//  LMSRerouceTableViewCell.m
//  dentist
//
//  Created by Shirley on 2019/2/28.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "LMSRerouceTableViewCell.h"
#import "Common.h"
#import "DentistDownloadModel.h"

@implementation LMSRerouceTableViewCell{

    int edge;
    
    UIView *contentView;
    UILabel *numberLabel;
    UIImageView *iconIV;
    UILabel *nameLabel;
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        edge = 18;
        [self buildView];
    }
    return self;
}


/**
 build views
 */
-(void)buildView{
    
    contentView = self.addView;
    [[[[[contentView.layoutMaker leftParent:edge]topParent:edge]rightParent:-edge]bottomParent:-edge] install];
    
    numberLabel = contentView.addLabel;
    numberLabel.textColor = rgbHex(0x4A4A4A);
    numberLabel.font = [Fonts regular:14];
    [[[numberLabel.layoutMaker leftParent:0] centerYParent:0]install];
    
    iconIV = contentView.addImageView;
    iconIV.imageName = @"ic_lms_resource_pdf";
    [[[[[iconIV.layoutMaker leftParent:50]topParent:0]bottomParent:0]sizeEq:24 h:24]install];
    
    
    nameLabel = contentView.addLabel;
    nameLabel.textColor = rgbHex(0x1A191A);
    nameLabel.font = [Fonts regular:14];
    [[[[nameLabel.layoutMaker toRightOf:iconIV offset:edge] centerYParent:0] rightParent:0]install];
    
    
}

/**
 show data

 @param model download info m
 @param number sort number
 @param resourceType resource type （1.Video 2.audio 3.ScormCourse 4.file  100.test）
 @param showDownloadBtn Control download button display
 */
-(void)showData:(DentistDownloadModel*)model number:(int)number resourceType:(NSInteger)resourceType showDownloadBtn:(BOOL)showDownloadBtn{
    
    numberLabel.text = [NSString stringWithFormat:@"%d.",number];
    nameLabel.text = model.fileName;
    if(resourceType==100){
//        iconIV.imageName =
        
    }else{
        
    }
    
}
@end
