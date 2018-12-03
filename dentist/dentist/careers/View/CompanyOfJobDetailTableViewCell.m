//
//  CompanyOfJobDetailTableViewCell.m
//  dentist
//
//  Created by Shirley on 2018/11/29.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "CompanyOfJobDetailTableViewCell.h"
#import "common.h"
#import "CompanyModel.h"
#import "FindJobsTableViewCell.h"

@interface CompanyOfJobDetailTableViewCell()<UITableViewDelegate,UITableViewDataSource,JobsTableCellDelegate>

@end
@implementation CompanyOfJobDetailTableViewCell {
    UILabel *websiteValueLabel;
    UILabel *yearOfFoundationValueLabel;
    UILabel *numOfEmployeesValueLabel;
    UILabel *stageValueLabel;
    UILabel *contactPersonValueLabel;
    UILabel *detailValueLabel;

    int edge;
    UITableView *myTable;
    UILabel *jobCountTitle;
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        edge = 18;
        [self buildTable];
    }
    return self;
}

-(void)buildTable
{
    myTable = [UITableView new];
    [self.contentView addSubview:myTable];
    myTable.dataSource = self;
    myTable.delegate = self;
    myTable.rowHeight = UITableViewAutomaticDimension;
    myTable.estimatedRowHeight = 100;
    [myTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    myTable.tableHeaderView=[self makeHeaderView];
    [myTable registerClass:[FindJobsTableViewCell class] forCellReuseIdentifier:NSStringFromClass([FindJobsTableViewCell class])];
    
    [[[myTable.layoutMaker sizeEq:SCREENWIDTH h:SCREENHEIGHT-NAVHEIGHT] topParent:0] install];
}

-(void)setTotalCount:(NSInteger)totalCount{
    _totalCount=totalCount;
    if (_totalCount>0) {
        NSString *jobcountstr=[NSString stringWithFormat:@"%@Jobs",@(_totalCount)];
        NSString *jobstr=[NSString stringWithFormat:@"%@ | 5 New",jobcountstr];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:jobstr];
        [str addAttribute:NSForegroundColorAttributeName value:Colors.textMain range:NSMakeRange(0,jobcountstr.length+2)];
        [str addAttribute:NSForegroundColorAttributeName value:Colors.textDisabled range:NSMakeRange(jobcountstr.length+2,jobstr.length - (jobcountstr.length+2))];
        jobCountTitle.attributedText = str;
    }else{
        jobCountTitle.text=@"";
    }
}

-(void)setInfoArr:(NSMutableArray *)infoArr
{
    _infoArr=infoArr;
    [self->myTable reloadData];
}

- (UIView *)makeHeaderView {
    UIView *panel = [UIView new];
    panel.frame = makeRect(0, 0, SCREENWIDTH, 32);
    panel.backgroundColor=[UIColor clearColor];
    
    jobCountTitle=panel.addLabel;
    jobCountTitle.font=[Fonts semiBold:13];
    [[[[[jobCountTitle.layoutMaker leftParent:20] topParent:0] bottomParent:0] rightParent:40] install];
    
    UIButton *filterButton = [panel addButton];
    [filterButton setImage:[UIImage imageNamed:@"desc"] forState:UIControlStateNormal];
    [[[[filterButton.layoutMaker topParent:4] rightParent:-15] sizeEq:24 h:24] install];
    [filterButton onClick:self action:@selector(clickFilter:)];
    return panel;
}

-(void)clickFilter:(UIButton *)sender
{
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _infoArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FindJobsTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([FindJobsTableViewCell class]) forIndexPath:indexPath];
    cell.delegate=self;
    cell.indexPath=indexPath;
    if (_infoArr && _infoArr.count>indexPath.row) {
        cell.info=_infoArr[indexPath.row];
    }
    return cell;
    
    
    
}

