//
//  CareerAlertsViewController.m
//  dentist
//
//  Created by Jacksun on 2018/11/27.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "CareerAlertsViewController.h"
#import "Proto.h"
#import "AppDelegate.h"
#import "UIViewController+myextend.h"
#import "UITableView+JRTableViewPlaceHolder.h"
#import "CareerAlertsTableViewCell.h"
#import "DsoToast.h"
#import "UIImage+customed.h"
#import "CareerAlertsAddViewController.h"

@interface CareerAlertsViewController ()<UITableViewDelegate,UITableViewDataSource,CareerAlertsTableViewCellDelegate>
{
    NSMutableArray *infoArr;
    UITableView *myTable;
    NSIndexPath *editingIndexPath;
    UIRefreshControl *refreshControl;
    BOOL isdownrefresh;
}
@end

@implementation CareerAlertsViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (myTable) {
        [myTable reloadData];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    UINavigationItem *item = [self navigationItem];
    item.title = @"Alerts";
    
//    UILabel *addlabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
//    addlabel.font=[UIFont systemFontOfSize:30];
//    addlabel.text=@"+";//[Fonts semiBold:30]
//    UIImage *addimage=[UIImage getmakeImageWithView:addlabel];
    
    item.rightBarButtonItem = [self navBarText:@"+" textFont:[UIFont systemFontOfSize:30] target:self action:@selector(addClick)];//[self navBarImageBtn:addimage target:self action:@selector(addClick)];
    
    
    
    
    myTable = [UITableView new];
    [self.view addSubview:myTable];
    myTable.dataSource = self;
    myTable.delegate = self;
    [myTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [[[myTable.layoutMaker sizeEq:SCREENWIDTH h:SCREENHEIGHT-NAVHEIGHT-TABLEBAR_HEIGHT] topParent:NAVHEIGHT] install];
    [myTable registerClass:[CareerAlertsTableViewCell class] forCellReuseIdentifier:NSStringFromClass([CareerAlertsTableViewCell class])];
    [self setupRefresh];
    [self createEmptyNotice];

}

-(void)addClick
{
    
    CareerAlertsAddViewController *addalertvc=[CareerAlertsAddViewController new];
    addalertvc.alertsAddSuceess = ^(JobAlertsModel * _Nonnull oldmodel, JobAlertsModel * _Nonnull newmodel) {
        if (oldmodel && newmodel) {
            NSInteger index=[self->infoArr indexOfObject:oldmodel];
            [self->infoArr replaceObjectAtIndex:index withObject:newmodel];
            [self->myTable reloadData];
        }else{
            [self->refreshControl beginRefreshing];
            [self refreshClick:self->refreshControl];
        }
    };
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:addalertvc];
    navVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:navVC animated:NO completion:NULL];
//    [self.navigationController pushViewController:addalertvc animated:YES];
}

-(void)refreshData
{
    [self showIndicator];
    [Proto queryRemindsByUserId:0 completed:^(NSArray<JobAlertsModel *> *array, NSInteger totalCount) {
        foreTask(^{
            [self hideIndicator];
            NSLog(@"%@",array);
            self->infoArr = [NSMutableArray arrayWithArray:array];
            [self->myTable reloadData];
            
        });
    }];
}

//MARK: 下拉刷新
- (void)setupRefresh {
    NSLog(@"setupRefresh -- 下拉刷新");
    self->refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refreshClick:) forControlEvents:UIControlEventValueChanged];
    [self->myTable addSubview:refreshControl];
    [self->refreshControl beginRefreshing];
    [self refreshClick:self->refreshControl];
}

//MARK: 下拉刷新触发,在此获取数据
- (void)refreshClick:(UIRefreshControl *)refreshControl {
    NSLog(@"refreshClick: -- 刷新触发");
    [self refreshData];
    [self->refreshControl endRefreshing];
}

