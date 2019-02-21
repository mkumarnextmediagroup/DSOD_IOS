//
//  DentistTabView.m
//  dentist
//
//  Created by fengzhenrong on 2018/10/19.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "DentistTabView.h"
#import "Common.h"
#import "TabCollectionViewCell.h"
#import "IdName.h"

//#define itemWidth ceilf(SCREENWIDTH*2/7.0)

static NSString * identifier = @"TabCellID2";
@interface DentistTabView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    NSInteger selectIndex;
    CGFloat itemWidth;
}
@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic,strong) NSMutableArray *indexArr;
@property (nonatomic,assign) NSInteger groupCount;//
@end

@implementation DentistTabView

-(instancetype)initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame];
    if (self) {
        [self loadView];
    }
    return self;
}

-(instancetype)init
{
    self =[super init];
    if (self) {
        [self loadView];
    }
    return self;
}

-(void)loadView{
    _isBackFistDelegate=YES;
    UILabel *lineLabel=self.lineLabel;
    [[[[[lineLabel.layoutMaker leftParent:0] rightParent:0] topParent:0] heightEq:1] install];
    _isScrollEnable=YES;
    _isScrollToFirst=YES;
    itemWidth=ceilf(SCREENWIDTH*2/7.0);
    _groupCount=100;
    _indexArr=[[NSMutableArray alloc] init];
    //自动网格布局
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
    
    //设置单元格大小
    //        flowLayout.itemSize = CGSizeMake(itemWidth, 51);
    //        flowLayout.estimatedItemSize=CGSizeMake(itemWidth, 51);
    //        flowLayout.itemSize=UICollectionViewFlowLayoutAutomaticSize;
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
    _collectionView.scrollEnabled=YES;
    [self addSubview:_collectionView];
    [[[[[_collectionView.layoutMaker leftParent:0] topParent:1] rightParent:0] bottomParent:0] install];
    //设置数据源代理
    _collectionView.dataSource = self;
    _collectionView.delegate=self;
    
    //注册cell
    [_collectionView registerClass:[TabCollectionViewCell class] forCellWithReuseIdentifier:identifier];
    
}

-(void)setIsScrollEnable:(BOOL)isScrollEnable{
    _isScrollEnable=isScrollEnable;
    _collectionView.scrollEnabled=_isScrollEnable;
}

-(void)setItemCount:(NSInteger)itemCount
{
    _itemCount=itemCount;
    if (_itemCount>0) {
        itemWidth=(SCREENWIDTH/_itemCount);
    }
}

-(void)setTitleArr:(NSMutableArray *)titleArr
{
    [self layoutIfNeeded];
    _titleArr=titleArr;
    if(_titleArr && titleArr.count>0){
        for (int i=0; i<_groupCount; i++) {
            for (int j=0; j<_titleArr.count; j++) {
                [_indexArr addObject:@(j)];
            }
        }
        [_collectionView reloadData];
        selectIndex=(_groupCount / 2 * _titleArr.count);
        NSLog(@"selectindex=%@",@(selectIndex));
//        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:selectIndex+2 inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:false];
        
        [_collectionView setContentOffset:CGPointMake((selectIndex*itemWidth),0) animated:YES];
        if (_indexArr.count>selectIndex) {
            NSInteger index = [_indexArr[selectIndex] integerValue];
            if (self.isBackFistDelegate && self.delegate && [self.delegate respondsToSelector:@selector(didDentistSelectItemAtIndex:)]) {
                [self.delegate didDentistSelectItemAtIndex:index];
            }
        }
        
    }
}

-(void)setModelArr:(NSMutableArray<IdName *> *)modelArr
{
    _modelArr=modelArr;
    if(_modelArr && _modelArr.count>0){
        for (int i=0; i<_groupCount; i++) {
            for (int j=0; j<_modelArr.count; j++) {
                [_indexArr addObject:@(j)];
            }
        }
        [_collectionView reloadData];
        selectIndex=(_groupCount / 2 * _modelArr.count);
        NSLog(@"selectindex=%@",@(selectIndex));
        //        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:selectIndex+2 inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:false];
        
        [_collectionView setContentOffset:CGPointMake((selectIndex*itemWidth),0) animated:YES];
        if (_indexArr.count>selectIndex) {
            NSInteger index = [_indexArr[selectIndex] integerValue];
            if (self.isBackFistDelegate && self.delegate && [self.delegate respondsToSelector:@selector(didDentistSelectItemAtIndex:)]) {
                [self.delegate didDentistSelectItemAtIndex:index];
            }
        }
        
    }
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(itemWidth, self.frame.size.height);
}


#pragma mark - deleDate
//有多少的分组
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
    
}
//每个分组里有多少个item
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _indexArr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //根据identifier从缓冲池里去出cell
    TabCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    NSInteger index = [_indexArr[indexPath.row] integerValue];
    if(_modelArr){
        IdName *model=_modelArr[index];
        cell.titleLabel.text=[model.name uppercaseString];
    }else{
        //wanglibo remove uppercaseString because some places not need
        cell.titleLabel.text=_titleArr[index];
    }
    
    if (selectIndex==indexPath.row) {
        [cell.backgroundImageView setImage:[UIImage imageNamed:@"seg-sel"]];
    }else{
        [cell.backgroundImageView setImage:[UIImage imageNamed:@"seg-bg"]];
    }
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    selectIndex=indexPath.row;
    if (_indexArr.count>selectIndex) {
        NSInteger index = [_indexArr[selectIndex] integerValue];
//        NSLog(@"index=%@",@(selectIndex));
        //     [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:selectIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:false];
        if (_isScrollToFirst) {
            [_collectionView setContentOffset:CGPointMake((selectIndex*itemWidth),0) animated:YES];
        }
        [_collectionView reloadData];
//        CGRect rectInTableView = [_collectionView rectForRowAtIndexPath:indexPath];
//        NSLog(@"rectInTableView=========%@",NSStringFromCGSize(rectInTableView));
        if (self.delegate && [self.delegate respondsToSelector:@selector(didDentistSelectItemAtIndex:)]) {
            [self.delegate didDentistSelectItemAtIndex:index];
        }
    }
    
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat height = scrollView.frame.size.width;
    CGFloat contentOffsetX = scrollView.contentOffset.x;//scrollView.contentOffset.
    CGFloat bottomOffset = scrollView.contentSize.width - contentOffsetX;
    if(contentOffsetX<=0){
        //在最底部
        [_collectionView setContentOffset:CGPointMake((selectIndex*itemWidth),0) animated:YES];
    }
    if (bottomOffset <= height)
    {
        //在最底部
       [_collectionView setContentOffset:CGPointMake((selectIndex*itemWidth),0) animated:YES];
    }
    
}

//-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
////    NSLog(@"=====scrollViewDidEndDecelerating");
////    CGPoint pointinview=[self convertPoint:_collectionView.center toView:_collectionView];
////    NSIndexPath *indexPathNow =[_collectionView indexPathForItemAtPoint:pointinview];
////    NSInteger index=(indexPathNow?indexPathNow.row:0)%_titleArr.count;
////    NSLog(@"index=%@",@(index));
////    NSLog(@"(_groupCount / 2 * _titleArr.count)=%@",@((_groupCount / 2 * _titleArr.count)));
//
////    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:(_groupCount / 2 * _titleArr.count)*itemWidth inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:false];
//
//    [_collectionView setContentOffset:CGPointMake((selectIndex*itemWidth),0) animated:YES];
//}



@end
