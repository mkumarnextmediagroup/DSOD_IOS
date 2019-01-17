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
#import "FAQSViewController.h"
#import "FAQSTableViewCell.h"
#import "FAQSCategoryTableViewCell.h"


@interface HelpAndFeedbackViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@end

@implementation HelpAndFeedbackViewController{
    int edge;
    
    UIView *noResultView;
    UITableView *tableView;
    
    NSArray<FAQSCategoryModel*> *categories;
    NSArray<FAQSCategoryModel*> *resultData;
    NSMutableDictionary <NSString*,NSString*>*openCellIdDic;
}


+(void)openBy:(UIViewController*)vc {
    HelpAndFeedbackViewController *newVc = [HelpAndFeedbackViewController new];
    [vc pushPage:newVc];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    openCellIdDic = [NSMutableDictionary new];
    [self addNavBar];
    
    [self buildViews];
    
    [self showLoading];
    [Proto findFAQSListWithcompleted:^(NSArray<FAQSCategoryModel *> *array, NSInteger totalCount) {
        [self hideLoading];
        self->categories = [array copy];
        [self->tableView reloadData];
    }];
}

-(void)addNavBar{
    UINavigationItem *item = [self navigationItem];
    item.title = @"Help and Feedback";
    item.leftBarButtonItem = [self navBarBack:self action:@selector(dismiss)];
}

-(void)buildViews{
    edge = 18;
    self.view.backgroundColor = UIColor.whiteColor;
    
    UITextField *searchTextField = self.view.addEditSearch;
    searchTextField.borderStyle = UITextBorderStyleNone;
    searchTextField.layer.borderColor = rgbHex(0x979797).CGColor;
    searchTextField.layer.cornerRadius = 0;
    [searchTextField setHint:@"Search for help topics here"];
    [searchTextField addTarget:self action:@selector(textField1TextChange:) forControlEvents:UIControlEventEditingChanged];
    [[[[[searchTextField.layoutMaker leftParent:edge]topParent:NAVHEIGHT + 15]rightParent:-edge]heightEq:36] install];
    
    noResultView = self.view.addView;
    [[[[[noResultView.layoutMaker below:searchTextField offset:0]leftParent:0]rightParent:0] heightEq:0] install];
    
    UILabel *noResultLabel = noResultView.addLabel;
    noResultLabel.text = @"Sorry, no results found.\nPlease use one of the categories below to get more help.";
    noResultLabel.textColor = UIColor.blackColor;
    noResultLabel.font = [Fonts regular:11];
    noResultLabel.textAlignment = NSTextAlignmentCenter;
    [[[[[noResultLabel.layoutMaker leftParent:0]rightParent:0]topParent:15]bottomParent:0] install];
    
    tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    
    tableView.estimatedRowHeight = 1000;
    tableView.rowHeight=UITableViewAutomaticDimension;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerClass:FAQSCategoryTableViewCell.class forCellReuseIdentifier:NSStringFromClass(FAQSCategoryTableViewCell.class)];
    [tableView registerClass:FAQSTableViewCell.class forCellReuseIdentifier:NSStringFromClass(FAQSTableViewCell.class)];
    [self.view addSubview:tableView];
    [[[[[tableView.layoutMaker leftParent:0] rightParent:0] below:noResultView offset:15] bottomParent:0] install];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [tableView addGestureRecognizer:tapGestureRecognizer];
    
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self keyboardHide];
}

-(void)keyboardHide{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.view endEditing:YES];
    });
}

-(void)textField1TextChange:(UITextField *)textField{
   
    if(textField.text.length==0){
        [self keyboardHide];
    }
    
    [openCellIdDic removeAllObjects];
    resultData = [self filter:textField.text];
    [self->tableView reloadData];
    
    [[noResultView.layoutUpdate heightEq: textField.text.length!=0 && resultData.count == 0 ? 45 : 0]install];

}

