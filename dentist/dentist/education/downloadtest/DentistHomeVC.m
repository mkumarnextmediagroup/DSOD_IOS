//
//  DentistHomeVC.m
//  DentistProject
//
//  Created by feng zhenrong on 2019/2/28.
//  Copyright © 2019年 thenextmediagroup.com. All rights reserved.
//

#import "DentistHomeVC.h"
#import "DentistHomeCell.h"
#import "DentistPlayVC.h"
#import "Common.h"

@interface DentistHomeVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray<DentistDownloadModel *> *dataSource;
@property (nonatomic, weak) UITableView *tableView;

@end

@implementation DentistHomeVC

- (NSMutableArray<DentistDownloadModel *> *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    UINavigationItem *item = [self navigationItem];
    item.title = @"下载测试";
    item.leftBarButtonItem = [self navBarBack:self action:@selector(back)];
    
    // 创建控件
    [self creatControl];
    
    // 添加通知
    [self addNotification];
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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 获取网络数据
    [self getInfo];

    // 获取缓存
    [self getCacheData];
}

- (void)getInfo
{
    [self.dataSource removeAllObjects];
    // 模拟网络数据
    NSArray *testData = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"testData.plist" ofType:nil]];
    
    for (int i=0; i<testData.count; i++) {
        NSDictionary *dic=testData[i];
        DentistDownloadModel *model=[DentistDownloadModel new];
        model.vid=[dic objectForKey:@"vid"];
        model.fileName=[dic objectForKey:@"fileName"];
        model.url=[dic objectForKey:@"url"];
        model.downloadtype=DentistDownloadTypeCourse;
        [self.dataSource addObject:model];
    }

    // 转模型
//    self.dataSource = [DentistDownloadModel mj_objectArrayWithKeyValuesArray:testData];
}

- (void)getCacheData
{
    // 获取已缓存数据
    NSArray *cacheData = [[DentistDataBaseManager shareManager] getAllCacheData];

    // 这里是把本地缓存数据更新到网络请求的数据中，实际开发还是尽可能避免这样在两个地方取数据再整合
    for (int i = 0; i < self.dataSource.count; i++) {
        DentistDownloadModel *model = self.dataSource[i];
        for (DentistDownloadModel *downloadModel in cacheData) {
            if ([model.url isEqualToString:downloadModel.url]) {
                self.dataSource[i] = downloadModel;
                break;
            }
        }
    }
    
    [_tableView reloadData];
}

- (void)creatControl
{
    // tableView
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    tableView.showsVerticalScrollIndicator = NO;
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.rowHeight = 80.f;
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    _tableView = tableView;
}

- (void)addNotification
{
    // 进度通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downLoadProgress:) name:DentistDownloadProgressNotification object:nil];
    // 状态改变通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downLoadStateChange:) name:DentistDownloadStateChangeNotification object:nil];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DentistHomeCell *cell = [DentistHomeCell cellWithTableView:tableView];
    
    cell.model = self.dataSource[indexPath.row];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DentistDownloadModel *model = self.dataSource[indexPath.row];

    if (model.state == DentistDownloadStateFinish) {
        DentistPlayVC *vc = [[DentistPlayVC alloc] init];
        vc.model = model;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - DentistDownloadNotification
// 正在下载，进度回调
- (void)downLoadProgress:(NSNotification *)notification
{
    DentistDownloadModel *downloadModel = notification.object;

    [self.dataSource enumerateObjectsUsingBlock:^(DentistDownloadModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([model.url isEqualToString:downloadModel.url]) {
            // 主线程更新cell进度
            dispatch_async(dispatch_get_main_queue(), ^{
                DentistHomeCell *cell = [self->_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:idx inSection:0]];
                [cell updateViewWithModel:downloadModel];
            });
            
            *stop = YES;
        }
    }];
}

// 状态改变
- (void)downLoadStateChange:(NSNotification *)notification
{
    DentistDownloadModel *downloadModel = notification.object;

    [self.dataSource enumerateObjectsUsingBlock:^(DentistDownloadModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([model.url isEqualToString:downloadModel.url]) {
            // 更新数据源
            self.dataSource[idx] = downloadModel;
            
            // 主线程刷新cell
            dispatch_async(dispatch_get_main_queue(), ^{
                [self->_tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:idx inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
            });

            *stop = YES;
        }
    }];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
