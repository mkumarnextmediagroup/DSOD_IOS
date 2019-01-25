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
    //data model
    FAQSModel *faqsModel;
    
    //root view
    UIView   *contentView;
    
    UIView *titleView;
    UILabel *textLabel;
    UIImageView *openImg;
    
    //detail view
    UIView *detailView;
    UILabel *line;
    
    int edge;
}


/**
 init cell layout
 
 @param style UITableViewCellStyle
 @param reuseIdentifier  reuseIdentifier
 @return instance
 */
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


/**
 build views
 */
-(void)buildViews{
    
    //root view
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
    
    //detial view ，The default height is 0
    detailView = contentView.addView;
    [[[[detailView.layoutMaker below:titleView offset:0]leftParent:0]rightParent:0]install];
    
    
    line = contentView.lineLabel;
    [[[[[line.layoutMaker leftParent:0]below:detailView offset:0]bottomParent:0] sizeEq:SCREENWIDTH h:1] install];
}


/**
 标题点击事件
 title onclick event
 */
-(void)titleOnClick{
    if(self.titleOnClickListener && faqsModel){
        self.titleOnClickListener(faqsModel._id);
    }
}

/**
 设置数据
 set datas

 @param model FAQSModel instance
 @param isOpen Whether to expand the display details
 @param isLastItem is last item
 */
-(void)setData:(FAQSModel*)model isOpen:(BOOL)isOpen isLastItem:(BOOL)isLastItem{
    faqsModel = model;
    
    titleView.backgroundColor = self.itemBgColor;
    textLabel.text = faqsModel.function;
    openImg.imageName = isOpen?@"arrow_up_gray":@"arrow_down_gray";
    [[line.layoutUpdate heightEq:isLastItem?0:1]install];
    
    //移除详情视图的所有子视图
    //Remove all subviews from the details view
    [detailView removeAllChildren];
    if(isOpen){
        //如果是展开 重新布局详情视图
        //If it is expanded, re-layout details view
        UIView *lastItemView = nil;
        for(int j = 0 ; j < faqsModel.subDescription.count;j++){
            //遍历所有的描述
            //Iterate all the descriptions
            FAQSSubDescModel *subDescModel = faqsModel.subDescription[j];

            UILabel *descLabel = detailView.addLabel;
            descLabel.font = [Fonts regular:14];
            descLabel.textColor = rgbHex(0x879AA8);
            descLabel.text = faqsModel.desc;
            
            if(lastItemView){
                //存在最后的视图时，描述标签在最后的视图下面显示
                //When there is a final view, the description tag is displayed below the last view
                [[[[descLabel.layoutMaker below:lastItemView offset:10]leftParent:edge]rightParent:-edge]install];
            }else{
                //不存在最后的视图时，描述标签在父布局顶端显示
                //The description label is displayed at the top of the parent layout when there is no last view
                [[[[descLabel.layoutMaker topParent:10]leftParent:edge]rightParent:-edge]install];
            }

            lastItemView = detailView.addView;
            [[[[[lastItemView.layoutMaker below:descLabel offset:10]leftParent:0]rightParent:0]heightEq:0] install];

            //遍历所有的步骤，创建视图，添加到详情视图上
            //Traverse all the steps, create a view, add to the details view
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

/**
 创建一个步骤条目视图
Create an step item view
 
 @param text text
 @param showDivider Whether to display the dividing line
 @return item view
 */
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
