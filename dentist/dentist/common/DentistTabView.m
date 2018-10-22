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
static NSString * identifier = @"TabCellID2";
@interface DentistTabView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    NSInteger selectIndex;
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
        
    }
    return self;
}

-(instancetype)init
{
    self =[super init];
    if (self) {
        _groupCount=4;
        _indexArr=[[NSMutableArray alloc] init];
        //自动网格布局
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
        
        
        CGFloat itemWidth = ceilf(SCREENWIDTH*2/7.0);

        //设置单元格大小
        flowLayout.itemSize = CGSizeMake(itemWidth, 51);
//        flowLayout.estimatedItemSize=CGSizeMake(itemWidth, 40);
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
        _collectionView.backgroundColor=[UIColor grayColor];
        [self addSubview:_collectionView];
        [[[[[_collectionView.layoutMaker leftParent:0] topParent:0] rightParent:0] heightEq:51.0] install];
        //设置数据源代理
        _collectionView.dataSource = self;
        _collectionView.delegate=self;
        
        //注册cell
        [_collectionView registerClass:[TabCollectionViewCell class] forCellWithReuseIdentifier:identifier];
       
        
    }
    return self;
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
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:selectIndex+1 inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:false];
    }
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
    cell.titleLabel.text=_titleArr[index];
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
     [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:selectIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:false];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"=====scrollViewDidEndDecelerating");
    CGPoint pointinview=[self convertPoint:_collectionView.center toView:_collectionView];
    NSIndexPath *indexPathNow =[_collectionView indexPathForItemAtPoint:pointinview];
    NSInteger index=(indexPathNow?indexPathNow.row:0)%_titleArr.count;
    NSLog(@"index=%@",@(index));
    NSLog(@"(_groupCount / 2 * _titleArr.count)=%@",@((_groupCount / 2 * _titleArr.count)));
    
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:(_groupCount / 2 * _titleArr.count)+index+1 inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:false];
}



@end
