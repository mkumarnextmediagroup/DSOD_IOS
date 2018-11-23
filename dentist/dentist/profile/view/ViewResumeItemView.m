//
//  ViewResumeItemView.m
//  dentist
//
//  Created by Shirley on 2018/11/23.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "ViewResumeItemView.h"
#import "common.h"
#import "Proto.h"

@implementation ViewResumeItemView{
    
    NSString *lastResumeUrl;
}


-(void)showWithLastResumeUrl:(NSString*)resumeUrl fileName:(NSString*)resumeName{
    lastResumeUrl = resumeUrl;
    
    [super showWithLastResumeUrl:resumeUrl fileName:resumeName resumeDic:nil];
    
    NSString *text = @"Have not uploaded a resume yet...";
    BOOL viewBtnEnble = NO;
    if(![NSString isBlankString:resumeUrl] && ![NSString isBlankString:resumeName]){
        text = [NSString stringWithFormat:@"Last upload time : %@",[NSDate USDateShortFormatWithStringTimestamp:[lastResumeUrl substringFromIndex:lastResumeUrl.length-13]]];
        viewBtnEnble = YES;
    }
    [self showResumeViewWithText:text viewBtnEnable:viewBtnEnble];
}

-(void)showResumeViewWithText:(NSString*)text viewBtnEnable:(BOOL)enable{
    [self removeAllChildren];
    
    UIButton *viewBtn = self.addButton;
    viewBtn.titleLabel.font = [Fonts regular:16];
    [viewBtn setTitleColor:Colors.secondary forState:UIControlStateNormal];
    [viewBtn setTitle:@"View"  forState:UIControlStateNormal];
    [[[[viewBtn.layoutMaker rightParent:-self.padding.right] centerYParent:0] sizeEq:55 h:48 ]install];
    [viewBtn setTitleColor:Colors.secondary forState:UIControlStateNormal];
    if(enable){
        [viewBtn setTitleColor:rgbHex(0x0e78b9) forState:UIControlStateNormal];
        [viewBtn addTarget:self action:@selector(viewResume) forControlEvents:UIControlEventTouchUpInside];
    }
    
    UILabel *titleLabel = self.addLabel;
    [titleLabel textColorMain];
    titleLabel.font = [Fonts semiBold:14];
    titleLabel.text = @"My Resume";
    [[[[[[titleLabel layoutMaker] topParent:16] leftParent:self.padding.left] toLeftOf:viewBtn offset:-10] heightEq:20] install];
    
    
    UILabel *msgLabel = self.addLabel;
    [msgLabel textColorSecondary];
    msgLabel.font = [Fonts regular:12];
    msgLabel.numberOfLines = 2;
    msgLabel.text = text;
    [[[[[[msgLabel layoutMaker] bottomParent:-16] leftParent:self.padding.left] toLeftOf:viewBtn offset:-10] heightGe:24] install];
}

-(void)viewResume{
    [super viewResume];
}



@end
