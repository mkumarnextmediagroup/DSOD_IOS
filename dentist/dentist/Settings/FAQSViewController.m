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


@interface FAQSViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) FAQSCategoryModel *categoryModel;

@end

@implementation FAQSViewController{
    
    UITableView *tableView;
    
    NSMutableDictionary <NSString*,NSString*>*openCellIdDic;
    
    
}

+(void)openBy:(UIViewController*)vc categoryModel:(FAQSCategoryModel*)categoryModel{
//    for(int i=0;i<20;i++){
//
//        FAQSModel *faqsmodel = [FAQSModel new];
//        faqsmodel._id=[NSString stringWithFormat:@"id_%d",i];
//        faqsmodel.function =[NSString stringWithFormat:@"function_%d",i];
//        faqsmodel.desc =[NSString stringWithFormat:@"desc_%d",i];
//
//        FAQSStepModel *step1 = [FAQSStepModel new];
//        step1.step = @"step1";
//        FAQSStepModel *step2 = [FAQSStepModel new];
//        step2.step = @"step2";
//        FAQSStepModel *step3 = [FAQSStepModel new];
//        step3.step = @"step3";
//        FAQSStepModel *step4 = [FAQSStepModel new];
//        step4.step = @"step4";
//
//        faqsmodel.steps = @[step1,step2,step3,step4];
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
    [[[[[tableView.layoutMaker leftParent:0] rightParent:0] topParent:NAVHEIGHT] bottomParent:0] install];
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