- (void)createEmptyNotice
{
    [myTable jr_configureWithPlaceHolderBlock:^UIView * _Nonnull(UITableView * _Nonnull sender) {
        [self->myTable setScrollEnabled:NO];
        UIView *headerVi = [UIView new];
        [sender addSubview:headerVi];
        [[[headerVi.layoutMaker sizeEq:SCREENWIDTH h:SCREENHEIGHT-NAVHEIGHT-TABLEBAR_HEIGHT] topParent:0] install];
        headerVi.backgroundColor = [UIColor clearColor];
        UIButton *headBtn = headerVi.addButton;
        [headBtn setImage:[UIImage imageNamed:@"noun_mobile notification"] forState:UIControlStateNormal];
        headBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        headBtn.titleLabel.font = [Fonts regular:13];
        [[[headBtn.layoutMaker centerXParent:0] centerYParent:-80] install];
        UILabel *tipLabel= headerVi.addLabel;
        tipLabel.textAlignment=NSTextAlignmentCenter;
        tipLabel.numberOfLines=0;
        tipLabel.font = [Fonts semiBold:16];
        tipLabel.textColor =[UIColor blackColor];
        tipLabel.text=@"Add your first Job \n \n Receive a daily email with the best matched \njobs from DSOs";
        [[[[tipLabel.layoutMaker leftParent:20] rightParent:-20] below:headBtn offset:30] install];
//        UIView *createview=headerVi.addView;
//        createview.backgroundColor=Colors.textDisabled;
//        [[[[[createview.layoutMaker leftParent:20] rightParent:-20] bottomParent:-30]  heightEq:44] install];
        return headerVi;
    } normalBlock:^(UITableView * _Nonnull sender) {
        [self->myTable setScrollEnabled:YES];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 77;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return infoArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CareerAlertsTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CareerAlertsTableViewCell class]) forIndexPath:indexPath];
    cell.delegate=self;
    if (self->infoArr && self->infoArr.count>indexPath.row) {
        JobAlertsModel *model=self->infoArr[indexPath.row];
        cell.alerModel=model;
    }
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    //    return @"删除";
    
    return @"          ";
}

- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    self->editingIndexPath = indexPath;
    [self.view setNeedsLayout];   // 触发-(void)viewDidLayoutSubviews
}

- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self->editingIndexPath = nil;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

// 点击左滑出现的按钮时触发
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    //执行删除逻辑
    NSLog(@"========commitEditingStyle");
    UIView *dsontoastview=[DsoToast toastViewForMessage:@"Remove from JobsRemind……" ishowActivity:YES];
    [self.navigationController.view showToast:dsontoastview duration:30.0 position:CSToastPositionBottom completion:nil];
    if (self->infoArr && self->infoArr.count>indexPath.row) {
        JobAlertsModel *model=self->infoArr[indexPath.row];
        [Proto deleteJobRemind:model.id completed:^(HttpResult *result) {
            foreTask(^{
                [self.navigationController.view hideToast];
                if (result.OK) {
                    [self->infoArr removeObjectAtIndex:indexPath.row];
                    [self->myTable reloadData];
                }else{
                    NSString *message=result.msg;
                    if([NSString isBlankString:message]){
                        message=@"Failed";
                    }
                    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
                    [window makeToast:message
                             duration:1.0
                             position:CSToastPositionBottom];
                    [self.navigationController popViewControllerAnimated:YES];
                }
            });
            
        }];
    }
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat height = scrollView.frame.size.height;
    CGFloat contentOffsetY = scrollView.contentOffset.y;
    CGFloat consizeheight=scrollView.contentSize.height;
    CGFloat bottomOffset = (consizeheight - contentOffsetY);
    
    if (bottomOffset <= height-50  && contentOffsetY>0)
    {
        if (!isdownrefresh) {
            NSLog(@"==================================下啦刷选;contentOffsetY=%@;consizeheight=%@;bottomOffset=%@;height=%@；",@(contentOffsetY),@(consizeheight),@(bottomOffset),@(height));
            isdownrefresh=YES;
            [self showIndicator];
            [Proto queryRemindsByUserId:self->infoArr.count completed:^(NSArray<JobAlertsModel *> *array, NSInteger totalCount) {
                self->isdownrefresh=NO;
                foreTask(^{
                    [self hideIndicator];
                    NSLog(@"%@",array);
                    if(array && array.count>0){
                        [self->infoArr addObjectsFromArray:array];
                        [self->myTable reloadData];
                    }
                });
            }];
            
        }
        
    }
}


- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    if (self->editingIndexPath){
        [self configSwipeButtons];
    }
}

