//
//  ViewAllViewController.m
//  dentist
//
//  Created by Jacksun on 2018/10/17.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "ViewAllViewController.h"
#import "Common.h"
#import "DiscussTableViewCell.h"
#import "Proto.h"


@interface ViewAllViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *myTable;
}
@end

@implementation ViewAllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = NO;
    UINavigationItem *item = self.navigationItem;
    item.title = @"ALL REVIEWS";
    item.leftBarButtonItem = [self navBarBack:self action:@selector(onBack:)];
    
    
    myTable = [UITableView new];
    [self.contentView addSubview:myTable];
    myTable.dataSource = self;
    myTable.delegate = self;
    myTable.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [[[[[myTable layoutMaker] leftParent:0] rightParent:0] sizeEq:SCREENWIDTH h:SCREENHEIGHT] install];
    
//    [myTable layoutFill];
    
    [self.contentView.layoutUpdate.bottom.greaterThanOrEqualTo(myTable) install];
    myTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    // Do any additional setup after loading the view.
    
    
}

- (void)viewWillAppear:(BOOL)animated{

    backTask(^{
        NSArray<DiscussInfo*> *datas = [Proto queryAllCommentByConent:self.contentId];
        if(datas != nil && datas.count > 0){
            self.discussInfo = datas;
            foreTask(^{
                [self->myTable reloadData];
            });
        }
    });
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.discussInfo.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIden = @"cell";
    DiscussTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIden];
    if (cell == nil) {
        cell = [[DiscussTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIden];
    }
    cell.disInfo = self.discussInfo[indexPath.row];
    return cell;
    
}

- (void)onBack:(UIButton *)btn {
    [self.navigationController popViewControllerAnimated:YES];
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
