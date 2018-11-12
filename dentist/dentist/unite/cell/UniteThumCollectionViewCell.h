//
//  UniteThumCollectionViewCell.h
//  dentist
//
//  Created by feng zhenrong on 2018/11/6.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UniteThumCollectionViewCellDelegate <NSObject>

@optional
- (void)UniteThumCollectionViewCellScroview:(CGFloat)offsety;
@end
NS_ASSUME_NONNULL_BEGIN

@interface UniteThumCollectionViewCell : UICollectionViewCell
@property (nonatomic,strong) UILabel *dateLabel;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *volLabel;
@property (nonatomic,strong) UIImageView *backgroundImageView;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,weak) id<UniteThumCollectionViewCellDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
