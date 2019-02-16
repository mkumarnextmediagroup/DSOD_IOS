//
// Created by entaoyang@163.com on 2018/9/5.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "CmsDownloadsController.h"
#import "Common.h"
#import "DownloadsItemView.h"
#import "Proto.h"
#import "DentistFilterView.h"
#import "DenActionSheet.h"
#import "Article.h"
#import <Social/Social.h>
#import "CMSDetailViewController.h"
#import "DentistDataBaseManager.h"
#import "CMSModel.h"

@interface CmsDownloadsController()<MyActionSheetDelegate,ArticleItemViewDelegate>
{
    NSInteger selectIndex;
    NSMutableArray *ls;
    NSString *contentTypeId;
    CMSModel *selectModel;
    UIView *nullFilterView;
}
@end
@implementation CmsDownloadsController {
    
}
- (instancetype)init {
    self = [super init];
    self.topOffset = 0;
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    _categoryId=nil;
    contentTypeId=nil;
    [self reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINavigationItem *item = [self navigationItem];
    item.title = @"DOWNLOADS";
    item.rightBarButtonItem = [self navBarText:@"" target:self action:nil];
    
    [self.view layoutIfNeeded];
    _rowheight=(self.table.frame.size.height-32)/4;
    self.table.tableHeaderView = [self makeHeaderView];
    self.table.rowHeight = _rowheight;
    //    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addEmptyViewWithImageName:@"nonDownload" title:@"No downloaded content"];
    // 添加通知
    [self addNotification];
    
}

#pragma mark ----Public method
/**
 query download list data
 */
-(void)reloadData {
    [[DentistDataBaseManager shareManager] queryCMSCachesList:_categoryId contentTypeId:contentTypeId skip:0 completed:^(NSArray * _Nonnull array) {
        foreTask(^{
            self.items =array;
            [self updateFilterView];
        });
        
    }];
}
/**
 add the notification,when one download item state has changed，notification system to change the style of the view.
 */
- (void)addNotification
{
    // 状态改变通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downLoadStateChange:) name:DentistDownloadStateChangeNotification object:nil];
}

/**
 notification method,when one download item state has changed，this method will change the style of the view.
 */
- (void)downLoadStateChange:(NSNotification *)notification
{
    CMSModel *downloadModel = notification.object;
    NSMutableArray *tempArr=[NSMutableArray arrayWithArray:self.items];
    [tempArr enumerateObjectsUsingBlock:^(NSObject * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CMSModel *model=(CMSModel *)obj;
        if ([downloadModel.id isEqualToString:model.id]) {
            // 更新数据源
            tempArr[idx] = downloadModel;
            self.items=[tempArr copy];
            // 主线程刷新cell
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.table reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:idx inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
            });
            *stop = YES;
        }
    }];
}


/**
 表头视图
 table Header View
 */
- (UIView *)makeHeaderView {
    UIView *panel = [UIView new];
    panel.frame = makeRect(0, 0, SCREENWIDTH, 32);
    panel.backgroundColor=rgb255(250,251,253);
    
    UIButton *filterButton = [panel addButton];
    [filterButton setImage:[UIImage imageNamed:@"desc"] forState:UIControlStateNormal];
    [[[[filterButton.layoutMaker topParent:4] rightParent:-15] sizeEq:24 h:24] install];
    [filterButton onClick:self action:@selector(clickFilter:)];
    return panel;
}

/**
 set the filter view
 */
-(void)updateFilterView {
    if (!nullFilterView) {
        CGFloat _topBarH = 0;
        if (self.navigationController != nil) {
            _topBarH = NAVHEIGHT;
        }
        nullFilterView=[self makeHeaderView];
        nullFilterView.frame=makeRect(0, _topBarH, SCREENWIDTH, 32);
        [self.view addSubview:nullFilterView];
        nullFilterView.hidden=YES;
    }
    if (self.items.count==0 && (self->_categoryId || self->contentTypeId)) {
        nullFilterView.hidden=NO;
    } else{
        nullFilterView.hidden=YES;
    }
}