#pragma mark - configSwipeButtons
- (void)configSwipeButtons{
    // 获取选项按钮的reference
    if (@available(iOS 11.0, *)){
        
        // iOS 11层级 (Xcode 9编译): UITableView -> UISwipeActionPullView
        for (UIView *subview in self->myTable.subviews)
        {
            NSLog(@"%@-----%zd",subview,subview.subviews.count);
            if ([subview isKindOfClass:NSClassFromString(@"UISwipeActionPullView")] && [subview.subviews count] >= 1)
            {
                // 和iOS 10的按钮顺序相反
                
                subview.backgroundColor = Colors.textDisabled;
                UIButton *deleteButton = subview.subviews[0];
                [self configDeleteButton:deleteButton];
            }
        }
    }else{
        // iOS 8-10层级: UITableView -> UITableViewCell -> UITableViewCellDeleteConfirmationView
        CareerAlertsTableViewCell *tableCell = [self->myTable cellForRowAtIndexPath:self->editingIndexPath];
        for (UIView *subview in tableCell.subviews)
        {
            if ([subview isKindOfClass:NSClassFromString(@"UITableViewCellDeleteConfirmationView")])
            {
                UIView *confirmView = (UIView *)[subview.subviews firstObject];
                
                //改背景颜色
                
                confirmView.backgroundColor = Colors.textDisabled;
                
                for (UIView *sub in confirmView.subviews)
                {
                    //添加图片
                    if ([sub isKindOfClass:NSClassFromString(@"UIView")]) {
                        
                        UIView *deleteView = sub;
                        UIImageView *imageView = [[UIImageView alloc] init];
                        imageView.image = [UIImage imageNamed:@"address_cell_delete"];
                        [deleteView addSubview:imageView];
                        
                        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.centerX.equalTo(deleteView);
                            make.centerY.equalTo(deleteView);
                        }];
                    }
                }
                break;
            }
        }
    }
}

- (void)configDeleteButton:(UIButton*)deleteButton{
    if (deleteButton) {
        [deleteButton setImage:[UIImage imageNamed:@"icons8-delete_forever"] forState:UIControlStateNormal];
        [deleteButton addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventAllTouchEvents];
        [deleteButton setBackgroundColor:Colors.textDisabled];
        
    }
}

//按钮的点击操作
- (void)deleteAction:(UIButton *)sender{
    NSLog(@"========deleteAction");
    [self.view setNeedsLayout];
    [sender setBackgroundColor:Colors.textDisabled];
}

#pragma mark ========CareerAlertsTableViewCellDelegate
-(void)JobAlertsEditAction:(JobAlertsModel *)model
{
    CareerAlertsAddViewController *addalertvc=[CareerAlertsAddViewController new];
    addalertvc.model=model;
    addalertvc.alertsAddSuceess = ^(JobAlertsModel * _Nonnull oldmodel, JobAlertsModel * _Nonnull newmodel) {
        if (oldmodel && newmodel) {
            NSInteger index=[self->infoArr indexOfObject:oldmodel];
            [self->infoArr replaceObjectAtIndex:index withObject:newmodel];
            [self->myTable reloadData];
        }else{
            [self->refreshControl beginRefreshing];
            [self refreshClick:self->refreshControl];
        }
    };
    [self.navigationController pushViewController:addalertvc animated:YES];
}

-(void)JobAlertsAction:(JobAlertsModel *)model
{
    BOOL status=YES;
    NSString *toastmsg=@"Unreminding....";
    if (model.status) {
        status=NO;
        toastmsg=@"Reminding....";
    }
    
    UIView *dsontoastview=[DsoToast toastViewForMessage:toastmsg ishowActivity:YES];
    [self.navigationController.view showToast:dsontoastview duration:30.0 position:CSToastPositionBottom completion:nil];
    
    [Proto updateJobRemind:model.id keyword:model.keyword location:model.location position:model.position distance:model.distance frequency:model.frequency status:status completed:^(HttpResult *result) {
        foreTask(^{
            [self.navigationController.view hideToast];
            if (result.OK) {
                NSInteger index=[self->infoArr indexOfObject:model];
                model.status=status;
                [self->infoArr replaceObjectAtIndex:index withObject:model];
                [self->myTable reloadData];
            }else{
                NSString *message=result.msg;
                if([NSString isBlankString:message]){
                    message=@"Failed";
                }
                UIWindow *window = [[UIApplication sharedApplication] keyWindow];
                [window makeToast:message
                         duration:1.0
                         position:CSToastPositionBottom];
                [self.navigationController popViewControllerAnimated:YES];
            }
        });
    }];
}

@end
