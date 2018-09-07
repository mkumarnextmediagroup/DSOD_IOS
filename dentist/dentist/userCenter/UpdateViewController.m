//
//  UpdateViewController.m
//  dentist
//
//  Created by Jacksun on 2018/9/1.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "UpdateViewController.h"
#import "UpdateTableViewCell.h"
#import "UISearchBarView.h"

@interface UpdateViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarViewDelegate>
{
    UISearchBarView *searchBar;
    UITableView *myTable;
    NSInteger  indexPathRow;
}
@property (strong, nonatomic)NSArray *infoArr;
@end

@implementation UpdateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINavigationItem *item = self.navigationItem;
    item.title = @"STATE";
    item.leftBarButtonItem = [self navBarImage:@"back_arrow"  target: self  action:@selector(popBtnClick:)];
    
    searchBar = self.view.createSearchBar;
    searchBar.delegate = self;
    [searchBar layoutCenterXOffsetTop:SCREENWIDTH height:57 offset:NAVHEIGHT];
    
    myTable = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(searchBar.frame), SCREENWIDTH, SCREENHEIGHT - NAVHEIGHT - 60) style:UITableViewStylePlain];
    myTable.separatorInset =UIEdgeInsetsZero;
    myTable.delegate = self;
    myTable.dataSource = self;
    myTable.tableFooterView =  [[UIView alloc] init];
    [self.view addSubview:myTable];
    // Do any additional setup after loading the view.
}

- (NSArray *)infoArr
{
    _infoArr = [NSArray arrayWithObjects:@"General Practitioner",@"Dental Public Health",@"Endodontics",@"Oral & Maxillofacial Pathology",@"Oral & Maxillofacial Radiology",@"Oral & Maxillofacial Surgery",@"Orthodontics",@"Pediatric Dentistry",@"Periodontics",@"Prosthodontics", nil];
    return _infoArr;
}

- (void)popBtnClick:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark UITableviewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.infoArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *brand_region_Cell = @"Cell";
    
    UpdateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:brand_region_Cell];
    
    if (cell == nil)
    {
        cell = [[UpdateTableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:brand_region_Cell];
    }
    
    cell.textLabel.text = self.infoArr[indexPath.row];
    
    [cell.selectBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    if (indexPathRow == indexPath.row) {
        // 如果是当前cell
        [cell.selectBtn setImage:[UIImage imageNamed:@"select"] forState:UIControlStateNormal];

    }else{

        [cell.selectBtn setImage:[UIImage imageNamed:@"unSelect"] forState:UIControlStateNormal];

    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)selectBtnClick:(UIButton *)btn
{
    // 通过button计算出其所在的cell
    UpdateTableViewCell * cell = (UpdateTableViewCell *)[btn superview];
    NSIndexPath * path = [myTable indexPathForCell:cell];
    
    // 刷新数据源方法
    [myTable reloadData];
    
    // 记录下当前的IndexPath.row
    indexPathRow = path.row;
}

- (void)updateTheSearchText:(NSString *)fieldTest
{
    NSLog(@"%@",fieldTest);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
