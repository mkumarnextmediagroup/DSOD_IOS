//
//  SliderListView.m
//  dentist
//
//  Created by Jacksun on 2018/11/7.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "SliderListView.h"
#import "Common.h"
#import "UniteArticles.h"
#import "UniteArticleTableViewCell.h"
#import "Proto.h"
#import "UIView+gesture.h"
#import "DentistDataBaseManager.h"
#import "DetailModel.h"
#import "AppDelegate.h"
#import "UITableView+JRTableViewPlaceHolder.h"

@interface SliderListView()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UIGestureRecognizerDelegate>
{
    UITableView *mTableView;
    UISearchBar *mSearch;
    NSArray     *infoArr;
    NSArray     *searchArr;
    UIView      *sliderView;
    UIView      *backgroundVi;
    NSMutableArray *resultArray;
    BOOL        isShow;
}

@property BOOL isSearch;
@property NSString *magazineId;

@end

@implementation SliderListView

static SliderListView *instance;
static dispatch_once_t onceToken;

+ (instancetype)initSliderView:(BOOL)isSearch magazineId:(NSString * _Nullable)magazineId
{
    dispatch_once(&onceToken, ^{
        instance = [[SliderListView alloc] init];
        instance.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0];
        instance.isSearch = isSearch;
        instance.magazineId = magazineId;
        [instance initSliderView];
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window.rootViewController.view addSubview:instance];
        instance.frame = CGRectMake(0, NAVHEIGHT, SCREENWIDTH, SCREENHEIGHT);
    });
    
    return instance;
}

+(void)attemptDealloc{
    instance = nil;
    onceToken = 0;
}

+(void)hideSliderView
{
    if (instance) {
        [instance->mSearch resignFirstResponder];
        instance->sliderView.frame = CGRectMake(SCREENWIDTH, 0, SCREENWIDTH-132, SCREENHEIGHT-NAVHEIGHT);
        instance->backgroundVi.frame = CGRectMake(SCREENWIDTH, 0, SCREENWIDTH, SCREENHEIGHT);
        [instance removeFromSuperview];
    }
    
    [self attemptDealloc];
}

- (void)showSliderView
{
    if (sliderView.frame.origin.x == SCREENWIDTH) {
        [UIView animateWithDuration:.3 animations:^{
            self->backgroundVi.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
            self->sliderView.frame = CGRectMake(132, 0, SCREENWIDTH-132, SCREENHEIGHT-NAVHEIGHT);
        }];
    }else
    {
        [self->mSearch resignFirstResponder];
        [UIView animateWithDuration:.3 animations:^{
            [self->mSearch resignFirstResponder];
            self->sliderView.frame = CGRectMake(SCREENWIDTH, 0, SCREENWIDTH-132, SCREENHEIGHT-NAVHEIGHT);
            self->backgroundVi.frame = CGRectMake(SCREENWIDTH, 0, SCREENWIDTH, SCREENHEIGHT);
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
            [SliderListView attemptDealloc];
        }];
    }
}

- (void)sigleTappedPickerView:(UIGestureRecognizer *)sender
{
    [self->mSearch resignFirstResponder];
    [UIView animateWithDuration:.3 animations:^{
        self->sliderView.frame = CGRectMake(SCREENWIDTH, 0, SCREENWIDTH-132, SCREENHEIGHT-NAVHEIGHT);
        self->backgroundVi.frame = CGRectMake(SCREENWIDTH, 0, SCREENWIDTH, SCREENHEIGHT);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [SliderListView attemptDealloc];
    }];
}

- (void)initSliderView
{
    backgroundVi = [self addView];
    backgroundVi.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0];
    backgroundVi.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);

    sliderView = [backgroundVi addView];
    sliderView.backgroundColor = [UIColor whiteColor];
    sliderView.frame = CGRectMake(SCREENWIDTH, 0, SCREENWIDTH-132, SCREENHEIGHT-NAVHEIGHT);
    
    UIView *guestView = [backgroundVi addView];
    guestView.frame = CGRectMake(0, 0, 132, SCREENHEIGHT-NAVHEIGHT);
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sigleTappedPickerView:)];
    [singleTap setNumberOfTapsRequired:1];
    [guestView addGestureRecognizer:singleTap];
    singleTap.delegate = self;
    
    if (_isSearch) {//show the search page
        [self createSearchBar];
        [[[[mSearch.layoutMaker leftParent:8] topParent:0] sizeEq:SCREENWIDTH - 132 - 8 h:40] install];
        
        [self createTableview];
        [[[[[mTableView.layoutMaker leftParent:0] rightParent:0] below:mSearch offset:10] sizeEq:SCREENWIDTH - 132 h:SCREENHEIGHT - NAVHEIGHT-30] install];
    }else
    {
        [self createTableview];
        [[[[[mTableView.layoutMaker leftParent:0] rightParent:0] topParent:0] heightEq:SCREENHEIGHT - NAVHEIGHT] install];
    }
    
    [[DentistDataBaseManager shareManager] queryUniteArticlesCachesList:self.magazineId completed:^(NSArray<DetailModel *> * _Nonnull array) {
        if (array) {
            self->infoArr = array;
            [self sortGroupByArr];
        }
    }];
}


