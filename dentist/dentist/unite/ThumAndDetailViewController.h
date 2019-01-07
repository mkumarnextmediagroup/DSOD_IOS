//
//  ThumAndDetailViewController.h
//  dentist
//
//  Created by feng zhenrong on 2018/11/6.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailModel.h"

@class DetailModel;
@protocol ThumAndDetailViewControllerDelegate <NSObject>

@optional
- (void)ThumAndDetailViewControllerDidScroll:(CGFloat)offsety;
@end

@interface ThumAndDetailViewController : UIViewController
@property (nonatomic,strong) NSArray<DetailModel*> *modelarr;
@property (nonatomic,strong) MagazineModel *magazineModel;
@property (nonatomic,assign) BOOL isbookmark;
@property (nonatomic,assign) NSInteger currentIndex;
@property (nonatomic,copy) void(^scrollToDown)(CGFloat y);
@property (nonatomic,copy) void(^didEndDecelerating)(NSInteger index);
@property (nonatomic,weak) id<ThumAndDetailViewControllerDelegate> delegate;
@property (nonatomic,weak) UINavigationController *navVC;

- (void)setupNavigation;
- (void)setModelarr:(NSArray<DetailModel *> *)modelarr;
- (void)onBack:(UIButton *)btn;
- (void)openMenu:(UIButton *)btn;
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView;
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
- (void)UniteThumCollectionViewCellScroview:(CGFloat)offsety;
- (void)hideNavBar:(BOOL)hide;
- (BOOL)prefersStatusBarHidden;
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;

@end
