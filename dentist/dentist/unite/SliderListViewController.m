//
//  SliderListViewController.m
//  dentist
//
//  Created by Jacksun on 2018/11/5.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "SliderListViewController.h"
#import "Common.h"
#import "UniteArticleTableViewCell.h"

@interface SliderListViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *mTableView;
}
@end

@implementation SliderListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *navVi = [self makeNavView];
    
    mTableView = [UITableView new];
    mTableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    mTableView.dataSource = self;
    mTableView.delegate = self;
    [self.view addSubview:mTableView];
    [[[[[navVi.layoutMaker leftParent:0] topParent:0] rightParent:0] heightEq:NAVHEIGHT] install];
    [[[[[mTableView.layoutMaker leftParent:0] rightParent:0] below:navVi offset:0] heightEq:SCREENHEIGHT - NAVHEIGHT] install];
    // Do any additional setup after loading the view.
}

- (UIView *)makeNavView
{
    UIView *vi = [self.view addView];
    vi.backgroundColor = Colors.bgNavBarColor;
    return vi;
}

- (UIView *)headerView{
    
    UIView *headerVi = [UIView new];
    
    UILabel *issueLabel = headerVi.addLabel;
    issueLabel.text = @"Vol1 No1";
    issueLabel.font = [Fonts regular:14];
    [[[[[issueLabel.layoutMaker leftParent:30] rightParent:30] heightEq:84] topParent:0] install];
    
    UILabel *line1 = headerVi.addLabel;
    line1.textColor = [Colors cellLineColor];
    [[[[[line1.layoutMaker leftParent:0] rightParent:0] heightEq:1] below:issueLabel offset:0] install];
    
    UILabel *editLabel = headerVi.addLabel;
    editLabel.text = @"From the editor";
    editLabel.font = [Fonts regular:14];
    [[[[[editLabel.layoutMaker leftParent:30] rightParent:30] heightEq:84] below:line1 offset:0] install];
    
    UILabel *line2 = headerVi.addLabel;
    line2.textColor = [Colors cellLineColor];
    [[[[[line2.layoutMaker leftParent:0] rightParent:0] heightEq:1] below:editLabel offset:0] install];
    
    UIButton *headBtn = headerVi.addButton;
    [headBtn setTitleColor:Colors.textAlternate forState:UIControlStateNormal];
    headBtn.titleLabel.text = @"in this Issue";
    headBtn.titleLabel.font = [Fonts regular:12];
    [[[[[headBtn.layoutMaker leftParent:30] rightParent:30] heightEq:20] topParent:12] install];
    
    return headerVi;
}

#pragma mark UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 242;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [self headerView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 156;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIden = @"cell";
    UniteArticleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIden];
    if (cell == nil) {
        cell = [[UniteArticleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIden];
    }
    
    return cell;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
