//
//  EditEduViewController.m
//  dentist
//
//  Created by Jacksun on 2018/9/3.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "EditEduViewController.h"
#import "SwitchTableViewCell.h"
#import "CommSelectTableViewCell.h"
#import "UpdateViewController.h"
#import "PickerViewController.h"

@interface EditEduViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *myTable;
    BOOL        isSwitchOn;
    NSString    *selectStr;//picker select the string
}
@end

@implementation EditEduViewController

- (void)viewDidLoad {
    
    self.isCloseTheGesture = YES;
    
    [super viewDidLoad];
    
    isSwitchOn = YES;
    UINavigationItem *item = self.navigationItem;
    item.title = @"editEdu";
    item.rightBarButtonItem = [self navBarText:@"SAVE" target: self  action:@selector(saveBtnClick:)];
    item.leftBarButtonItem = [self navBarImage:@"back_arrow"  target: self action:@selector(back)];
    // Do any additional setup after loading the view.
    
    myTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    myTable.delegate = self;
    myTable.dataSource = self;
    myTable.tableFooterView =  [[UIView alloc] init];
    myTable.separatorInset =UIEdgeInsetsZero;
    [self.view addSubview:myTable];
    [[[[[myTable.layoutMaker leftParent:0] rightParent:0] topParent:0] bottomParent:0] install];
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)saveBtnClick:(UIButton *)btn
{
    NSLog(@"save");
}

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 49;
    }else
    {
        return 76;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        static NSString *brand_region_Cell = @"switchCell";
        
        SwitchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:brand_region_Cell];
        
        if (cell == nil) {
            cell = [[SwitchTableViewCell alloc]
                    initWithStyle:UITableViewCellStyleDefault
                    reuseIdentifier:brand_region_Cell];
        }
        
        [cell.onSwitch addTarget:self action:@selector(switchClick:) forControlEvents:UIControlEventValueChanged];
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
        
        if (indexPath.row == 1)
        {
            if (isSwitchOn)//can select the school
            {
                [cell.imageBtn setImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateNormal];
                cell.contentField.hidden = YES;
                cell.contentLab.hidden = NO;
            }
            else
            {
                [cell.imageBtn setImage:[UIImage imageNamed:@"write"] forState:UIControlStateNormal];
                cell.contentField.hidden = NO;
                cell.contentLab.hidden = YES;
            }
        }else
        {
            cell.titleLab.text = localStr(@"graduation");
            if (selectStr != nil) {
                cell.contentLab.text = selectStr;
            }
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1 && isSwitchOn) {
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

- (void)switchClick:(UISwitch *)mySwitch
{
    if (mySwitch.on) {
        NSLog(@"on press");
        isSwitchOn = YES;
    }
    else{
        NSLog(@"off press");
        isSwitchOn = NO;
    }
    [myTable reloadData];

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
