//
//  UniteThumCollectionViewCell.h
//  dentist
//
//  Created by feng zhenrong on 2018/11/6.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailModel.h"

@protocol UniteThumCollectionViewCellDelegate <NSObject>

@optional
- (void)UniteThumCollectionViewCellScroview:(CGFloat)offsety;

- (void)toggleNavBar:(BOOL)show;
@end
NS_ASSUME_NONNULL_BEGIN

@interface UniteThumCollectionViewCell : UICollectionViewCell
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,weak) id<UniteThumCollectionViewCellDelegate> delegate;

-(void)bind:(DetailModel*)model;

@end

NS_ASSUME_NONNULL_END
