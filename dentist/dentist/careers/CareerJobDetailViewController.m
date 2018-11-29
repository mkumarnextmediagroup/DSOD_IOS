//
//  CareerJobDetailViewController.m
//  dentist
//
//  Created by Shirley on 2018/11/28.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "CareerJobDetailViewController.h"
#import "common.h"
#import "UIView+Toast.h"
#import "CompanyOfJobDetailTableViewCell.h"
#import "DescriptionOfJobDetailTableViewCell.h"
#import "CompanyModel.h"
#import "Proto.h"
#import "JobModel.h"

@interface CareerJobDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation CareerJobDetailViewController{
    
    UIView *contentView;
    UIView *naviBarView;
    UITableView *tableView;
    
    int edge;
    int currTabIndex;//0:description 1:company 2:reviews
    
    JobModel *jobModel;
}



+(void)present:(UIViewController*)vc jobId:(NSString*)jobId{
    CareerJobDetailViewController *jobDetailVc = [CareerJobDetailViewController new];
    jobDetailVc.jobId = jobId;
    jobDetailVc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    vc.modalPresentationStyle = UIModalPresentationCurrentContext;
    [vc presentViewController:jobDetailVc animated:YES completion:^{
        jobDetailVc.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    }];
}

- (void)viewDidLoad {
    edge = 18;
    
    [super viewDidLoad];
    
    contentView  = self.view.addView;
    [[[[[contentView.layoutMaker leftParent:0]rightParent:0] topParent:44]bottomParent:0] install];
    contentView.backgroundColor = UIColor.whiteColor;
    
    [self addNavBar];
    
    [self showLoading];
    
    [Proto findJobById:self.jobId completed:^(JobModel * _Nullable jobModel) {
        [self hideLoading];
        if(jobModel){
            self->jobModel = jobModel;
            [self buildView];
        }
    }];
}

-(void)addNavBar{
    naviBarView = contentView.addView;
    naviBarView.backgroundColor = Colors.textDisabled;
    [[[naviBarView.layoutMaker sizeEq:SCREENWIDTH h:44] topParent:0]install];
    
    UIImageView *closeView = naviBarView.addImageView;
    closeView.image = [UIImage imageNamed:@"icon_arrow_down"];
    [closeView onClickView:self action:@selector(closePage)];
    [[[closeView.layoutMaker sizeEq:100 h:40]centerParent]install];
    
    UIImageView *shareView = naviBarView.addImageView;
    shareView.image = [UIImage imageNamed:@"icon_share_white"];
    [shareView onClickView:self action:@selector(share)];
    [[[[shareView.layoutMaker sizeEq:44 h:44] centerYParent:0] rightParent:-5] install];


    UIImageView *attentionView = naviBarView.addImageView;
    attentionView.image = [UIImage imageNamed:@"icon_attention"];
    [attentionView onClickView:self action:@selector(attention)];
    [[[[attentionView.layoutMaker sizeEq:44 h:44]centerYParent:0]toLeftOf:shareView offset:0] install];
    

}


