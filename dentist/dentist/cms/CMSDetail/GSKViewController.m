//
//  GSKViewController.m
//  dentist
//
//  Created by Jacksun on 2018/10/12.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "GSKViewController.h"
#import "Common.h"
#import "ArticleItemView.h"
#import "Proto.h"
#import "CMSDetailViewController.h"
#import "StateCity.h"
#import "UIView+customed.h"
#import "IdName.h"
#import "AppDelegate.h"
#import "LinearPage.h"
#import "NSDate+myextend.h"
#import "TestPage.h"
#import "GSKItemView.h"

@interface GSKViewController ()
{
    NSArray<NSString *> *segItems;
    UISegmentedControl *segView;
    UILabel *typeLabel;
    UILabel *dateLabel;
}
@end

#define edge 16;

@implementation GSKViewController

- (instancetype)init {
    self = [super init];
    self.topOffset = 0;
    segItems = @[@"LATEST", @"VIDEOS", @"ARTICLES", @"PODCASTS", @"INTERVIEWS", @"TECH GUIDES", @"ANIMATIONS", @"TIP SHEETS"];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINavigationItem *item = [self navigationItem];
    item.title = @"SPONSORED CONTENT";
    item.leftBarButtonItem = [self navBarImage:@"back_arrow" target:self action:@selector(onBack:)];
    
    self.table.rowHeight = 145;
    
    NSArray *ls = [Proto listArticle];
    self.items = ls;
}

- (void)onBack:(UIButton *)btn {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)onSegValueChanged:(id)sender {
    NSInteger n = segView.selectedSegmentIndex;
    NSString *title = segItems[n];
    Log(@(n ), title);
}

- (Class)viewClassOfItem:(NSObject *)item {
    return GSKItemView.class;
}

- (CGFloat)heightOfItem:(NSObject *)item {
    //    return 430;
    return UITableViewAutomaticDimension;
}

- (void)onBindItem:(NSObject *)item view:(UIView *)view {
    Article *art = (id) item;
    GSKItemView *itemView = (GSKItemView *) view;
    [itemView bind:art];
}

- (void)onClickItem:(NSObject *)item {
    
    CMSDetailViewController *detail = [CMSDetailViewController new];
    detail.articleInfo = (Article *) item;
    [self.navigationController.tabBarController presentViewController:detail animated:YES completion:nil];
}


@end