- (void)sortGroupByArr
{
    // 获取array中所有index值
    NSArray *indexArray = [infoArr valueForKey:@"categoryId"];
    // 将array装换成NSSet类型
    NSSet *indexSet = [NSSet setWithArray:indexArray];
    // 新建array，用来存放分组后的array
    resultArray = [NSMutableArray array];
    // NSSet去重并遍历
    [[indexSet allObjects] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        // 根据NSPredicate获取array
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"categoryId == %@",obj];
        NSArray *indexArray = [self->infoArr filteredArrayUsingPredicate:predicate];
        
        // 将查询结果加入到resultArray中
        [self->resultArray addObject:indexArray];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self->mSearch resignFirstResponder];
            [self->mTableView reloadData];
        });

    }];
}

- (void)createSearchBar
{
    mSearch = [UISearchBar new];
    mSearch.placeholder = @"Search ...";
    mSearch.delegate = self;
    mSearch.showsCancelButton = NO;
    mSearch.searchBarStyle = UISearchBarStyleMinimal;
    [sliderView addSubview:mSearch];
}

- (void)createTableview
{
    mTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    mTableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    mTableView.dataSource = self;
    mTableView.delegate = self;
    mTableView.estimatedRowHeight = 60;
//    mTableView.rowHeight = UITableViewAutomaticDimension;
    mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    mTableView.backgroundColor = [UIColor whiteColor];
    [sliderView addSubview:mTableView];
    
}

- (UIView *)headerView{
    
    UIView *headerVi = [UIView new];
    headerVi.backgroundColor = [UIColor whiteColor];
    
    if (!_isSearch) {
        UILabel *issueLabel = headerVi.addLabel;
        issueLabel.text = @"Vol1 No1";
        issueLabel.font = [Fonts regular:14];
        [[[[[issueLabel.layoutMaker leftParent:30] rightParent:30] heightEq:42] topParent:0] install];
        
        UILabel *line1 = headerVi.addLabel;
        line1.backgroundColor = [Colors cellLineColor];
        [[[[[line1.layoutMaker leftParent:0] rightParent:0] heightEq:1] below:issueLabel offset:0] install];
        
        UIButton *headBtn = headerVi.addButton;
        [headBtn setTitleColor:Colors.textMain forState:UIControlStateNormal];
//        [headBtn setTitleColor:Colors.textAlternate forState:UIControlStateNormal];
        [headBtn setTitle:@"IN THIS ISSUE" forState:UIControlStateNormal];
        headBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        headBtn.titleLabel.font = [Fonts regular:13];
        [[[[[headBtn.layoutMaker leftParent:30] rightParent:30] heightEq:42] below:line1 offset:0] install];
        
        UILabel *line2 = headerVi.addLabel;
        line2.backgroundColor = [Colors cellLineColor];
        [[[[[line2.layoutMaker leftParent:0] rightParent:0] heightEq:1] below:headBtn offset:0] install];
        
    }else if(searchArr.count > 0)
    {
        UIButton *headBtn = headerVi.addButton;
        [headBtn setTitleColor:Colors.textAlternate forState:UIControlStateNormal];
        [headBtn setTitle:[NSString stringWithFormat:@"%lu RESULTS FOUND",(unsigned long)searchArr.count] forState:UIControlStateNormal];
        headBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        headBtn.titleLabel.font = [Fonts regular:13];
        [[[[[headBtn.layoutMaker leftParent:30] rightParent:30] heightEq:42] topParent:0] install];
    }
    
    
    return headerVi;
}

- (void)createEmptyNotice
{
    [mTableView jr_configureWithPlaceHolderBlock:^UIView * _Nonnull(UITableView * _Nonnull sender) {
        UIView *headerVi = [UIView new];
        headerVi.backgroundColor = [UIColor whiteColor];
        UIButton *headBtn = headerVi.addButton;
        [headBtn setTitleColor:Colors.textAlternate forState:UIControlStateNormal];
        [headBtn setTitle:[NSString stringWithFormat:@"%lu RESULTS FOUND",(unsigned long)self->searchArr.count] forState:UIControlStateNormal];
        headBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        headBtn.titleLabel.font = [Fonts regular:13];
        [[[[[headBtn.layoutMaker leftParent:30] rightParent:30] heightEq:42] topParent:0] install];
        return headerVi;
    } normalBlock:^(UITableView * _Nonnull sender) {
        [self->mTableView setScrollEnabled:YES];
    }];
}

#pragma mark UISearchBarDelegate

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    //@"Interproximal Reduction (IPR)"
    [[DentistDataBaseManager shareManager] queryUniteArticlesCachesByKeywordList:self.magazineId keywords:searchBar.text completed:^(NSArray<DetailModel *> * _Nonnull array) {
        if (array) {
            self->searchArr = array;
            if (self->searchArr.count == 0) {
                [self createEmptyNotice];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self->mSearch resignFirstResponder];
                [self->mTableView reloadData];
            });
        }
    }];
    
}

#pragma mark UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_isSearch) {
        return 42;
    }else
    {
        return 84;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [self headerView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_isSearch) {
        return searchArr.count;
    }
    return resultArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIden = @"cell";
    UniteArticleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIden];
    if (cell == nil) {
        cell = [[UniteArticleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIden];
    }
    [cell layoutIfNeeded];
    if (_isSearch) {
        [cell bindSearchInfo:searchArr[indexPath.row]];
    }else
    {
        [cell bindInfo:resultArray[indexPath.row]];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"select this row");
    DetailModel *model = nil;
    if (self.isSearch) {
        model = searchArr[indexPath.row];
    }
    if(self.delegate && [self.delegate respondsToSelector:@selector(gotoDetailPage:)]){
        [self.delegate gotoDetailPage:model.id];
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    [mSearch resignFirstResponder];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