-(void)buildView{
    tableView = [UITableView new];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.estimatedRowHeight = 10;
    tableView.rowHeight=UITableViewAutomaticDimension;
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    tableView.separatorStyle = UITableViewCellEditingStyleNone;
    tableView.contentInset = UIEdgeInsetsMake(0, 0, 80, 0);
    [contentView addSubview:tableView];
    [[[[[tableView.layoutMaker leftParent:0] rightParent:0] below:naviBarView offset:0] bottomParent:0] install];
    [tableView setTableHeaderView:[self buildHeader]];
    
    UIButton *applyNowBtn = contentView.addButton;
    applyNowBtn.layer.borderWidth = 1;
    applyNowBtn.layer.borderColor = rgbHex(0xb3bfc7).CGColor;
    applyNowBtn.backgroundColor = Colors.textDisabled;
    applyNowBtn.titleLabel.font = [Fonts regular:16];
    [applyNowBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [applyNowBtn setTitle:@"Apply Now" forState:UIControlStateNormal];
    [[[[[applyNowBtn.layoutMaker bottomParent:-edge]leftParent:edge]rightParent:-edge]heightEq:40]install];
    [applyNowBtn onClick:self action:@selector(applyNow)];
}


-(UIView*)buildHeader{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 0)];
    
    UIImageView *mediaView = headerView.addImageView;
    [mediaView scaleFillAspect];
    mediaView.clipsToBounds = YES;
    [[[[[mediaView.layoutMaker leftParent:0]rightParent:0]topParent:0]sizeEq:SCREENWIDTH h:SCREENWIDTH/2]install];
    
    UIImageView *logoImageView = headerView.addImageView;
    [logoImageView scaleFillAspect];
    logoImageView.clipsToBounds = YES;
    [[[[logoImageView.layoutMaker leftParent:edge]below:mediaView offset:10] sizeEq:60 h:60]install];
    
    UILabel *jobLabel = headerView.addLabel;
    jobLabel.font = [Fonts semiBold:16];
    jobLabel.textColor = Colors.textMain;
    [[[[jobLabel.layoutMaker toRightOf:logoImageView offset:10]rightParent:edge] below:mediaView offset:10]install] ;
    
    UILabel *companyLabel = headerView.addLabel;
    companyLabel.font = [Fonts semiBold:14];
    companyLabel.textColor = Colors.textDisabled;
    [[[[companyLabel.layoutMaker toRightOf:logoImageView offset:10]rightParent:edge] below:jobLabel offset:5]install] ;
    
    
    UILabel *salaryLabel = headerView.addLabel;
    salaryLabel.font = [Fonts semiBold:12];
    salaryLabel.textColor = Colors.textMain;
    [[[[salaryLabel.layoutMaker toRightOf:logoImageView offset:10]rightParent:edge] below:companyLabel offset:5]install] ;
    
    
    UIButton *addressBtn = headerView.addButton;
    addressBtn.titleLabel.font = [Fonts regular:12];
    [addressBtn setTitleColor:Colors.textMain forState:UIControlStateNormal];
    [addressBtn onClick:self action:@selector(showLocation)];
    addressBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 100);
    addressBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    addressBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    addressBtn.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    addressBtn.titleLabel.numberOfLines = 3;
    [[[[[addressBtn.layoutMaker below:salaryLabel offset:10]leftParent:edge]rightParent:-edge] heightEq:50]install];
    
    UIView *lastView = headerView.addView;
    [[[[[lastView.layoutMaker below:addressBtn offset:0]leftParent:0]rightParent:0]heightEq:10]install];

    
    //还没处理完 图片
    [mediaView loadUrl:jobModel.company.companyLogo placeholderImage:nil];
    [logoImageView loadUrl:jobModel.company.companyLogo placeholderImage:nil];
    jobLabel.text = [NSString stringWithFormat:@"%@-%@",jobModel.jobTitle,jobModel.location];
    companyLabel.text = jobModel.company.companyName;
    salaryLabel.text = [NSString stringWithFormat:@"Est. Salary:%@",jobModel.salaryRange] ;
    [addressBtn setTitle:jobModel.company.address forState:UIControlStateNormal];
    addressBtn.backgroundColor = Colors.textDisabled;
    

    
    [headerView.layoutUpdate.bottom.equalTo(lastView.mas_bottom) install];
    [headerView layoutIfNeeded];
    
    
    return headerView;
}

-(UIView*)buildFooter{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 100)];
    footerView.backgroundColor = UIColor.whiteColor;
    
    return footerView;
    
}

-(void)closePage{
    self.view.backgroundColor = UIColor.clearColor;
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)showLocation{
    [self.view makeToast:@"showLocation"];
}

-(void)attention{
     [self.view makeToast:@"attention"];
}

-(void)share{
     [self.view makeToast:@"share"];
}

-(void)applyNow{
    [self.view makeToast:@"applyNow"];
    
}

-(void)chageTab:(UIButton*)tab{
    currTabIndex = (int)tab.tag;
    [tableView reloadData];
}

