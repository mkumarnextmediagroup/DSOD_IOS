//
//  ThumAndDetailViewController.m
//  dentist
//
//  Created by feng zhenrong on 2018/11/6.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "ThumAndDetailViewController.h"
#import "common.h"
#import "UniteThumCollectionViewCell.h"
#import "CMSDetailViewController.h"
#import "DetailModel.h"
#import "dentist-Swift.h"
#import "DsoToast.h"

static NSString * UniteThumidentifier = @"UniteThumCellID";
@interface ThumAndDetailViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UniteThumCollectionViewCellDelegate>{
    
    BOOL hiddenStatusBar;
    
}

@property (nonatomic, strong) UICollectionView * collectionView;
@end

@implementation ThumAndDetailViewController

@synthesize currentIndex = _currentIndex ;


- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat _topBarH = 0;
    CGFloat _bottomBarH = 0;
    if (self.navigationController != nil) {
        _topBarH = NAVHEIGHT;
    }
    if (self.tabBarController != nil) {
        _bottomBarH = TABLEBAR_HEIGHT;
    }
    
    CGFloat collectheight=self.view.frame.size.height;
    
//    [self setupNavigation];
    //自动网格布局
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
    //设置单元格大小
    flowLayout.itemSize = CGSizeMake(self.view.frame.size.width, collectheight);
    //最小行间距(默认为10)
    flowLayout.minimumLineSpacing = 0;
    //最小item间距（默认为10）
    flowLayout.minimumInteritemSpacing = 0;
    //设置senction的内边距
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    //设置UICollectionView的滑动方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    //网格布局
    _collectionView=[[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.backgroundColor=[UIColor whiteColor];
    _collectionView.pagingEnabled = YES;
    
    [self.view addSubview:_collectionView];
    
    //设置数据源代理
    _collectionView.dataSource = self;
    _collectionView.delegate=self;
    
    //注册cell
    [_collectionView registerClass:[UniteThumCollectionViewCell class] forCellWithReuseIdentifier:UniteThumidentifier];
    [[[[[_collectionView.layoutMaker leftParent:0] rightParent:0] topParent:0] bottomParent:0] install];
    
    // Do any additional setup after loading the view.
}


-(void)setupNavigation{
    UINavigationItem *item = [self navigationItem];
    item.title = @"";
    
    item.leftBarButtonItem = [self navBarBack:self action:@selector(onBack:)];
    
    UIButton *menuBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [menuBtn1 addTarget:self action:@selector(openMenu:) forControlEvents:UIControlEventTouchUpInside];
    [menuBtn1 setImage:[UIImage imageNamed:@"Content-Options"] forState:UIControlStateNormal];
    UIBarButtonItem *menuBtnItem1 = [[UIBarButtonItem alloc] initWithCustomView:menuBtn1];
    
    UIBarButtonItem *fixedSpaceBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedSpaceBarButtonItem.width = 22;
    
    UIButton *menuBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [menuBtn2 addTarget:self action:@selector(openMenu:) forControlEvents:UIControlEventTouchUpInside];
    [menuBtn2 setImage:[UIImage imageNamed:@"More-Options"] forState:UIControlStateNormal];
    [menuBtn2 sizeToFit];
    UIBarButtonItem *menuBtnItem2 = [[UIBarButtonItem alloc] initWithCustomView:menuBtn2];
    
    
    self.navigationItem.rightBarButtonItems  = @[menuBtnItem2,fixedSpaceBarButtonItem,menuBtnItem1];
    
}

-(void)setModelarr:(NSArray<DetailModel *> *)modelarr
{
    _modelarr=modelarr;
    _collectionView.contentSize = CGSizeMake(_modelarr.count * self.view.frame.size.width, 0);
    [self.collectionView reloadData];
}

-(void)setCurrentIndex:(NSInteger)currentIndex{
    _currentIndex=currentIndex;

    [self.collectionView reloadData];
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:_currentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally  animated:YES];
}

-(NSInteger)currentIndex{
    return _currentIndex;
}

- (void)onBack:(UIButton *)btn {
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)openMenu:(UIButton *)btn{
    NSLog(@"%@",btn);
}

#pragma mark - deleDate
//有多少的分组
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
    
}
//每个分组里有多少个item
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _modelarr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //根据identifier从缓冲池里去出cell
    UniteThumCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:UniteThumidentifier forIndexPath:indexPath];
    cell.delegate=self;
    if (_modelarr.count>indexPath.row) {
        [cell bind:_modelarr[indexPath.row]];
    }
    
    
    return cell;
}

-(void)UniteThumCollectionViewCellScroview:(CGFloat)offsety
{
    if (offsety<-120) {
        //两种方式调用
        if (self.scrollToDown) {
            self.scrollToDown(offsety);
        }
        if(self.delegate && [self.delegate respondsToSelector:@selector(ThumAndDetailViewControllerDidScroll:)]){
            [self.delegate ThumAndDetailViewControllerDidScroll:offsety];
        }
    }
}


- (void)hideNavBar:(BOOL)hide{
    hiddenStatusBar = hide;
    [self.navVC setNavigationBarHidden:hide animated:YES];
    [self setNeedsStatusBarAppearanceUpdate];
    
}

- (BOOL)prefersStatusBarHidden{
    return hiddenStatusBar;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger row=floorf(scrollView.contentOffset.x/scrollView.frame.size.width);
    _currentIndex=row;
    if (self.didEndDecelerating) {
        self.didEndDecelerating(_currentIndex);
    }
}

@end
