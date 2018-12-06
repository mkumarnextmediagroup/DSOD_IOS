//
//  CareerSearchViewController.m
//  dentist
//
//  Created by feng zhenrong on 2018/12/3.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "CareerSearchViewController.h"
#import "Proto.h"
#import "FindJobsTableViewCell.h"
#import "FindJobsSponsorTableViewCell.h"
#import "DSODetailPage.h"
#import "UIViewController+myextend.h"
#import "DsoToast.h"
#import "CareerJobDetailViewController.h"
#import "AppDelegate.h"

@interface CareerSearchViewController ()<UITableViewDelegate,UITableViewDataSource,JobsTableCellDelegate,UIScrollViewDelegate,UISearchBarDelegate,UISearchControllerDelegate,UISearchResultsUpdating>
{
    NSMutableArray *infoArr;
    UITableView *myTable;
    UILabel *jobCountTitle;
    BOOL isdownrefresh;
    UISearchController *searchController;
    NSString *searchKeywords;
}
/*** searchbar ***/
@property (nonatomic,strong) UISearchBar *searchBar;
@end

@implementation CareerSearchViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UINavigationItem *item = [self navigationItem];
    item.rightBarButtonItem=nil;
    item.leftBarButtonItem = [self navBarImage:@"menu" target:self action:@selector(onBack:)]; //[self navBarBack:self action:@selector(onBack:)];
//    item.leftBarButtonItem=nil;//hidden left menu
//    searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
//    searchController.searchResultsUpdater=self;
//    searchController.searchBar.autocapitalizationType=UITextAutocapitalizationTypeNone;
//    searchController.delegate = self;
//    searchController.dimsBackgroundDuringPresentation = NO; // The default is true.
//    searchController.searchBar.delegate = self;
//
//    if (@available(iOS 11.0, *)) {
//        // For iOS 11 and later, place the search bar in the navigation bar.
//        item.searchController=searchController;
//
//        // Make the search bar always visible.
//        item.hidesSearchBarWhenScrolling = NO;
//    } else {
//        // For iOS 10 and earlier, place the search controller's search bar in the table view's header.
//        item.titleView=searchController.searchBar;
//    }
    
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectZero];
    _searchBar.placeholder = @"Search...";
    _searchBar.delegate = self;
    _searchBar.showsCancelButton=NO;
    [_searchBar becomeFirstResponder];
    for (id obj in [_searchBar subviews]) {
        if ([obj isKindOfClass:[UIView class]]) {
            for (id obj2 in [obj subviews]) {
                if ([obj2 isKindOfClass:[UIButton class]]) {
                    UIButton *btn = (UIButton *)obj2;
                    [btn setTitle:@"Cancel" forState:UIControlStateNormal];
                }
            }
        }
    }
    item.titleView=_searchBar;
    if (@available(iOS 11.0, *)) {
        [[_searchBar.heightAnchor constraintEqualToConstant:44.0] setActive:YES];
    }
    myTable = [UITableView new];
    [self.view addSubview:myTable];
    myTable.dataSource = self;
    myTable.delegate = self;
    myTable.rowHeight = UITableViewAutomaticDimension;
    myTable.estimatedRowHeight = 100;
    [myTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [myTable registerClass:[FindJobsTableViewCell class] forCellReuseIdentifier:NSStringFromClass([FindJobsTableViewCell class])];
    [myTable registerClass:[FindJobsSponsorTableViewCell class] forCellReuseIdentifier:NSStringFromClass([FindJobsSponsorTableViewCell class])];
    
    [[[myTable.layoutMaker sizeEq:SCREENWIDTH h:SCREENHEIGHT-NAVHEIGHT-TABLEBAR_HEIGHT] topParent:NAVHEIGHT] install];
   
}

- (void)onBack:(UIButton *)btn {
    
    [self.searchBar resignFirstResponder];
    _searchBar.showsCancelButton = NO;
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return infoArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row<=1) {
        FindJobsSponsorTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([FindJobsSponsorTableViewCell class]) forIndexPath:indexPath];
        cell.delegate=self;
        cell.indexPath=indexPath;
        if (self->infoArr && self->infoArr.count>indexPath.row) {
            if (indexPath.row<=4) {
                cell.isNew=YES;
            }else{
                cell.isNew=NO;
            }
            cell.info=self->infoArr[indexPath.row];
        }
        return cell;
    }else{
        FindJobsTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([FindJobsTableViewCell class]) forIndexPath:indexPath];
        cell.delegate=self;
        cell.indexPath=indexPath;
        if (self->infoArr && self->infoArr.count>indexPath.row) {
            
            
            if (indexPath.row<=4) {
                cell.isNew=YES;
            }else{
                cell.isNew=NO;
            }
            cell.info=self->infoArr[indexPath.row];
        }
        return cell;
    }
    
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    JobModel *jobModel = infoArr[indexPath.row];
    [CareerJobDetailViewController presentBy:self jobId:jobModel.id closeBack:^{
        foreTask(^{
            if (self->myTable) {
                [self->myTable reloadData];
            }
        });
        
    }];
}

#pragma mark ---UISearchBarDelegate
//MARK:dismiss button clicked，do this method
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    self.searchBar.text=@"";
    [self.searchBar resignFirstResponder];
    _searchBar.showsCancelButton = NO;
    [self dismissViewControllerAnimated:YES completion:nil];
}
//MARK:keyboard search button clicked，do this method
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    searchKeywords=searchBar.text;
    [self.searchBar resignFirstResponder];
    _searchBar.showsCancelButton = NO;

    [self showIndicator];
    [Proto queryAllJobs:0 jobTitle:searchKeywords completed:^(NSArray<JobModel *> *array, NSInteger totalCount) {
        foreTask(^{
            [self hideIndicator];
            self->infoArr = [NSMutableArray arrayWithArray:array];
            [self->myTable reloadData];
        });
    }];
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat height = scrollView.frame.size.height;
    CGFloat contentOffsetY = scrollView.contentOffset.y;
    CGFloat consizeheight=scrollView.contentSize.height;
    CGFloat bottomOffset = (consizeheight - contentOffsetY);
    if (bottomOffset <= height-50 && contentOffsetY>0)
    {
        NSLog(@"==================================下啦刷选;bottomOffset=%@;height-50=%@",@(bottomOffset),@(height-50));
        if (!isdownrefresh) {
            isdownrefresh=YES;
            [self showIndicator];
            [Proto queryAllJobs:self->infoArr.count jobTitle:searchKeywords completed:^(NSArray<JobModel *> *array, NSInteger totalCount) {
                self->isdownrefresh=NO;
                foreTask(^{
                    [self hideIndicator];
                    NSLog(@"%@",array);
                    if(array && array.count>0){
                        [self->infoArr addObjectsFromArray:array];
                    }
                    [self->myTable reloadData];
                    
                });
            }];
            
        }
        
    }
}

@end