-(void)buildView{
    
    //Website
    UILabel *websiteLabel = self.addLabel;
    websiteLabel.text = @"Website";
    websiteLabel.font = [Fonts regular:16];
    websiteLabel.numberOfLines = 1;
    [[[[websiteLabel.layoutMaker leftParent:edge]topParent:0] sizeEq:70 h:50]install];
    
    
    websiteValueLabel = self.addLabel;
    websiteValueLabel.textColor = Colors.textDisabled;
    websiteValueLabel.font = [Fonts regular:16];
    websiteValueLabel.textAlignment = NSTextAlignmentRight;
    websiteValueLabel.lineBreakMode = NSLineBreakByCharWrapping;
    websiteValueLabel.numberOfLines = 3;
    [[[[websiteValueLabel.layoutMaker toRightOf:websiteLabel offset:0]rightParent:-edge]  centerYOf:websiteLabel offset:0] install];
    
    
    
    //Year of Foundation
    UILabel *yearOfFoundationLabel = self.addLabel;
    yearOfFoundationLabel.text = @"Year of Foundation";
    yearOfFoundationLabel.font = [Fonts regular:16];
    [[[[yearOfFoundationLabel.layoutMaker leftParent:edge]below:websiteLabel offset:0]heightEq:50]install];
    
    yearOfFoundationValueLabel = self.addLabel;
    yearOfFoundationValueLabel.textColor = Colors.textDisabled;
    yearOfFoundationValueLabel.font = [Fonts regular:16];
    yearOfFoundationValueLabel.textAlignment = NSTextAlignmentRight;
    [[[[[yearOfFoundationValueLabel.layoutMaker toRightOf:yearOfFoundationLabel offset:edge]below:websiteLabel offset:0]rightParent:-edge] heightEq:50]install];
    
    //No. of Employees
    UILabel *numOfEmployeesLabel = self.addLabel;
    numOfEmployeesLabel.text = @"No. of Employees";
    numOfEmployeesLabel.font = [Fonts regular:16];
    [[[[numOfEmployeesLabel.layoutMaker leftParent:edge]below:yearOfFoundationLabel offset:0]heightEq:50]install];
    
    numOfEmployeesValueLabel = self.addLabel;
    numOfEmployeesValueLabel.textColor = Colors.textDisabled;
    numOfEmployeesValueLabel.font = [Fonts regular:16];
    numOfEmployeesValueLabel.textAlignment = NSTextAlignmentRight;
    [[[[[numOfEmployeesValueLabel.layoutMaker toRightOf:numOfEmployeesLabel offset:edge]below:yearOfFoundationLabel offset:0]rightParent:-edge] heightEq:50]install];
    
    //Stage
    UILabel *stageLabel = self.addLabel;
    stageLabel.text = @"Stage";
    stageLabel.font = [Fonts regular:16];
    [[[[stageLabel.layoutMaker leftParent:edge]below:numOfEmployeesLabel offset:0]heightEq:50]install];
    
    stageValueLabel = self.addLabel;
    stageValueLabel.textColor = Colors.textDisabled;
    stageValueLabel.font = [Fonts regular:16];
    stageValueLabel.textAlignment = NSTextAlignmentRight;
    [[[[[stageValueLabel.layoutMaker toRightOf:stageLabel offset:edge]below:numOfEmployeesLabel offset:0]rightParent:-edge] heightEq:50]install];
    
    //Contact Person
    UILabel *contactPersonLabel = self.addLabel;
    contactPersonLabel.text = @"Contact Person";
    contactPersonLabel.font = [Fonts regular:16];
    [[[[contactPersonLabel.layoutMaker leftParent:edge]below:stageLabel offset:0]heightEq:50]install];
    
    contactPersonValueLabel = self.addLabel;
    contactPersonValueLabel.textColor = Colors.textDisabled;
    contactPersonValueLabel.font = [Fonts regular:16];
    contactPersonValueLabel.textAlignment = NSTextAlignmentRight;
    [[[[[contactPersonValueLabel.layoutMaker toRightOf:contactPersonLabel offset:edge]below:stageLabel offset:0]rightParent:-edge] heightEq:50]install];
    
    
    //Details
    UILabel *detailLabel = self.addLabel;
    detailLabel.text = @"Details";
    detailLabel.font = [Fonts regular:16];
    detailLabel.textColor = rgbHex(0xb3b9bd);
    [[[[detailLabel.layoutMaker leftParent:edge]rightParent:-edge] below:contactPersonLabel offset:0]install];
    
    detailValueLabel = self.addLabel;
    detailValueLabel.font = [Fonts regular:16];
    [[[[[detailValueLabel.layoutMaker leftParent:edge] rightParent:-edge] below:detailLabel offset:0]bottomParent:-edge] install];
    
}


- (void)setData:(CompanyModel *)model{
    
    
    websiteValueLabel.text = model.webSiteUrl;
    yearOfFoundationValueLabel.text =  model.foundingTime;
    //model.employees 服务返回的值为null 不是int类型
//    numOfEmployeesValueLabel.text = [NSString stringWithFormat:@"%d",model.employees];
    stageValueLabel.text = model.stage;
    contactPersonValueLabel.text = model.contactPerson;
    detailValueLabel.text = model.companyDesc;
    
}


@end
