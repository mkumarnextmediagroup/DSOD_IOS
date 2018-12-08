//
//  CompanyDetailReviewsViewController.m
//  dentist
//
//  Created by Shirley on 2018/12/8.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "CompanyDetailReviewsViewController.h"
#import "Common.h"

@interface CompanyDetailReviewsViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation CompanyDetailReviewsViewController{
    int edge;

    UITableView *tableView;
}



- (void)viewDidLoad{
    edge = 18;
    [self buildView];
}


-(void)buildView{
    edge = 18;
    
    tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.estimatedRowHeight = 10;
    tableView.rowHeight=UITableViewAutomaticDimension;
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:tableView];
    [[[[[tableView.layoutMaker leftParent:0] rightParent:0] topParent:0] bottomParent:0] install];
    
    self.view.backgroundColor = UIColor.greenColor;
    
    
}


#pragma mark UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [UITableViewCell new];
    
    cell.textLabel.text = @"aaaa";
    return cell;
    
}


#pragma mark - 滑动方法
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

-(void)contentOffsetToPointZero{
    tableView.contentOffset = CGPointZero;
}

@end
