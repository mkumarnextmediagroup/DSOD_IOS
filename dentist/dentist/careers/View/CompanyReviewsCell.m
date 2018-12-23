//
//  CompanyReviewsCell.m
//  dentist
//
//  Created by Shirley on 2018/12/22.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "CompanyReviewsCell.h"
#import "XHStarRateView.h"
#import "Common.h"


@implementation CompanyReviewsCell{
    UIView *contentView;
    XHStarRateView *starRateView;
    UILabel *reviewTitleLabel;
    UILabel *reviewDateLabel;
    UILabel *currentEmployeeLabel;
    UILabel *prosValueLabel;
    UILabel *consValueLabel;
    

    void(^seeMoreListener)(JobDSOModel*jobDSOModel,CompanyReviewModel*reviewModel);
    JobDSOModel *jobDSOModel;
    CompanyReviewModel *reviewModel;

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
    
    contentView = self.addView;
    [[[[[contentView.layoutMaker leftParent:edge]topParent:edge]rightParent:-edge]bottomParent:0] install];
    
    reviewTitleLabel = contentView.addLabel;
    reviewTitleLabel.textColor = rgbHex(0x1b1b1b);
    reviewTitleLabel.font = [Fonts regular:13];
    [[[[reviewTitleLabel.layoutMaker leftParent:0] topParent:0] rightParent:0]install];
    
    UIView *starRateViewBg = contentView.addView;
    [[[[starRateViewBg.layoutUpdate below:reviewTitleLabel offset:5]leftParent:0]heightEq:11] install];
    
    starRateView = [[XHStarRateView alloc] initWithFrame:CGRectMake(0 , 0, 60, 11)];
    starRateView.isAnimation = NO;
    starRateView.userInteractionEnabled = NO;
    starRateView.rateStyle = HalfStar;
    [starRateViewBg addSubview:starRateView];
    
    
    currentEmployeeLabel = contentView.addLabel;
    currentEmployeeLabel.textColor = rgbHex(0x787878);
    currentEmployeeLabel.font = [Fonts regular:10];
    [[[currentEmployeeLabel.layoutMaker leftParent:0] below:starRateViewBg offset:5] install];
    
    reviewDateLabel = contentView.addLabel;
    reviewDateLabel.textColor = rgbHex(0xbababa);
    reviewDateLabel.font = [Fonts regular:10];
    [[[reviewDateLabel.layoutMaker rightParent:0] below:starRateViewBg offset:5] install];
    
    
    UILabel *prosLabel = contentView.addLabel;
    prosLabel.text = @"Pros";
    prosLabel.textColor = rgbHex(0x4a4a4a);
    prosLabel.font = [Fonts regular:12];
    [[[[prosLabel.layoutMaker leftParent:0] below:currentEmployeeLabel offset:edge] rightParent:0]install];
    
    prosValueLabel = contentView.addLabel;
    prosValueLabel.textColor = rgbHex(0x9b9b9b);
    prosValueLabel.font = [Fonts regular:12];
    prosValueLabel.numberOfLines=3;
    [[[[prosValueLabel.layoutMaker leftParent:0] below:prosLabel offset:5] rightParent:0]install];
    
    UILabel *consLabel = contentView.addLabel;
    consLabel.text = @"Cons";
    consLabel.textColor = rgbHex(0x4a4a4a);
    consLabel.font = [Fonts regular:12];
    [[[[consLabel.layoutMaker leftParent:0] below:prosValueLabel offset:edge] rightParent:0]install];
    
    consValueLabel = contentView.addLabel;
    consValueLabel.textColor = rgbHex(0x9b9b9b);
    consValueLabel.font = [Fonts regular:12];
    consValueLabel.numberOfLines=3;
    [[[[consValueLabel.layoutMaker leftParent:0] below:consLabel offset:5] rightParent:0]install];
    
    UILabel *seeMoreLabel = contentView.addLabel;
    seeMoreLabel.textColor = rgbHex(0x879AA8);
    seeMoreLabel.font = [Fonts regular:13];
    [[[[[seeMoreLabel.layoutMaker below:consValueLabel offset:0] rightParent:0]bottomParent:0]heightEq:40] install];
    [seeMoreLabel onClick:self action:@selector(openReviewDetail)];
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"see more"];
    NSRange strRange = {0,[str length]};
    [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
    [seeMoreLabel setAttributedText:str];
    
    
    UILabel *lineLaebl = self.lineLabel;
    [[[[[lineLaebl.layoutMaker leftParent:0] rightParent:0] bottomParent:0]heightEq:1] install];
    
    
}


-(void)setData:(CompanyReviewModel*)model jobDSOModel:(JobDSOModel*)jobDSOModel seeMoreListener:(void(^)(JobDSOModel*jobDSOModel,CompanyReviewModel*reviewModel))seeMoreListener{
    self->jobDSOModel = jobDSOModel;
    self->reviewModel = model;
    self->seeMoreListener = seeMoreListener;
    
    reviewTitleLabel.text = [NSString stringWithFormat:@"“%@”",model.reviewTitle];
    reviewDateLabel.text = [NSDate USDateShortFormatWithTimestamp:model.reviewDate];
    starRateView.currentScore = model.rating;
    
    if(model.isCurrentEmployee){
        currentEmployeeLabel.text = @"Current Employee - Anonymous Employee";
    }else if(model.isFormerEmployee){
        currentEmployeeLabel.text = @"Former Employee - Anonymous Employee";
    }else{
        currentEmployeeLabel.text = @"Anonymous Employee";
    }
    prosValueLabel.text = model.pros;
    consValueLabel.text = model.cons;
    
}

-(void)openReviewDetail{
    if(seeMoreListener){
        self->seeMoreListener(self->jobDSOModel,self->reviewModel);
    }
}
@end
