//
//  HelpAndFeedbackViewController.m
//  dentist
//
//  Created by Shirley on 2019/1/6.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "HelpAndFeedbackViewController.h"
#import "Common.h"
#import "Proto.h"


@interface HelpAndFeedbackViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation HelpAndFeedbackViewController{
    int edge;
    
    UITableView *tableView;
}


+(void)openBy:(UIViewController*)vc {
    HelpAndFeedbackViewController *newVc = [HelpAndFeedbackViewController new];
    [vc pushPage:newVc];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addNavBar];
    
    [self buildViews];
}

-(void)addNavBar{
    UINavigationItem *item = [self navigationItem];
    item.title = @"HELP AND FEEDBACK";
    item.leftBarButtonItem = [self navBarBack:self action:@selector(dismiss)];
}

-(void)buildViews{
    edge = 18;
    [[self.scrollView.layoutUpdate topParent:NAVHEIGHT]install];

    
    UIImageView *imageView = self.contentView.addImageView;
    imageView.imageName = @"icons8-help";
    [[[[imageView.layoutMaker topParent:30]centerXParent:0]sizeEq:100 h:100]install];
    
    
    UILabel *label = self.contentView.addLabel;
    label.font = [Fonts regular:20];
    label.textColor = UIColor.blackColor;
    label.text = @"How can we help you today?";
    [[[label.layoutMaker  below:imageView offset:20]centerXParent:0]install];
    
    UITextField *searchTextField = self.contentView.addEditSearch;
    searchTextField.borderStyle = UITextBorderStyleNone;
    searchTextField.layer.borderColor = rgbHex(0x979797).CGColor;
    searchTextField.layer.cornerRadius = 0;
    [searchTextField setHint:@"Search for help topics here"];
    [[[[[searchTextField.layoutMaker leftParent:edge]below:label offset:40]rightParent:-edge]heightEq:36] install];
    
    
//    tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
//    tableView.dataSource = self;
//    tableView.delegate = self;
//    tableView.estimatedRowHeight = 10;
//    tableView.rowHeight=UITableViewAutomaticDimension;
//    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
////    [tableView registerClass:CompanyExistsReviewsTableViewCell.class forCellReuseIdentifier:NSStringFromClass(CompanyExistsReviewsTableViewCell.class)];
//    [self.view addSubview:tableView];
//    [[[[[tableView.layoutMaker leftParent:0] rightParent:0] topParent:0] bottomParent:0] install];
    
    UIView *lastView = searchTextField;
    [self.contentView.layoutUpdate.bottom.greaterThanOrEqualTo(lastView) install];
}


@end
