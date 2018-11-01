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
    UIActivityIndicatorView *iv;
    
    UIRefreshControl *refreshControl;
    BOOL isRefreshing;
}
@end

@implementation ViewAllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = NO;
    UINavigationItem *item = self.navigationItem;
    item.title = @"ALL REVIEWS";
    item.leftBarButtonItem = [self navBarBack:self action:@selector(onBack:)];
    
    
    iv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    iv.tag = 998;
    iv.backgroundColor = [UIColor clearColor];
    iv.center = item.rightBarButtonItem.customView.center;
    item.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:iv];
    
    
    myTable = [UITableView new];
    [self.view addSubview:myTable];
    myTable.dataSource = self;
    myTable.delegate = self;
    myTable.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);

    [myTable layoutFill];
    
//    [self.contentView.layoutUpdate.bottom.greaterThanOrEqualTo(myTable) install];
//    myTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
//    // Do any additional setup after loading the view.
    
    [self setupRefresh];
    
}

-(void)setupRefresh{
    refreshControl=[[UIRefreshControl alloc]init];
    [refreshControl addTarget:self action:@selector(firstRefresh) forControlEvents:UIControlEventValueChanged];
    [myTable addSubview:refreshControl];
    [refreshControl beginRefreshing];
    
    [self firstRefresh];
}


- (void)showTopIndicator {
    iv.hidden = NO;
    [iv startAnimating];
    isRefreshing = YES;
}

- (void)hideTopIndicator {
    iv.hidden = YES;
    [iv stopAnimating];
    isRefreshing = NO;
}

-(void)firstRefresh{
    [self getDatas:NO];
    [refreshControl endRefreshing];
}


-(void)getDatas:(BOOL)isMore{
    if(isRefreshing){
        return;
    }
    
    [self showTopIndicator];
    backTask(^{
        NSArray<DiscussInfo*> *datas = [Proto queryAllCommentByConent:self.contentId skip:isMore?self->_discussInfo.count:0];
        foreTask(^{
            [self hideTopIndicator];
            [self reloadData:[datas copy]  isMore:isMore];
        });
    });
}

-(void)reloadData:(NSArray*)newDatas isMore:(BOOL)isMore{
    if(newDatas!=nil && newDatas.count >0){
        if(isMore){
            NSMutableArray *mutableArray = [[NSMutableArray alloc]initWithArray:self.discussInfo];
            [mutableArray addObjectsFromArray:newDatas];
            self.discussInfo = [mutableArray copy];
        }else{
            self.discussInfo = newDatas;
        }
        [myTable reloadData];
    }
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

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    // 下拉到最底部时显示更多数据
    if(!isRefreshing && scrollView.contentOffset.y > ((scrollView.contentSize.height - scrollView.frame.size.height))){
        [self getDatas:YES];
    }
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
