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

static NSString * UniteThumidentifier = @"UniteThumCellID";
@interface ThumAndDetailViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UniteThumCollectionViewCellDelegate>
@property (nonatomic, strong) UICollectionView * collectionView;
@end

@implementation ThumAndDetailViewController

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
     _collectionView.contentSize = CGSizeMake(3 * self.view.frame.size.width, 0);
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
    [self.collectionView reloadData];
//    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally  animated:YES];
}

-(void)setCurrentIndex:(NSInteger)currentIndex
{
    _currentIndex=currentIndex;
    [self.collectionView reloadData];
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:_currentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally  animated:YES];
}

- (void)onBack:(UIButton *)btn {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)openMenu:(UIButton *)btn{
    
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
    cell.backgroundColor=[UIColor clearColor];
    cell.delegate=self;
    if (indexPath.row==0) {
        UIImage *image1=[UIImage imageNamed:@"unitedetail1"];
        [cell.backgroundImageView setImage:image1];
        cell.backgroundImageView.frame=CGRectMake(0, NAVHEIGHT, cell.backgroundImageView.frame.size.width, 1000*cell.backgroundImageView.frame.size.width/747);
        cell.scrollView.contentSize =  CGSizeMake(0, image1.size.height);
    }else if (indexPath.row==1){
        UIImage *image2=[UIImage imageNamed:@"unitedetail2"];
        [cell.backgroundImageView setImage:image2];
        cell.backgroundImageView.frame=CGRectMake(0, NAVHEIGHT, cell.backgroundImageView.frame.size.width, 16130*cell.backgroundImageView.frame.size.width/750);
        cell.scrollView.contentSize =  CGSizeMake(0, image2.size.height);
        
        
        CMSDetailViewController *vc = [CMSDetailViewController new];
        vc.contentId = @"5be5df7f5a71b7249c07e064";
        
        [cell.scrollView addSubview:vc.view];
    }else{
        UIImage *image3=[UIImage imageNamed:@"unitedetail3"];
        [cell.backgroundImageView setImage:image3];
        cell.backgroundImageView.frame=CGRectMake(0, NAVHEIGHT, cell.backgroundImageView.frame.size.width, 7970*cell.backgroundImageView.frame.size.width/750);
        cell.scrollView.contentSize =  CGSizeMake(0, image3.size.height);
    }
    cell.backgroundImageView.contentMode=UIViewContentModeScaleToFill;
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{}


-(void)UniteThumCollectionViewCellScroview:(CGFloat)offsety
{
    if (offsety<-80) {
        //两种方式调用
        if (self.scrollToDown) {
            self.scrollToDown(offsety);
        }
        if(self.delegate && [self.delegate respondsToSelector:@selector(ThumAndDetailViewControllerDidScroll:)]){
            [self.delegate ThumAndDetailViewControllerDidScroll:offsety];
        }
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
//    NSLog(@"=====scrollViewDidEndDecelerating=%F",scrollView.contentOffset.x);
//    CGFloat xw=scrollView.contentOffset.x+SCREENWIDTH;
//    NSInteger row=floorf(xw/scrollView.contentSize.width)+1;
//    NSLog(@"=====scrollViewDidEndDecelerating=%f;row=%@",scrollView.contentOffset.x,@(row));
//    if (scrollView.contentOffset.x<=SCREENWIDTH/2) {
//        row=0;
//    }
//    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally  animated:YES];
    NSInteger row=floorf(scrollView.contentOffset.x/scrollView.frame.size.width);
    _currentIndex=row;
    if (self.didEndDecelerating) {
        self.didEndDecelerating(_currentIndex);
    }
}

@end
