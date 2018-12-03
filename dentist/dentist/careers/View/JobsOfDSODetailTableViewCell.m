//
//  JobsOfDSODetailTableViewCell.m
//  dentist
//
//  Created by Shirley on 2018/12/3.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "JobsOfDSODetailTableViewCell.h"
#import "common.h"
#import "FindJobsTableViewCell.h"

@interface JobsOfDSODetailTableViewCell()<UITableViewDelegate,UITableViewDataSource,JobsTableCellDelegate>

@end

@implementation JobsOfDSODetailTableViewCell{
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

@end
