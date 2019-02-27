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

@interface CourseDetailLessonsViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation CourseDetailLessonsViewController{
    
    int edge;
    
    UITableView *tableView;
    
    //    NSArray<CompanyReviewModel*> *reviewArray;
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
    
    tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.estimatedRowHeight = 10;
    tableView.rowHeight=UITableViewAutomaticDimension;
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    tableView.backgroundColor = UIColor.whiteColor;
    //    [tableView registerClass:CompanyReviewHeaderTableViewCell.class forCellReuseIdentifier:NSStringFromClass(CompanyReviewHeaderTableViewCell.class)];
    [self.view addSubview:tableView];
    [[[[[tableView.layoutMaker leftParent:0] rightParent:0] topParent:0] bottomParent:0] install];
    
    
}

/**
 滚动到初始位置
 Scroll to the initial position
 */
-(void)contentOffsetToPointZero{
    tableView.contentOffset = CGPointZero;
}
@end
