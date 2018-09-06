//
//  EditResidencyViewController.m
//  dentist
//
//  Created by Jacksun on 2018/9/6.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "EditResidencyViewController.h"
#import "CommSelectTableViewCell.h"
#import "UpdateViewController.h"
#import "PickerViewController.h"

@interface EditResidencyViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *myTable;
    NSString    *selectStr;
}
@end

@implementation EditResidencyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINavigationItem *item = self.navigationItem;
    item.title = self.titleStr;
    item.rightBarButtonItem = [self navBarText:@"SAVE" target: self  action:@selector(saveBtnClick:)];
    item.leftBarButtonItem = [self navBarImage:@"back_arrow"  target: self action:@selector(back)];
    
    myTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    myTable.backgroundColor = UIColor.whiteColor;
    myTable.delegate = self;
    myTable.dataSource = self;
    myTable.tableFooterView =  [[UIView alloc] init];
    myTable.separatorInset =UIEdgeInsetsZero;
    [self.view addSubview:myTable];
    [[[[[myTable.layoutMaker leftParent:0] rightParent:0] topParent:0] bottomParent:0] install];

    UIButton *editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [editBtn setTitleColor:Colors.textDisabled forState:UIControlStateNormal];
    [editBtn setTitle:self.btnTitle forState:UIControlStateNormal];
    [editBtn addTarget:self action:@selector(editBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [editBtn.titleLabel setFont:[Fonts semiBold:15]];
    [self.view addSubview:editBtn];
    [[[editBtn.layoutMaker sizeEq:SCREENWIDTH h:40] bottomParent:-20] install];
    
    // Do any additional setup after loading the view.
}

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 76;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *brand_region_Cell = @"commCell";
    
    CommSelectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:brand_region_Cell];
    
    if (cell == nil) {
        cell = [[CommSelectTableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:brand_region_Cell];
    }
    
    if (indexPath.row == 0)
    {
        cell.titleLab.text = @"Residency at";
    }
    else
    {
        cell.titleLab.text = @"Year of completion";
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        UpdateViewController *update = [UpdateViewController new];
        [self.navigationController pushViewController:update animated:YES];
    }else if (indexPath.row == 2)
    {
        PickerViewController *picker = [[PickerViewController alloc] init];
        picker.infoArr = [NSArray arrayWithObjects:@"2013",@"2014", @"2015",@"2016",@"2017",@"2018",nil];
        picker.pickerSelectBlock = ^(NSString *pickerSelect){
            self->selectStr = pickerSelect;
            [self->myTable reloadData];
        };
        picker.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        picker.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        picker.providesPresentationContextTransitionStyle = YES;
        picker.definesPresentationContext = YES;
        [self presentViewController:picker animated:YES completion:nil];
        [picker showPicker];
        
    }
}

- (void)editBtnClick:(UIButton *)btn
{
    if ([btn.currentTitle isEqualToString:@"Cancel"])//this funcation is the same as back
    {
        [self back];
    }else
    {
        
    }
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)saveBtnClick:(UIButton *)btn
{
    NSLog(@"save");
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
