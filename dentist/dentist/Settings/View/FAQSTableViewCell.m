//
//  FAQSTableViewCell.m
//  dentist
//
//  Created by Shirley on 2019/1/13.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "FAQSTableViewCell.h"
#import "Common.h"
#import "FAQSSubDescModel.h"

@implementation FAQSTableViewCell{
    
    FAQSModel *faqsModel;
    
    UIView   *contentView;
    
    UIView *titleView;
    UILabel *textLabel;
    UIImageView *openImg;
    
    UIView *detailView;
    
    int edge;
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        edge = 18;
        self.itemBgColor = UIColor.whiteColor;
        [self buildViews];
    }
    return self;
}

-(void)buildViews{
    
    contentView= self.addView;
    [[[[[contentView.layoutMaker leftParent:0]topParent:0]rightParent:0]bottomParent:0] install];
    
    titleView = contentView.addView;
    [[[[[titleView.layoutMaker topParent:0]leftParent:0]rightParent:0]heightEq:55]install];
    [titleView onClickView:self action:@selector(titleOnClick)];
    
    textLabel = titleView.addLabel;
    textLabel.font = [Fonts regular:15];
    textLabel.textColor = rgbHex(0x4A4A4A);
    [[[textLabel.layoutMaker leftParent:edge]centerYParent:0]install];
    
    openImg = titleView.addImageView;
    openImg.imageName = @"arrow_down_gray";
    [openImg scaleFill];
    [[[[openImg.layoutMaker rightParent:-edge]centerYParent:0]sizeEq:16 h:16] install];
    
    detailView = contentView.addView;
    [[[[detailView.layoutMaker below:titleView offset:0]leftParent:0]rightParent:0]install];
    
    
    UILabel *line = contentView.lineLabel;
    [[[[[line.layoutMaker leftParent:0]below:detailView offset:0]bottomParent:0] sizeEq:SCREENWIDTH h:1] install];
}


-(void)titleOnClick{
    if(self.titleOnClickListener && faqsModel){
        self.titleOnClickListener(faqsModel._id);
    }
}

-(void)setData:model isOpen:(BOOL)isOpen{
    faqsModel = model;
    
    titleView.backgroundColor = self.itemBgColor;
    textLabel.text = faqsModel.function;
    openImg.imageName = isOpen?@"arrow_up_gray":@"arrow_down_gray";
    
    [detailView removeAllChildren];
    if(isOpen){
        UIView *lastItemView = nil;
        for(int j = 0 ; j < faqsModel.subDescription.count;j++){
            FAQSSubDescModel *subDescModel = faqsModel.subDescription[j];

            UILabel *descLabel = detailView.addLabel;
            descLabel.font = [Fonts regular:14];
            descLabel.textColor = rgbHex(0x879AA8);
            descLabel.text = faqsModel.desc;
            if(lastItemView){
                [[[[descLabel.layoutMaker below:lastItemView offset:10]leftParent:edge]rightParent:-edge]install];
            }else{
                [[[[descLabel.layoutMaker topParent:10]leftParent:edge]rightParent:-edge]install];
            }

            lastItemView = detailView.addView;
            [[[[[lastItemView.layoutMaker below:descLabel offset:10]leftParent:0]rightParent:0]heightEq:0] install];


            for(int i=0;i<subDescModel.steps.count;i++){
                NSString *step = subDescModel.steps[i];
                UIView *itemView = [self item:step showDivider:i!=0];
                [detailView addSubview:itemView];
                [[[[itemView.layoutMaker below:lastItemView offset:0]leftParent:2 * edge ]rightParent:0] install];

                lastItemView = itemView;
            }
        }
        [[lastItemView.layoutUpdate bottomParent:0]install];
    }
}

-(UIView*)item:(NSString*)text showDivider:(BOOL)showDivider{
    UIView *itemView = [[UIView alloc]init];
    UILabel *textLabel = itemView.addLabel;
    textLabel.font = [Fonts regular:14];
    textLabel.textColor = rgbHex(0x4A4A4A);
    textLabel.text = text;
    [[[[[[textLabel.layoutMaker topParent:0]leftParent:edge]rightParent:-edge]bottomParent:0] heightEq:50] install];
    
    if(showDivider){
        UILabel *line = itemView.lineLabel;
        [[[[[line.layoutMaker leftParent:0]rightParent:0]topParent:0]heightEq:1]install];
    }
    
    return itemView;
}

@end
