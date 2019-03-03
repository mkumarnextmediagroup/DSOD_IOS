//
//  CourseDetailLessonViewController.m
//  dentist
//
//  Created by Shirley on 2019/2/17.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "CourseDetailLessonsViewController.h"
#import "Common.h"
#import "Proto.h"
#import "LMSLessonModel.h"
#import "LMSResourceModel.h"
#import "LMSTestModel.h"
#import "LMSResourceTableViewCell.h"

@interface CourseDetailLessonsViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) CourseModel *courseModel;

@end

@implementation CourseDetailLessonsViewController{
    
    
    UITableView *tableView;



    NSArray<LMSLessonModel*> *lessonsArray;
    int edge;
}


/**
 build views
 */
-(void)buildView{
    edge = 18;
    
    [self.view removeAllChildren];
    
    tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.estimatedRowHeight = 10;
    tableView.rowHeight=UITableViewAutomaticDimension;
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    tableView.backgroundColor = UIColor.whiteColor;
        [tableView registerClass:LMSResourceTableViewCell.class forCellReuseIdentifier:NSStringFromClass(LMSResourceTableViewCell.class)];
    [self.view addSubview:tableView];
    [[[[[tableView.layoutMaker leftParent:0] rightParent:0] topParent:0] bottomParent:0] install];
    
    if(self.courseModel.courseStatus == InProgress){
        tableView.tableHeaderView =[self buildHeader];
    }
    
    [self addNotification];
}

/**
 buidl header

 @return header view
 */
-(UIView*)buildHeader{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 40)];
    view.backgroundColor = UIColor.redColor;
    
    
    return view;
}



/**
 Adding notifications to monitor progress
 */
- (void)addNotification
{
    // 进度通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downLoadProgress:) name:DentistDownloadProgressNotification object:nil];
    // 状态改变通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downLoadStateChange:) name:DentistDownloadStateChangeNotification object:nil];
}


/**
 show lessons info
 
 @param courseModel CourseModel instance
 */
-(void)showData:(CourseModel*)courseModel{
    _courseModel = courseModel;
    lessonsArray = courseModel.lessons;
    [self addCacheData:lessonsArray];

    [self buildView];
    

//    //wanglibo todo delte
//    NSMutableArray *marray = [[NSMutableArray alloc]init];
//    [marray addObjectsFromArray:courseModel.lessons];
//    [marray addObjectsFromArray:courseModel.lessons];
//    lessonsArray = [marray copy];
//
//    
//    [self addCacheData:lessonsArray];
//    [tableView reloadData];
}

/**
 Add cached download data

 @param lessonsArray lessons array
 */
- (void)addCacheData:(NSArray<LMSLessonModel*> *)lessonsArray;{
    // 获取已缓存数据
    NSArray *cacheData = [[DentistDataBaseManager shareManager] getAllCacheData];
    NSMutableDictionary *cacheDataDic = [[NSMutableDictionary alloc]init];
    for(DentistDownloadModel *model in cacheData){
        cacheDataDic[model.vid] = model;
    }
    
    for (int i = 0; i < lessonsArray.count; i++) {
        LMSLessonModel *lessonModel = lessonsArray[i];
        
        for(LMSResourceModel *resourceModel in lessonModel.resources){
            DentistDownloadModel *cacheResourceModel = cacheDataDic[resourceModel.downloadModel.vid];
            if(cacheResourceModel){
                resourceModel.downloadModel = cacheResourceModel;
            }
        }
    }
}

#pragma mark - DentistDownloadNotification
// 正在下载，进度回调
- (void)downLoadProgress:(NSNotification *)notification
{
    DentistDownloadModel *downloadModel = notification.object;
    
    [lessonsArray enumerateObjectsUsingBlock:^(LMSLessonModel *lessonModel, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if(lessonModel.resources && lessonModel.resources.count >0 ){
            for(int i = 0 ;i<lessonModel.resources.count;i++){
                LMSResourceModel *resourceModel = lessonModel.resources[i];
                if ([resourceModel.downloadModel.vid isEqualToString:downloadModel.vid]) {
                    // 主线程更新cell进度
                    dispatch_async(dispatch_get_main_queue(), ^{
                        LMSResourceTableViewCell *cell = [self->tableView cellForRowAtIndexPath:[NSIndexPath
                      indexPathForRow:i inSection:idx]];
                        [cell updateViewWithModel:downloadModel];
                    });
                    
                    *stop = YES;
                }
            }
        }
        
        
    }];
}

