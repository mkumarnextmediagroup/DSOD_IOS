//
//  EducationCategoryViewController.m
//  dentist
//
//  Created by feng zhenrong on 2019/2/14.
//  Copyright © 2019年 thenextmediagroup.com. All rights reserved.
//

#import "EducationCategoryViewController.h"
#import "EducationCategoryTableViewCell.h"
#import "Common.h"
#import "IdName.h"
#import "Proto.h"

@interface EducationCategoryViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray<IdName *> *infoArr;
    UITableView *myTable;
}
@end

@implementation EducationCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UINavigationItem *item = [self navigationItem];
    item.title = @"CATEGORY";
    item.leftBarButtonItem = [self navBarBack:self action:@selector(back)];
    
    myTable = [UITableView new];
    [self.view addSubview:myTable];
    myTable.dataSource = self;
    myTable.delegate = self;
    myTable.backgroundColor = Colors.textColorFAFBFD;;
    [myTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [[[myTable.layoutMaker sizeEq:SCREENWIDTH h:SCREENHEIGHT-NAVHEIGHT] topParent:NAVHEIGHT] install];
    [myTable registerClass:[EducationCategoryTableViewCell class] forCellReuseIdentifier:NSStringFromClass([EducationCategoryTableViewCell class])];
    [self queryCategoryData];
    // Do any additional setup after loading the view.
}

-(void)queryCategoryData
{
    [self showLoading];
    [Proto queryLMSCategoryTypes:nil completed:^(NSArray<IdName *> *array) {
        [self hideLoading];
        if (array) {
            self->infoArr=array;
        }
        [self->myTable reloadData];
//        NSLog(@"array=%@",array);
    }];
}

/**
 close page
 */
-(void)back{
    NSArray *viewcontrollers=self.navigationController.viewControllers;
    if (viewcontrollers.count>1) {
        if ([viewcontrollers objectAtIndex:viewcontrollers.count-1]==self) {
            //push方式
            [self.navigationController popViewControllerAnimated:NO];
        }
    }
    else{
        //present方式
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}


#pragma mark UITableViewDelegate,UITableViewDataSource
/**
 UITableViewDataSource
 heightForRowAtIndexPath
 
 @param tableView UITableView
 @param indexPath NSIndexPath
 @return height for row
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 76;
}

/**
 UITableViewDataSource
 numberOfSectionsInTableView
 
 @param tableView UITableView
 @return number of sections
 */
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

/**
 UITableViewDataSource
 heightForHeaderInSection
 
 @param tableView UITableView
 @param section section index
 @return height for header in section
 */
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}


/**
 UITableViewDataSource
 viewForHeaderInSection
 
 @param tableView UITableView
 @param section section index
 @return UIView
 */
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [UIView new];
    
}

/**
 UITableViewDataSource
 numberOfRowsInSection
 
 @param tableView UITableView
 @param section section index
 @return number of rows in section
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return infoArr.count;
    
}
/**
 UITableViewDataSource
 cellForRowAtIndexPath
 
 @param tableView UITableView
 @param indexPath NSIndexPath
 @return UITableViewCell
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EducationCategoryTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EducationCategoryTableViewCell class]) forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if(infoArr.count>indexPath.row){
        IdName *model=infoArr[indexPath.row];
        
        [cell setModel:model.name des:model.descriptions];
    }
    return cell;
}

/**
 UITableViewDataSource
 didSelectRowAtIndexPath
 
 @param tableView UITableView
 @param indexPath NSIndexPath
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
