//
//  DSOProfilePage.m
//  dentist
//
//  Created by Jacksun on 2018/11/27.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "DSOProfilePage.h"
#import "Common.h"
#import "DSOProfileTableViewCell.h"
#import "CompanyDetailViewController.h"
#import "Proto.h"
#import "CompanyModel.h"
#import "CareerSearchViewController.h"
#import "JobDSOModel.h"
#import "AppDelegate.h"

@interface DSOProfilePage ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray<JobDSOModel *> *infoArr;
    UITableView *myTable;
    NSInteger pagenumber;
    BOOL isdownrefresh;
}
@end

@implementation DSOProfilePage

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    pagenumber=1;
    UINavigationItem *item = self.navigationItem;
    item.title = @"DSO PROFILES";
    item.leftBarButtonItem = [self navBarBack:self action:@selector(onBack:)];
//    item.rightBarButtonItem = [self navBarImage:@"searchWhite" target:self action:@selector(searchClick)];
    CGFloat _topBarH = 0;
    CGFloat _bottomBarH = 0;
    if (self.navigationController != nil) {
        _topBarH = NAVHEIGHT;
    }
    if (self.tabBarController != nil) {
        _bottomBarH = TABLEBAR_HEIGHT;
    }else{
        item.leftBarButtonItem = [self navBarImage:@"back_arrow" target:self action:@selector(backToFirst)];
    }
    
    myTable = [UITableView new];
    [self.view addSubview:myTable];
    myTable.dataSource = self;
    myTable.delegate = self;
    myTable.tableFooterView = [[UIView alloc]init];
    
    [[[[myTable.layoutMaker widthEq:SCREENWIDTH] topParent:_topBarH] bottomParent:-_bottomBarH] install];
    
    [self showCenterIndicator];
    [Proto queryCompanyList:pagenumber completed:^(NSArray<JobDSOModel *> *array, NSInteger totalCount) {
        foreTask(^{
            [self hideCenterIndicator];
            NSLog(@"%@",array);
            self->infoArr = array;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self->myTable reloadData];
            });
            
        });
    }];
    // Do any additional setup after loading the view.
}

- (void)backToFirst
{
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UITabBarController *tabvc=(UITabBarController *)appdelegate.careersPage;
    [tabvc setSelectedIndex:0];
    NSArray *viewcontrollers=self.navigationController.viewControllers;
    if (viewcontrollers.count>1) {
        if ([viewcontrollers objectAtIndex:viewcontrollers.count-1]==self) {
            //push方式
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    else{
        //present方式
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}

- (void)searchClick
{
    NSLog(@"search btn click");
//    UIViewController *viewController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
//    CareerSearchViewController *searchVC=[CareerSearchViewController new];
//    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:searchVC];
//    navVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//    [viewController presentViewController:navVC animated:YES completion:NULL];
        CareerSearchViewController *searchVC=[CareerSearchViewController new];
        [self.navigationController pushViewController:searchVC animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return infoArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIden = @"cell";
    DSOProfileTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIden];
    if (cell == nil) {
        cell = [[DSOProfileTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIden];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [cell bindInfo:infoArr[indexPath.row]];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    UIViewController *viewController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    if (infoArr.count >indexPath.row) {
        [CompanyDetailViewController openBy:self companyId:infoArr[indexPath.row].id];
    }
    
}

- (void)onBack:(UIButton *)btn {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:myTable]) {
        CGFloat height = scrollView.frame.size.height;
        CGFloat contentOffsetY = scrollView.contentOffset.y;
        CGFloat consizeheight=scrollView.contentSize.height;
        CGFloat bottomOffset = (consizeheight - contentOffsetY);
        
        if (contentOffsetY+height>consizeheight+50   && contentOffsetY>0)
        {
            NSLog(@"==================================下啦刷选;contentOffsetY=%@;consizeheight=%@;bottomOffset=%@;height=%@；",@(contentOffsetY),@(consizeheight),@(bottomOffset),@(height));
            if (!isdownrefresh) {
                
                isdownrefresh=YES;
                [self showCenterIndicator];
                [Proto queryCompanyList:(pagenumber+1) completed:^(NSArray<JobDSOModel *> *array, NSInteger totalCount) {
                    self->isdownrefresh=NO;
                    foreTask(^{
                        [self hideCenterIndicator];
                        NSLog(@"%@",array);
                        if(array && array.count>0){
                            self->pagenumber++;
                            NSMutableArray *temparr=[NSMutableArray arrayWithArray:self->infoArr];
                            [temparr addObjectsFromArray:array];
                            self->infoArr=[temparr copy];
                            [self->myTable reloadData];
                        }
                        
                        
                    });
                }];
                
            }
            
        }
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
