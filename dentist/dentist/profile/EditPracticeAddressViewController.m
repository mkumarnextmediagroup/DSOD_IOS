//
//  EditPracticeAddressViewController.m
//  dentist
//
//  Created by wennan on 2018/9/9.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "EditPracticeAddressViewController.h"
#import "EditWriteTableViewCell.h"
#import "CommSelectTableViewCell.h"
#import "UpdateViewController.h"
#import "Async.h"
#import "Common.h"
#import "Address.h"

@interface EditPracticeAddressViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *myTable;
    NSMutableArray *titleArray;
}
@end


@implementation EditPracticeAddressViewController

- (void)viewDidLoad {
    //cancel the gestrue to make sure the tableview can selected
    self.isCloseTheGesture = YES;
    
    [super viewDidLoad];
    
   
    UINavigationItem *item = self.navigationItem;
    item.title = localStr(@"editPractice");
    item.rightBarButtonItem = [self navBarText:@"SAVE" target: self  action:@selector(saveBtnClick:)];
    item.leftBarButtonItem = [self navBarImage:@"back_arrow"  target: self action:@selector(back)];
    // Do any additional setup after loading the view.
    
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
    [editBtn setTitle:@"Cancel" forState:UIControlStateNormal];
    [editBtn addTarget:self action:@selector(editBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [editBtn.titleLabel setFont:[Fonts semiBold:15]];
    [self.view addSubview:editBtn];
    [[[editBtn.layoutMaker sizeEq:SCREENWIDTH h:40] bottomParent:-20] install];
    
    
    titleArray = [NSMutableArray arrayWithObjects:@"Address 1", @"Address 2",@"Zip Code",@"City",@"State",nil];
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)saveBtnClick:(UIButton *)btn
{
    NSString *address=@"";
    address = strBuild(@"", @"", @"",@"",self.selectPracticeAddress);//TODO Simulation data
    if(_saveBtnClickBlock){
        if(self.selectPracticeAddress){//
            _saveBtnClickBlock(address);
        }
    }
    
    NSLog(@"save");
}

- (void)editBtnClick:(UIButton *)btn
{
    if ([btn.currentTitle isEqualToString:@"Cancel"])//this funcation is the same as back
    {
        [self back];
    }
}

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 76;
   
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row != titleArray.count-1) {
        
      
        static NSString *brand_region_Cell = @"editwriteCell";
        
        EditWriteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:brand_region_Cell];
        
        if (cell == nil) {
            cell = [[EditWriteTableViewCell alloc]
                    initWithStyle:UITableViewCellStyleDefault
                    reuseIdentifier:brand_region_Cell];
        }
        cell.titleLab.text=titleArray[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else
    {
        static NSString *brand_region_Cell = @"commCell";
        
        CommSelectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:brand_region_Cell];
        
        if (cell == nil) {
            cell = [[CommSelectTableViewCell alloc]
                    initWithStyle:UITableViewCellStyleDefault
                    reuseIdentifier:brand_region_Cell];
        }
        
        cell.titleLab.text=titleArray[indexPath.row];
        if (self.selectPracticeAddress != nil) {
            cell.contentLab.text = self.selectPracticeAddress;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == titleArray.count-1) {
        [self toSelectPracticeAddress];
    }
}

- (void)toSelectPracticeAddress
{
    
    UpdateViewController *update = [UpdateViewController new];
    update.titleStr=@"STATE";
     __weak typeof(self) weakSelf = self;
    update.selctBtnClickBlock = ^(NSString *code) {
        weakSelf.selectPracticeAddress = code;//TODO 是否为code？
        foreTask(^{
            [self->myTable reloadData];
        });
    };
    [self.navigationController pushViewController:update animated:YES];
    NSLog(@"selectPracticeAddress");
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
