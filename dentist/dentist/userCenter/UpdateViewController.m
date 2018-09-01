//
//  UpdateViewController.m
//  dentist
//
//  Created by Jacksun on 2018/9/1.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "UpdateViewController.h"
#import "UpdateTableViewCell.h"

@interface UpdateViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation UpdateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTopTitle:@"STATE" bgColor:[Colors bgNavBarColor] imageName:nil];
    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, NAVHEIGHT, SCREENWIDTH, 60)];
    UITextField *field = [searchBar.subviews firstObject].subviews.lastObject;
    field.backgroundColor = [UIColor whiteColor];
    [searchBar setPlaceholder:@"Search ..."];
    [searchBar setBarStyle:UIBarStyleDefault];
    [self.view addSubview:searchBar];
    
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(searchBar.frame), SCREENWIDTH, SCREENHEIGHT - NAVHEIGHT - 60) style:UITableViewStylePlain];
    [self.view addSubview:table];
    // Do any additional setup after loading the view.
}

#pragma mark UITableviewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
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
    
    cell.textLabel.text = @"General Practitioner";
    
    [cell.selectBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    return cell;
}

- (void)selectBtnClick:(UIButton *)btn
{
    [btn setImage:[UIImage imageNamed:@"select"] forState:UIControlStateNormal];
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
