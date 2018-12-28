//
//  DSOProfileSearchPage.m
//  dentist
//
//  Created by Jacksun on 2018/12/24.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "DSOProfileSearchPage.h"
#import "Proto.h"
#import "UIViewController+myextend.h"
#import "JobDSOModel.h"
#import "DSOProfileTableViewCell.h"
#import "CompanyDetailViewController.h"
#import "CompanyExistsReviewsTableViewCell.h"
#import "CompanyReviewsViewController.h"
#import "UITableView+JRTableViewPlaceHolder.h"

@interface DSOProfileSearchPage ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITextField *searchField;
    UITableView *myTable;
    NSArray<JobDSOModel *> *searchInfoArr;
    
    NSInteger pagenumber;
}
@end

@implementation DSOProfileSearchPage

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINavigationItem *item = [self navigationItem];
    self.view.backgroundColor = rgb255(246, 245, 245);
    item.rightBarButtonItem= [self navBarText:@" Search" target:self action:@selector(searchBtnClick)];
    item.leftBarButtonItem = [self navBarBack:self action:@selector(onBack:)];
    [self createTableviewAndSearchField:item];
    pagenumber=1;
    // Do any additional setup after loading the view.
}

- (void)searchBtnClick
{
    [searchField resignFirstResponder];
    [self showLoading];
    [Proto queryCompanyList:pagenumber searchValue:searchField.text completed:^(NSArray<JobDSOModel *> *array, NSInteger totalCount) {
        foreTask(^{
            [self hideLoading];
            NSLog(@"%@",array);
            self->searchInfoArr = array;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self->myTable reloadData];
            });
            
        });
    }];
}

- (void)onBack:(UIButton *)btn {
    
    [searchField resignFirstResponder];
    [self.navigationController popViewControllerAnimated:NO];

}


- (void)createTableviewAndSearchField:(UINavigationItem *)item
{
    searchField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 240, 32)];//[_searchBar valueForKey:@"_searchField"];//更改searchBar 中PlaceHolder 字体颜色
    searchField.textColor= [UIColor grayColor];
    UIButton *leftBtn = [UIButton new];
    [leftBtn setImage:[UIImage imageNamed:@"searchIcon"] forState:UIControlStateNormal];
    leftBtn.frame = CGRectMake(0, 0, 40, 32);
    searchField.leftView = leftBtn;
    searchField.leftViewMode =UITextFieldViewModeAlways;
    searchField.font = [UIFont systemFontOfSize:14];
    searchField.layer.masksToBounds = YES;
    searchField.layer.cornerRadius = 5;
    searchField.delegate = self;
    searchField.tintColor = [UIColor grayColor];
    [searchField becomeFirstResponder];
    searchField.returnKeyType = UIReturnKeySearch;
    searchField.clearButtonMode = UITextFieldViewModeWhileEditing;
    searchField.backgroundColor = [UIColor whiteColor];
    item.titleView=searchField;
    
    myTable = [UITableView new];
    [self.view addSubview:myTable];
    myTable.dataSource = self;
    myTable.delegate = self;
    myTable.estimatedRowHeight = 10;
    myTable.rowHeight=UITableViewAutomaticDimension;
    [myTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    myTable.backgroundColor = rgb255(246, 245, 245);
    [[[myTable.layoutMaker sizeEq:SCREENWIDTH h:SCREENHEIGHT-NAVHEIGHT] topParent:NAVHEIGHT] install];
    
    [self createEmptyNotice];
}

- (void)createEmptyNotice
{
    [myTable jr_configureWithPlaceHolderBlock:^UIView * _Nonnull(UITableView * _Nonnull sender) {
        [self->myTable setScrollEnabled:NO];
        UIView *headerVi = [UIView new];
        headerVi.backgroundColor = [UIColor clearColor];
        UIButton *headBtn = headerVi.addButton;
        [headBtn setImage:[UIImage imageNamed:@"noresult_search"] forState:UIControlStateNormal];
        headBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        headBtn.titleLabel.font = [Fonts regular:13];
        [[[headBtn.layoutMaker centerXParent:0] topParent:135] install];
        
        UILabel *tipLabel= headerVi.addLabel;
        tipLabel.textAlignment=NSTextAlignmentCenter;
        tipLabel.numberOfLines=0;
        tipLabel.font = [Fonts semiBold:16];
        tipLabel.textColor =[UIColor blackColor];
        if (self.isDSOProfile)
        {
            tipLabel.text=@"No results found. \n Try another DSO/ \n company";
        }else
        {
            tipLabel.text=@"No results found.";
        }
        [[[[tipLabel.layoutMaker leftParent:20] rightParent:-20] below:headBtn offset:50] install];
        return headerVi;
    } normalBlock:^(UITableView * _Nonnull sender) {
        [self->myTable setScrollEnabled:YES];
    }];
}

#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self searchBtnClick];
    return YES;
}

#pragma mark UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return searchInfoArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isDSOProfile)
    {
        return 80;
    }else
    {
        return UITableViewAutomaticDimension;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isDSOProfile) {
        NSString *cellIden = @"cell";
        DSOProfileTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIden];
        if (cell == nil) {
            cell = [[DSOProfileTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIden];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [cell bindInfo:searchInfoArr[indexPath.row]];
        return cell;
    }else
    {
        
        NSString *cellIden = @"cellIden";
        CompanyExistsReviewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIden];
        if (cell == nil) {
            cell = [[CompanyExistsReviewsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIden];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [cell setData:searchInfoArr[indexPath.row]];
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.isDSOProfile) {
        if (searchInfoArr.count >indexPath.row) {
            [CompanyDetailViewController openBy:self companyId:searchInfoArr[indexPath.row].id];
        }

    }else
    {
        [CompanyReviewsViewController openBy:self jobDSOModel:searchInfoArr[indexPath.row]];
    }
    
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
