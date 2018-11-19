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

@interface SliderListView()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UIGestureRecognizerDelegate>
{
    UITableView *mTableView;
    UISearchBar *mSearch;
    NSArray     *infoArr;
    NSArray     *searchArr;
    UIView      *sliderView;
    UIView      *backgroundVi;
    
    BOOL        isShow;
}

@property BOOL isSearch;
@property NSString *magazineId;
@property UIView *fatherView;

@end

@implementation SliderListView

+ (instancetype)sharedInstance:(UIView *)view isSearch:(BOOL)isSearch magazineId:(NSString *)magazineId
{

    static SliderListView *instance;
    instance.fatherView = view;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[SliderListView alloc] init];
        instance.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.01];
        instance.isSearch = isSearch;
        instance.magazineId = magazineId;
        [instance initSliderView];
        [view addSubview:instance];
        instance.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
        
    });
    
    return instance;
}

- (void)showSliderView
{
    if (!isShow) {
        self.hidden = NO;
        [UIView animateWithDuration:.3 animations:^{
//            [self sendSubviewToBack:self.fatherView];
            [self.fatherView sendSubviewToBack:self];
            self->backgroundVi.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
            self->sliderView.frame = CGRectMake(132, 0, SCREENWIDTH-132, SCREENHEIGHT-NAVHEIGHT);
        }];
        isShow = YES;
    }else
    {
        [self->mSearch resignFirstResponder];
        [UIView animateWithDuration:.3 animations:^{
            [self->mSearch resignFirstResponder];
            self->sliderView.frame = CGRectMake(SCREENWIDTH, 0, SCREENWIDTH-132, SCREENHEIGHT-NAVHEIGHT);
            self->backgroundVi.frame = CGRectMake(SCREENWIDTH, 0, SCREENWIDTH, SCREENHEIGHT);
        } completion:^(BOOL finished) {
            self.hidden = YES;
        }];
        isShow = NO;
    }
}

- (void)sigleTappedPickerView:(UIGestureRecognizer *)sender
{
    isShow = NO;
    [self->mSearch resignFirstResponder];
    [UIView animateWithDuration:.3 animations:^{
        self->sliderView.frame = CGRectMake(SCREENWIDTH, 0, SCREENWIDTH-132, SCREENHEIGHT-NAVHEIGHT);
        self->backgroundVi.frame = CGRectMake(SCREENWIDTH, 0, SCREENWIDTH, SCREENHEIGHT);
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}

- (void)initSliderView
{
    backgroundVi = [self addView];
    backgroundVi.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.1];
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
    
    UIView *navVi = [self makeNavView];
    [[[[[navVi.layoutMaker leftParent:0] topParent:0] rightParent:0] heightEq:NAVHEIGHT] install];
    
    if (_isSearch) {//show the search page
        [self createSearchBar];
        [[[[mSearch.layoutMaker leftParent:8] below:navVi offset:8] sizeEq:SCREENWIDTH - 132 - 8 h:40] install];
        
        [self createTableview];
        [[[[[mTableView.layoutMaker leftParent:0] rightParent:0] below:mSearch offset:10] sizeEq:SCREENWIDTH - 132 h:SCREENHEIGHT - NAVHEIGHT-30] install];
    }else
    {
        [self createTableview];
        [[[[[mTableView.layoutMaker leftParent:0] rightParent:0] below:navVi offset:0] heightEq:SCREENHEIGHT - NAVHEIGHT] install];
    }
    
//    infoArr = [Proto uniteArticleDesc];
    [[DentistDataBaseManager shareManager] queryUniteArticlesCachesList:self.magazineId completed:^(NSArray<DetailModel *> * _Nonnull array) {
        if (array) {
            self->infoArr = array;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self->mSearch resignFirstResponder];
                [self->mTableView reloadData];
            });
        }
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
    mTableView.rowHeight = UITableViewAutomaticDimension;
    mTableView.estimatedRowHeight = 100;
    mTableView.backgroundColor = [UIColor whiteColor];
    [sliderView addSubview:mTableView];
    
}

- (UIView *)makeNavView
{
    UIView *vi = [self addView];
    vi.backgroundColor = Colors.bgNavBarColor;
    return vi;
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
        
        UILabel *editLabel = headerVi.addLabel;
        editLabel.text = @"From the editor";
        editLabel.font = [Fonts regular:14];
        [[[[[editLabel.layoutMaker leftParent:30] rightParent:30] heightEq:42] below:line1 offset:0] install];
        
        UILabel *line2 = headerVi.addLabel;
        line2.backgroundColor = [Colors cellLineColor];
        [[[[[line2.layoutMaker leftParent:0] rightParent:0] heightEq:1] below:editLabel offset:0] install];
        
        UIButton *headBtn = headerVi.addButton;
        [headBtn setTitleColor:Colors.textAlternate forState:UIControlStateNormal];
        [headBtn setTitle:@"in this Issue" forState:UIControlStateNormal];
        headBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        headBtn.titleLabel.font = [Fonts regular:13];
        [[[[[headBtn.layoutMaker leftParent:30] rightParent:30] heightEq:42] below:line2 offset:0] install];
        
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

#pragma mark UISearchBarDelegate

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [[DentistDataBaseManager shareManager] queryUniteArticlesCachesByKeywordList:self.magazineId keywords:searchBar.text completed:^(NSArray<DetailModel *> * _Nonnull array) {
        if (array) {
            self->searchArr = array;
            
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
        return 125;
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
    return infoArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIden = @"cell";
    UniteArticleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIden];
    if (cell == nil) {
        cell = [[UniteArticleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIden];
    }
    [cell layoutIfNeeded];
    if (_isSearch) {
        [cell bindInfo:searchArr[indexPath.row]];
    }else
    {
        [cell bindInfo:infoArr[indexPath.row]];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"select this row");
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
