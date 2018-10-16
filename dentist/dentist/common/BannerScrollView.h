//
//  BannerView.h
//  dentist
//
//  Created by fengzhenrong on 2018/10/16.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger){
    BannerPageAlignNone,        //不显示分页
    BannerPageAlignLeft,        //分页左对齐
    BannerPageAlignCenter,      //分页居中
    BannerPageAlignRight        //分页右对齐
}BannerPageAlign;

typedef void(^ClickWithBlock)(NSInteger index);


@interface BannerScrollView : UIView

@property (nonatomic, strong)   UIColor *pageIndicatorTintColor;
@property (nonatomic, strong)   UIColor *currentPageIndicatorTintColor;

/**
 *  分页对齐方式,默认居中对齐
 */
@property (nonatomic, assign)   BannerPageAlign pageAlign;

/**
 *  创建本地图片
 *
 *  @param imageNames   图片名字数组
 *  @param block        点击block
 *  @return             创建本地图片，不自动切换
 */
-(void)addWithImageNames:(NSArray *)imageNames clickBlock:(ClickWithBlock)block;


/**
 *  创建本地图片
 *
 *  @param imageNames   图片名字数组
 *  @param block        点击block
 *  @param timeInterval 自动切换时间(0为不切换)
 *  @return             创建本地图片
 */
-(void)addWithImageNames:(NSArray *)imageNames autoTimerInterval:(NSTimeInterval)timeInterval clickBlock:(ClickWithBlock)block;


/**
 *  创建网络图片
 *
 *  @param imageNames    图片名字数组
 *  @param block         点击block
 *  @return              创建网络图片，不自动切换
 */
-(void)addWithImageUrls:(NSArray *)imageUrls clickBlock:(ClickWithBlock)block;

/**
 *  创建网络图片
 *
 *  @param imageNames   图片名字数组
 *  @param block        点击block
 *  @param timeInterval 自动切换时间(0为不切换)
 *  @return             创建网络图片
 */
-(void)addWithImageUrls:(NSArray *)imageUrls autoTimerInterval:(NSTimeInterval)timeInterval clickBlock:(ClickWithBlock)block;


/**
 *  更换图片地址
 *
 *  @param imageUrls    图片地址
 */
-(void)replaceImageUrls:(NSArray *)imageUrls clickBlock:(ClickWithBlock)block;


/**
 *  更换图片
 *
 *  @param imageNames   图片文件名
 */
-(void)replaceImageNames:(NSArray *)imageNames clickBlock:(ClickWithBlock)block;

@end
