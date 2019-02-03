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

/**
Open help and feedback page
@param vc UIViewController
*/
+(void)openBy:(UIViewController*)vc {
    HelpAndFeedbackViewController *newVc = [HelpAndFeedbackViewController new];
    [vc pushPage:newVc];
}


/**
 view did load
 build views and load FAQS data from server
 */
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


/**
 add navigation bar
 */
-(void)addNavBar{
    UINavigationItem *item = [self navigationItem];
    item.title = @"HELP AND FEEDBACK";
    item.leftBarButtonItem = [self navBarBack:self action:@selector(dismiss)];
}


/**
 build views
 */
-(void)buildViews{
    edge = 18;
    self.view.backgroundColor = UIColor.whiteColor;
    
    UITextField *searchTextField = self.view.addEditSearch;
    searchTextField.borderStyle = UITextBorderStyleNone;
    searchTextField.layer.borderColor = rgbHex(0x979797).CGColor;
    searchTextField.layer.cornerRadius = 0;
    [searchTextField setHint:@"Search for help topics here"];
    [searchTextField addTarget:self action:@selector(textFieldTextChange:) forControlEvents:UIControlEventEditingChanged];
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

/**
 Touch screen hide soft keyboard

 @param touches touches description
 @param event event description
 */
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self keyboardHide];
}

/**
 hide soft keyboard
 */
-(void)keyboardHide{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.view endEditing:YES];
    });
}

/**
 
 TextField Text Change callback
 @param textField searchTextField
 */
-(void)textFieldTextChange:(UITextField *)textField{
   
    if(textField.text.length==0){
        [self keyboardHide];
    }
    
    [openCellIdDic removeAllObjects];
    resultData = [self filter:textField.text];
    [self->tableView reloadData];
    
    [[noResultView.layoutUpdate heightEq: textField.text.length!=0 && resultData.count == 0 ? 45 : 0]install];

}

/**
 Search for matching content
 @param searchWord search word
 @return Matching Array
 */
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


/**
 Whether it is search mode
 @return Search mode returns true otherwise returns faslse
 */
-(BOOL)isSearchMode{
    if(resultData && resultData.count>0){
        return YES;
    }else{
        return NO;
    }
}

/**
 scrollView did Scroll,soft keyboard
 
 @param scrollView UISscrollView
 */
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [[[UIApplication sharedApplication]keyWindow] endEditing:YES];
}

#pragma mark UITableViewDelegate,UITableViewDataSource
/**
 UITableViewDataSource
 numberOfSectionsInTableView

 @param tableView UITableView
 @return number fo sections
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if([self isSearchMode]){
        return resultData.count;
    }else{
        return 1;
    }
}

/**
 UITableViewDataSource
 numberOfRowsInSection

 @param tableView UITableView
 @param section section index
 @return number of rows in section
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if([self isSearchMode]){
        return resultData[section].faqsModelArray.count;
    }else{
        return categories.count;
    }
}


/**
 UITableViewDataSource
 heightForHeaderInSection

 @param tableView UITableView
 @param section section index
 @return height for header in section
 */
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

/**
 UITableViewDataSource
 viewForHeaderInSection

 @param tableView UITableView
 @param section section index
 @return header view
 */
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

/**
 UITableViewDataSource
 heightForRowAtIndexPath

 @param tableView UITableView
 @param indexPath NSIndexPath
 @return height for row at indexPath
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if([self isSearchMode]){
        return UITableViewAutomaticDimension;
    }else{
        return 56;
    }
}

/**
 UITableViewDataSource
 cellForRowAtIndexPath

 @param tableView UITableView
 @param indexPath NSIndexPath
 @return UITableViewCell
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if([self isSearchMode]){
        return [self faqsFunctionCell:indexPath];
    }else{
        return [self categoryCell:indexPath];
    }
}

/**
 build category cell

 @param indexPath NSIndexPath
 @return FAQSCategoryTableViewCell
 */
-(UITableViewCell*)categoryCell:(NSIndexPath *)indexPath{
    FAQSCategoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(FAQSCategoryTableViewCell.class)];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setText:categories[indexPath.row].moduleType isLastItem:indexPath.row==categories.count-1];
    
    return cell;
}

/**
 build faqs function cell
 
 @param indexPath NSIndexPath
 @return FAQSTableViewCell
 */
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

/**
 UITableViewDataSource
 didSelectRowAtIndexPath

 @param tableView UITableView
 @param indexPath NSIndexPath
 */
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
