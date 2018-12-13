//
// Created by yet on 2018/8/18.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (customed)

-(UIImage*) scaledTo:(CGFloat) w h:(CGFloat)h ;
-(UIImage*) scaledBy:(CGFloat) f ;
+ (UIImage*)getGrayImage:(UIImage*)sourceImage;
+(UIImage*)imageWithColor:(UIColor*)color andHeight:(CGFloat)height;
- (UIImage *)roundedCornerImageWithCornerRadius:(CGFloat)cornerRadius;
- (UIImage *)imageWihtSize:(CGSize)size radius:(CGFloat)radius backColor:(UIColor *)backColor;
+ (UIImage *)image:(UIImage *)image size:(CGSize)size cornerRadius:(CGFloat)cornerRadius;
@end
