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
@interface DentistTabView()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic,strong) NSMutableArray *indexArr;
@property (nonatomic,assign) NSInteger groupCount;//
@end

@implementation DentistTabView

-(instancetype)initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame];
    if (self) {
        _groupCount=10;
        _titleArr= [NSMutableArray arrayWithArray:@[@"LATEST", @"VIDEOS", @"ARTICLES", @"PODCASTS", @"INTERVIEWS", @"TECH GUIDES", @"ANIMATIONS", @"TIP SHEETS"]];
        if(_titleArr && _titleArr.count>0){
            for (int i=0; i<_groupCount; i++) {
                for (int j=0; j<_titleArr.count; j++) {
                    [_indexArr addObject:@(j)];
                }
            }
            //        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:(_groupCount / 2 * _titleArr.count)+1 inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:false];
        }

        //自动网格布局
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
        
        CGFloat itemWidth = SCREENWIDTH*2/7.0;
        
        //设置单元格大小
        flowLayout.itemSize = CGSizeMake(itemWidth, 40);
        //最小行间距(默认为10)
        flowLayout.minimumLineSpacing = 0;
        //最小item间距（默认为10）
        flowLayout.minimumInteritemSpacing = 0;
        //设置senction的内边距
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        //设置UICollectionView的滑动方向
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
       
        //网格布局
        _collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) collectionViewLayout:flowLayout];
        _collectionView.showsHorizontalScrollIndicator = NO;
        
//        [[[[[_collectionView.layoutMaker leftParent:0] topParent:0] rightParent:0] bottomParent:0] install];
        //注册cell
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:identifier];
        //设置数据源代理
        _collectionView.dataSource = self;
        _collectionView.delegate=self;
        [self addSubview:_collectionView];
    }
    return self;
}

-(void)setTitleArr:(NSMutableArray *)titleArr
{
    _titleArr=titleArr;
    if(_titleArr && titleArr.count>0){
        for (int i=0; i<_groupCount; i++) {
            for (int j=0; j<_titleArr.count; j++) {
                [_indexArr addObject:@(j)];
            }
        }
        [_collectionView reloadData];
//        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:(_groupCount / 2 * _titleArr.count)+1 inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:false];
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
//    TabCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
//    if(!cell){
//        cell = [[TabCollectionViewCell alloc] init];
//    }
//    NSInteger index = [_indexArr[indexPath.row] integerValue];
//    cell.titleLabel.text=_titleArr[index];
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor orangeColor];
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    NSInteger index = [_indexArr[indexPath.row] integerValue];
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
    label.text=_titleArr[index];
    [cell.contentView addSubview:label];
    return cell;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"=====scrollViewDidEndDecelerating");
    CGPoint pointinview=[self convertPoint:_collectionView.center toView:_collectionView];
    NSIndexPath *indexPathNow =[_collectionView indexPathForItemAtPoint:pointinview];
    NSInteger index=(indexPathNow?indexPathNow.row:0)%_titleArr.count;
    
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:(_groupCount / 2 * _titleArr.count)+index inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:false];
}



@end