#pragma mark ----table method

/**
 table cell class
 */
- (Class)viewClassOfItem:(NSObject *)item {
    return DownloadsItemView.class;
}

/**
 table cell height
 */
- (CGFloat)heightOfItem:(NSObject *)item {
    return _rowheight;
}

/**
 table cell view
 */
- (void)onBindItem:(NSObject *)item view:(UIView *)view {
    CMSModel *model = (id) item;
    DownloadsItemView *itemView = (DownloadsItemView *) view;
    itemView.delegate=self;
    [itemView bindCMS:model];
}

/**
 click table cell event；click it，go to the article detail page
 */
- (void)onClickItem3:(NSObject *)item cell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath{
    UIViewController *viewController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    CMSDetailViewController *newVC = [[CMSDetailViewController alloc] init];
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:newVC];
    CMSModel *article = (CMSModel *) item;
    newVC.contentId = article.id;
    newVC.cmsmodelsArray=self.items;
    newVC.modelIndexOfArray = (int)indexPath.row;
    [viewController presentViewController:navVC animated:YES completion:NULL];
}

#pragma mark ----ArticleItemViewDelegate

/**
 Article more items Action,delete & share
 */
-(void)ArticleMoreActionModel:(CMSModel *)model
{
    selectModel=model;
    NSLog(@"ArticleMoreAction=%@",model.id);
    NSArray *imgArr = [NSArray arrayWithObjects:@"deleteDown",@"shareIcon", nil];
    DenActionSheet *denSheet = [[DenActionSheet alloc] initWithDelegate:self title:nil cancelButton:nil imageArr:imgArr otherTitle:@"Delete",@"Share", nil];
    [denSheet show];
}

#pragma mark ----MyActionSheetDelegate
/**
 delete & share event
 */
- (void)myActionSheet:(DenActionSheet *)actionSheet parentView:(UIView *)parentView subLabel:(UILabel *)subLabel index:(NSInteger)index
{
    NSLog(@"%@===%d",subLabel.text,index);
    if(index==1){
        UIActivityViewController *avc = [[UIActivityViewController alloc]initWithActivityItems:@[@"Mastering the art of Dental Surgery",[NSURL URLWithString:@"http://app800.cn/i/d.png"]] applicationActivities:nil];
        [self presentViewController:avc animated:YES completion:nil];
        
    }else if(index==0){
//        [Proto deleteDownload:selectIndex];
        [[DentistDataBaseManager shareManager] deleteCMS:selectModel.id completed:^(BOOL result) {
            foreTask(^{
                [self handleDeleteCMS:result];
            });
        }];
    }
}

/**
 delete result method
 @param result bool,true or false
 */
- (void)handleDeleteCMS: (BOOL) result {
    if (result) {
        NSMutableArray *temparr=[NSMutableArray arrayWithArray:self.items];
        [temparr removeObject:self->selectModel];
        self.items=[temparr copy];
        [self updateFilterView];
    }
}

#pragma mark -------Filter view
/**
 open Filter view
 */
-(void)clickFilter:(UIButton *)sender {
    DentistFilterView *filterview=[[DentistFilterView alloc] init];
    filterview.categorytext=self->_categoryId;
    filterview.typetext=self->contentTypeId;
    [filterview show:^(NSString *category, NSString *type) {
    }select:^(NSString *category, NSString *type) {
        self->_categoryId=category;
        self->contentTypeId=type;
        [[DentistDataBaseManager shareManager] queryCMSCachesList:self->_categoryId contentTypeId:self->contentTypeId skip:0 completed:^(NSArray * _Nonnull array) {
            foreTask(^{
                self.items =array;
                [self updateFilterView];
            });
        }];
    }];
}

@end
