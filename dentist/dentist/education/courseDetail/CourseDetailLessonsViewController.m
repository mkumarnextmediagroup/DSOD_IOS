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
#import "LMSRerouceTableViewCell.h"

@interface CourseDetailLessonsViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) CourseModel *courseModel;

@end

@implementation CourseDetailLessonsViewController{
    
    
    UITableView *tableView;



    NSArray<LMSLessonModel*> *lessonsArray;
    int edge;
}


/**
 view did load
 call buildview function
 */
- (void)viewDidLoad{
    edge = 18;
    [self buildView];
    
}

/**
 build views
 */
-(void)buildView{
    edge = 18;
    
    tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.estimatedRowHeight = 10;
    tableView.rowHeight=UITableViewAutomaticDimension;
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    tableView.backgroundColor = UIColor.whiteColor;
        [tableView registerClass:LMSRerouceTableViewCell.class forCellReuseIdentifier:NSStringFromClass(LMSRerouceTableViewCell.class)];
    [self.view addSubview:tableView];
    [[[[[tableView.layoutMaker leftParent:0] rightParent:0] topParent:0] bottomParent:0] install];
}

/**
 show lessons info
 
 @param courseModel CourseModel instance
 */
-(void)showData:(CourseModel*)courseModel{
    _courseModel = courseModel;
    lessonsArray = courseModel.lessons;
    
    NSMutableArray *marray = [[NSMutableArray alloc]init];
    [marray addObjectsFromArray:courseModel.lessons];
    [marray addObjectsFromArray:courseModel.lessons];
    lessonsArray = [marray copy];

    [tableView reloadData];
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
    UILabel *sectionDescLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, edge, SCREENWIDTH - 2*edge, 40)];
    sectionDescLabel.font = [Fonts regular:14];
    sectionDescLabel.textColor = rgbHex(0x4A4A4A);
    sectionDescLabel.text = [NSString stringWithFormat:@"Section %ld - %@",section + 1,lessonsArray[section].name];
    return sectionDescLabel;
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
    LMSRerouceTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LMSRerouceTableViewCell class]) forIndexPath:indexPath];
    
    DentistDownloadModel *downloadModel = [[DentistDownloadModel alloc]init];
    int number = [self getNumberAtIndexPath:indexPath];
    NSInteger resourceType = 0;
    
    id model = [self getItemModel:indexPath];
    if([model isKindOfClass:LMSResourceModel.class]){
        downloadModel.vid = ((LMSResourceModel*)model).id;
        downloadModel.fileName = ((LMSResourceModel*)model).name;
        downloadModel.url = [Proto getLMSDownloadUrlByObjectId: ((LMSResourceModel*)model).resource];
        resourceType = ((LMSResourceModel*)model).resourceType;
        
    }else if([model isKindOfClass:LMSTestModel.class]){
        downloadModel.fileName = ((LMSTestModel*)model).name;
        resourceType = 100;
    }

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
    for(int i = 0;i<indexPath.section-1;i++){
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