#pragma mark UITableViewDelegate,UITableViewDataSource


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *sectionHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 60)];
    sectionHeaderView.backgroundColor = rgbHex(0xe6e6e6);
    
    UIButton *tab1 = sectionHeaderView.addButton;
    tab1.tag = 1;
    tab1.titleLabel.font = [Fonts regular:14];
    [tab1 setTitle:@"COMPANY" forState:UIControlStateNormal];
    [tab1 setTitleColor:rgbHex(0x1b1b1b) forState:UIControlStateNormal];
    [tab1 onClick:self action:@selector(chageTab:)];
    [[[[[tab1.layoutMaker widthEq:SCREENWIDTH / 3 ]topParent:2]bottomParent:0] centerXParent:0]install];
    [tab1 setBackgroundImage:[UIImage imageNamed:@"seg-bg"] forState:UIControlStateNormal];
    [tab1 setBackgroundImage:[UIImage imageNamed:@"seg-sel"] forState:UIControlStateSelected];
    tab1.selected = currTabIndex == 1;
    
    
    
    UIButton *tab0 = sectionHeaderView.addButton;
    tab0.tag = 0;
    tab0.titleLabel.font = [Fonts regular:14];
    [tab0 setTitle:@"DESCRIPTION" forState:UIControlStateNormal];
    [tab0 setTitleColor:rgbHex(0x1b1b1b) forState:UIControlStateNormal];
    [tab0 onClick:self action:@selector(chageTab:)];
    [[[[[tab0.layoutMaker toLeftOf:tab1 offset:0] leftParent:0] topParent:2]bottomParent:0] install];
    [tab0 setBackgroundImage:[UIImage imageNamed:@"seg-bg"] forState:UIControlStateNormal];
    [tab0 setBackgroundImage:[UIImage imageNamed:@"seg-sel"] forState:UIControlStateSelected];
    tab0.selected = currTabIndex == 0;
    
    
    UIButton *tab2 = sectionHeaderView.addButton;
    tab2.tag = 2;
    tab2.titleLabel.font = [Fonts regular:14];
    [tab2 setTitle:@"REVIEWS" forState:UIControlStateNormal];
    [tab2 setTitleColor:rgbHex(0x1b1b1b) forState:UIControlStateNormal];
    [tab2 onClick:self action:@selector(chageTab:)];
    [[[[[tab2.layoutMaker toRightOf:tab1 offset:0] rightParent:0]topParent:2]bottomParent:0] install];
    [tab2 setBackgroundImage:[UIImage imageNamed:@"seg-bg"] forState:UIControlStateNormal];
    [tab2 setBackgroundImage:[UIImage imageNamed:@"seg-sel"] forState:UIControlStateSelected];
    tab2.selected = currTabIndex == 2;
    
    
    return sectionHeaderView;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (currTabIndex) {
        case 0:
            return 1 ;
        case 1:
            return 1;
        case 2:
            return 60;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [UITableViewCell new];
    
    switch (currTabIndex) {
        case 0:
            return [self descriptionOfJobDetailCell:tableView data:self->jobModel];
            break;
        case 1:
            return [self companyOfJobDetailTableViewCell:tableView data:self->jobModel.company];
        case 2:
            cell.textLabel.text = @"ccccccc";
            break;
            
        default:
            break;
    }
    
   
    return cell;
}

-(UITableViewCell*)descriptionOfJobDetailCell:tableView data:(JobModel*)model{
    DescriptionOfJobDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DescriptionOfJobDetailTableViewCell"];
    if (cell == nil) {
        cell = [[DescriptionOfJobDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DescriptionOfJobDetailTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell setData:model];
    return cell;
}


-(UITableViewCell*)companyOfJobDetailTableViewCell:tableView data:(CompanyModel*)model{
    CompanyOfJobDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CompanyOfJobDetailTableViewCell"];
    if (cell == nil) {
        cell = [[CompanyOfJobDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CompanyOfJobDetailTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell setData:model];
    return cell;
}
@end
