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

@interface SliderListView()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    UITableView *mTableView;
    UISearchBar *mSearch;
    NSArray     *infoArr;
    NSArray     *searchArr;
}
@end

@implementation SliderListView

- (void)initSliderView
{
    _isSearch = YES;
    self.backgroundColor = [UIColor whiteColor];
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
    
    infoArr = [Proto uniteArticleDesc];
}

- (void)createSearchBar
{
    mSearch = [UISearchBar new];
    mSearch.placeholder = @"Search ...";
    mSearch.delegate = self;
    mSearch.showsCancelButton = NO;
    mSearch.searchBarStyle = UISearchBarStyleMinimal;
    [self addSubview:mSearch];
}

- (void)createTableview
{
    mTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    mTableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    mTableView.dataSource = self;
    mTableView.delegate = self;
    mTableView.backgroundColor = [UIColor whiteColor];
    [self addSubview:mTableView];
    
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
        [headBtn setTitle:@"2 RESULTS FOUND" forState:UIControlStateNormal];
        headBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        headBtn.titleLabel.font = [Fonts regular:13];
        [[[[[headBtn.layoutMaker leftParent:30] rightParent:30] heightEq:42] topParent:0] install];
    }
    
    
    return headerVi;
}

#pragma mark UISearchBarDelegate

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    UniteArticles *article = [UniteArticles new];
    article.issueHeading = @"TRANFORM YOUR THINKING";
    article.issueSubHeading = @"Understanding the DSO practice Model";
    
    UniteArticles *article1 = [UniteArticles new];
    article1.issueHeading = @"GOING PRO";
    article1.issueSubHeading = @"Making the leap from Student to Professional";
    
    searchArr = [NSArray arrayWithObjects:article,article1, nil];
    
    [mTableView reloadData];
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
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIden = @"cell";
    UniteArticleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIden];
    if (cell == nil) {
        cell = [[UniteArticleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIden];
    }
    if (_isSearch) {
        [cell bindInfo:searchArr[indexPath.row]];
    }else
    {
        [cell bindInfo:infoArr[indexPath.row]];
    }
    return cell;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