-(NSArray*)filter:(NSString*)searchWord{
    NSMutableArray *array = [NSMutableArray new];
    
    for(FAQSCategoryModel *categoryModel in categories){
    //FAQSCategoryModel
        FAQSCategoryModel *newCategoryModel = [FAQSCategoryModel new];
        newCategoryModel.moduleType = categoryModel.moduleType;
        newCategoryModel.faqsModelArray = [NSMutableArray new];
        
        for(FAQSModel *faqsModel in categoryModel.faqsModelArray){
        //FAQSModel
            if([faqsModel.moduleType rangeOfString:searchWord].location != NSNotFound
               ||[faqsModel.function rangeOfString:searchWord].location != NSNotFound){
                [newCategoryModel.faqsModelArray addObject:faqsModel];
            }else{
                for(FAQSSubDescModel *subDescModel in faqsModel.subDescription){
                //FAQSSubDescModel
                    if([subDescModel.name rangeOfString:searchWord].location != NSNotFound){
                        [newCategoryModel.faqsModelArray addObject:faqsModel];
                        goto quit;
                    }else{
                        for(NSString *step in subDescModel.steps){
                            if([step rangeOfString:searchWord].location != NSNotFound){
                                [newCategoryModel.faqsModelArray addObject:faqsModel];
                                goto quit;
                            }
                        }
                    }
                }
            }
            
            quit:
            NSLog(@"quit");
        }
        
        if(newCategoryModel.faqsModelArray && newCategoryModel.faqsModelArray.count > 0){
            [array addObject:newCategoryModel];
        }
    }
    
    return [array copy];
}


-(BOOL)isSearchMode{
    if(resultData && resultData.count>0){
        return YES;
    }else{
        return NO;
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [[[UIApplication sharedApplication]keyWindow] endEditing:YES];
}

#pragma mark UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if([self isSearchMode]){
        return resultData.count;
    }else{
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if([self isSearchMode]){
        return resultData[section].faqsModelArray.count;
    }else{
        return categories.count;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH - edge, 30)];
    headerView.backgroundColor = rgbHex(0xfafbfd);
    
    UILabel *label = headerView.addLabel;
    label.font = [Fonts regular:13];
    label.textColor = rgbHex(0x879AA8);
    label.text = @"Categories";
    [[[[[label.layoutMaker leftParent:edge]topParent:0]rightParent:-edge]bottomParent:0]install];
    
    if([self isSearchMode]){
        label.text = resultData[section].moduleType;
    }else{
        label.text = @"Categories";
    }
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if([self isSearchMode]){
        return UITableViewAutomaticDimension;
    }else{
        return 56;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if([self isSearchMode]){
        return [self faqsFunctionCell:indexPath];
    }else{
        return [self categoryCell:indexPath];
    }
}

-(UITableViewCell*)categoryCell:(NSIndexPath *)indexPath{
    FAQSCategoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(FAQSCategoryTableViewCell.class)];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setText:categories[indexPath.row].moduleType isLastItem:indexPath.row==categories.count-1];
    
    return cell;
}

-(UITableViewCell*)faqsFunctionCell:(NSIndexPath *)indexPath{
    FAQSModel *model = resultData[indexPath.section].faqsModelArray[indexPath.row];
    int lastIndex = (int)resultData[indexPath.section].faqsModelArray.count - 1;
    
    FAQSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(FAQSTableViewCell.class)];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.itemBgColor = UIColor.whiteColor;
    [cell setData:model isOpen:openCellIdDic[model._id]!=nil isLastItem:indexPath.row==lastIndex];
    
    WeakSelf
    cell.titleOnClickListener = ^(NSString *_id){
        StrongSelf
        if(strongSelf->openCellIdDic[_id]){
            [strongSelf->openCellIdDic removeObjectForKey:_id];
        }else{
            strongSelf->openCellIdDic[_id] = _id;
        }
        [strongSelf-> tableView reloadData];
        [strongSelf keyboardHide];
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self keyboardHide];
    
    if(![self isSearchMode]){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [FAQSViewController openBy:self categoryModel:self->categories[indexPath.row]];
        });
    }
}

@end
