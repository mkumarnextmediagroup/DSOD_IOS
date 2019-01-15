//
//  FAQSViewController.m
//  dentist
//
//  Created by Shirley on 2019/1/6.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "FAQSViewController.h"
#import "Common.h"
#import "FAQSTableViewCell.h"
#import "ContactUsViewController.h"


@interface FAQSViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) FAQSCategoryModel *categoryModel;

@end

@implementation FAQSViewController{
    
    UITableView *tableView;
    
    NSMutableDictionary <NSString*,NSString*>*openCellIdDic;
    
    
}

+(void)openBy:(UIViewController*)vc categoryModel:(FAQSCategoryModel*)categoryModel{
//    categoryModel.faqsModelArray = [NSMutableArray new];
//    for(int i=0;i<20;i++){
//
//        FAQSModel *faqsmodel = [FAQSModel new];
//        faqsmodel._id=[NSString stringWithFormat:@"id_%d",i];
//        faqsmodel.function =[NSString stringWithFormat:@"function_%d",i];
//        faqsmodel.desc =[NSString stringWithFormat:@"desc_%d",i];
//
//        FAQSSubDescModel *step1 = [FAQSSubDescModel new];
//        step1.name = @"step1";
//        FAQSSubDescModel *step2 = [FAQSSubDescModel new];
//        step2.name = @"step2";
//        FAQSSubDescModel *step3 = [FAQSSubDescModel new];
//        step3.name = @"step3";
//        FAQSSubDescModel *step4 = [FAQSSubDescModel new];
//        step4.name = @"step4";
//
//        faqsmodel.subDescription = @[step1,step2,step3,step4];
//
//        [categoryModel.faqsModelArray addObject:faqsmodel];
//    }
    
    
    FAQSViewController *newVc = [FAQSViewController new];
    newVc.categoryModel = categoryModel;
    [vc pushPage:newVc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    openCellIdDic = [NSMutableDictionary new];
    
    [self addNavBar];
    
    [self buildViews];
}

-(void)addNavBar{
    UINavigationItem *item = [self navigationItem];
    item.title = [NSString stringWithFormat:@"%@ FAQS",[self.categoryModel.moduleType uppercaseString]];
    item.leftBarButtonItem = [self navBarBack:self action:@selector(dismiss)];
}

-(void)buildViews{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = UIColor.whiteColor;
    
    tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.estimatedRowHeight = 1000;
    tableView.rowHeight=UITableViewAutomaticDimension;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerClass:FAQSTableViewCell.class forCellReuseIdentifier:NSStringFromClass(FAQSTableViewCell.class)];
    [self.view addSubview:tableView];
    [[[[[tableView.layoutMaker leftParent:0] rightParent:0] topParent:NAVHEIGHT] bottomParent:-60] install];
    
    UIView *bottomView = self.view.addView;
    [[[[[bottomView.layoutMaker below:tableView offset:0]leftParent:0]rightParent:0]heightEq:60]install];
    
    UILabel *lineLabel = bottomView.lineLabel;
    [[[[[lineLabel.layoutMaker leftParent:0]rightParent:0]topParent:0]heightEq:1]install];
    
    UILabel *label = bottomView.addLabel;
    label.font = [Fonts regular:13];
    label.textColor = rgbHex(0x9b9b9b);
    label.text = @"Did not find what you\nwere looking for?";
    [[[label.layoutMaker centerYParent:0]leftParent:18]install];
    
    UIButton *button = bottomView.addButton;
    button.backgroundColor =Colors.textDisabled;
    [button addTarget:self action:@selector(buttonOnClick) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = [Fonts regular:15];
    [button setTitle:@"Contact Us" forState:UIControlStateNormal];
    [[[[button.layoutMaker centerYParent:0]rightParent:-18] sizeEq:150 h:40] install];
    
}

-(void)buttonOnClick{
    [ContactUsViewController openBy:self];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.categoryModel.faqsModelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FAQSModel *model = self.categoryModel.faqsModelArray[indexPath.row];
    
    
    FAQSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(FAQSTableViewCell.class)];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.itemBgColor = rgbHex(0xfafbfd);
    [cell setData:model isOpen:openCellIdDic[model._id]!=nil];
    
    WeakSelf
    cell.titleOnClickListener = ^(NSString *_id){
        StrongSelf
        if(strongSelf->openCellIdDic[_id]){
            [strongSelf->openCellIdDic removeObjectForKey:_id];
        }else{
            strongSelf->openCellIdDic[_id] = _id;
        }
        [strongSelf-> tableView reloadData];
    };
    return cell;
}



@end