// 状态改变
- (void)downLoadStateChange:(NSNotification *)notification
{
    DentistDownloadModel *downloadModel = notification.object;
    [lessonsArray enumerateObjectsUsingBlock:^(LMSLessonModel *lessonModel, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if(lessonModel.resources && lessonModel.resources.count >0 ){
            for(int i = 0 ;i<lessonModel.resources.count;i++){
                LMSResourceModel *resourceModel = lessonModel.resources[i];
                if ([resourceModel.downloadModel.vid isEqualToString:downloadModel.vid]) {
                    resourceModel.downloadModel = downloadModel;
                    // 主线程更新cell进度
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self->tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:i inSection:idx]] withRowAnimation:UITableViewRowAnimationNone];
                    });
                    
                    *stop = YES;
                }
            }
        }
    }];
        
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark UITableViewDelegate,UITableViewDataSource
/**
 UITableViewDataSource
 numberOfSectionsInTableView
 
 
 @param tableView UITableView
 @return number of lessons
 */
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return lessonsArray.count;
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
    return 40;
}



/**
 UITableViewDataSource
 numberOfRowsInSection
 
 @param tableView UITableView
 @param section section index
 @return number of resources at section index
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return lessonsArray[section].resources.count + lessonsArray[section].tests.count;
}

/**
 UITableViewDataSource
 heightForRowAtIndexPath
 
 @param tableView UITableView
 @param indexPath NSIndexPath
 @return height for row
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
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
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH , 40)];
    
    if(section!=0){
        UILabel *lineLabel = headerView.lineLabel;
        [[[[[lineLabel.layoutMaker leftParent:0]topParent:0]rightParent:0]heightEq:1]install];
    }
    
    UILabel *sectionDescLabel = headerView.addLabel;
    sectionDescLabel.font = [Fonts regular:14];
    sectionDescLabel.textColor = rgbHex(0x4A4A4A);
    sectionDescLabel.text = [NSString stringWithFormat:@"Section %ld - %@",section + 1,lessonsArray[section].name];
    [[[sectionDescLabel.layoutMaker leftParent:edge]centerYParent:0]install];
    
    return headerView;
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
    LMSResourceTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LMSResourceTableViewCell class]) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    DentistDownloadModel *downloadModel = [[DentistDownloadModel alloc]init];
    int number = [self getNumberAtIndexPath:indexPath];
    NSInteger resourceType = 0;
    
    
    id model = [self getItemModel:indexPath];
    if([model isKindOfClass:LMSResourceModel.class]){
        downloadModel = ((LMSResourceModel*)model).downloadModel;
        resourceType = ((LMSResourceModel*)model).resourceType;
    }else if([model isKindOfClass:LMSTestModel.class]){
        downloadModel.fileName = ((LMSTestModel*)model).name;
        resourceType = 100;
    }

    cell.vc = self;
    cell.cancelDownloadCallback=^{
        ((LMSResourceModel*)model).downloadModel = nil;
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    };
    cell.removeDownloadCallback=^{
        ((LMSResourceModel*)model).downloadModel = nil;
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    };
    [cell showData:downloadModel number:number resourceType:resourceType showDownloadBtn:self.courseModel.courseStatus == InProgress];
    
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
//    if(infoArr.count>indexPath.row){
//
//    }

}

/**
 Get real data model

 @param indexPath NSIndexPath
 @return model of id type
 */
-(id)getItemModel:(NSIndexPath *)indexPath{
    id item = nil;
    long rescourseCount = lessonsArray[indexPath.section].resources.count;
    if(indexPath.row < rescourseCount){
        item = lessonsArray[indexPath.section].resources[indexPath.row];
    }else{
        long index = indexPath.row-rescourseCount;
        item = lessonsArray[indexPath.section].tests[index];
    }
    return item;
}


/**
 Get the serial number of the entire table

 @param indexPath NSIndexPath
 @return number of the entire table
 */
-(int)getNumberAtIndexPath:(NSIndexPath *)indexPath{
    int number = 0;
    for(int i = 0;i<indexPath.section;i++){
        number += [self tableView:tableView numberOfRowsInSection:i];
    }
    number += indexPath.row + 1;
    return number;
}

#pragma mark - 滑动方法
/**
 UIScrollViewDelegate
 scroll view did scroll
 
 @param scrollView UIScrollView
 */
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (!self.isCanScroll) {
        scrollView.contentOffset = CGPointZero;
    }
    
    /// 当偏移量小于0时，不能滑动，并且使主要视图的UITableView滑动
    if (scrollView.contentOffset.y < 0 ) {
        self.isCanScroll = NO;
        scrollView.contentOffset = CGPointZero;
        if (self.noScrollAction) {
            self.noScrollAction();
        }
    }
    
}

/**
 滚动到初始位置
 Scroll to the initial position
 */
-(void)contentOffsetToPointZero{
    tableView.contentOffset = CGPointZero;
}
@end
