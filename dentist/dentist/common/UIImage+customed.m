//
// Created by yet on 2018/8/18.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "UIImage+customed.h"
#import "Common.h"


@implementation UIImage (customed)

- (UIImage *)scaledTo:(CGFloat)w h:(CGFloat)h {
	UIGraphicsBeginImageContext(makeSizeF(w, h));
	[self drawInRect:makeRectF(0, 0, w, h)];
	UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return img;
}

- (UIImage *)scaledBy:(CGFloat)f {
	CGFloat w = self.size.width * f;
	CGFloat h = self.size.height * f;
	return [self scaledTo:w h:h];
}

+ (UIImage*)getGrayImage:(UIImage*)sourceImage
{
    int width = sourceImage.size.width;
    int height = sourceImage.size.height;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate (nil,width,height,8,0,colorSpace,kCGImageAlphaNone);
    CGColorSpaceRelease(colorSpace);
    
    if (context == NULL) {
        return nil;
    }
    
    CGContextDrawImage(context,CGRectMake(0, 0, width, height), sourceImage.CGImage);
    CGImageRef grayImageRef = CGBitmapContextCreateImage(context);
    UIImage *grayImage = [UIImage imageWithCGImage:grayImageRef];
    CGContextRelease(context);
    CGImageRelease(grayImageRef);
    
    return grayImage;
}
+ (UIImage*)imageWithColor:(UIColor*)color andHeight:(CGFloat)height
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImage *)roundedCornerImageWithCornerRadius:(CGFloat)cornerRadius {
    CGRect rect = (CGRect){0 ,0, self.size};
    // size——同UIGraphicsBeginImageContext,参数size为新创建的位图上下文的大小
    // opaque—透明开关，如果图形完全不用透明，设置为YES以优化位图的存储。
    // scale—–缩放因子
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [UIScreen mainScreen].scale);
    // 根据矩形画带圆角的曲线
//    [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius] addClip];
    [[UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerBottomLeft |UIRectCornerBottomRight cornerRadii:CGSizeMake(10,10)] addClip];
    [self drawInRect:rect];
    // 图片缩放，是非线程安全的
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭上下文
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)image:(UIImage *)image size:(CGSize)size cornerRadius:(CGFloat)cornerRadius {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);//创建画板
    CGContextRef context = UIGraphicsGetCurrentContext();//获取画布
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    CGContextAddPath(context, path.CGPath);//设置画布路径（显示的内容）
    CGContextClip(context);//截取路径
    [image drawInRect:rect];//将画板的内容画进image(image不会显示的)
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();//获取画布上的内容并赋值
    UIGraphicsEndImageContext();//关闭制图
    return newImage;
    
}

- (UIImage *)imageWihtSize:(CGSize)size radius:(CGFloat)radius backColor:(UIColor *)backColor{
    // 利用绘图建立上下文
    UIGraphicsBeginImageContextWithOptions(size, true, 0);
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    // 填充颜色
    [backColor setFill];
    UIRectFill(rect);
    // 贝塞尔裁切
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius];
    [path addClip];
    [self drawInRect:rect];
    
    // 获取结果
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭上下文
    UIGraphicsEndImageContext();
    return resultImage;
}

+(UIImage *)getmakeImageWithView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0.0);
    
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return image;
    
}

//+ (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)size
//{
//    if (image.size.width*size.height <= image.size.height*size.width) {
//
//        CGFloat width  = image.size.width;
//        CGFloat height = image.size.width * size.height / size.width;
//
//        // 调用剪切方法
//        // 这里是以中心位置剪切，也可以通过改变rect的x、y值调整剪切位置
//        return [self imageForImage:image rect:CGRectMake(0, (image.size.height -height)/2, width, height)];
//
//    }else{ //被切图片宽比例比高比例大，以图片高进行剪裁
//
//        // 以被剪切图片的高度为基准，得到剪切范围的大小
//        CGFloat width  = image.size.height * size.width / size.height;
//        CGFloat height = image.size.height;
//
//        // 调用剪切方法
//        // 这里是以中心位置剪切，也可以通过改变rect的x、y值调整剪切位置
//        return [self imageForImage:image rect:CGRectMake((image.size.width -width)/2, 0, width, height)];
//    }
//    return nil;
//}
//
//+ (UIImage *)imageForImage:(UIImage *)image rect:(CGRect)rect
//{
//    CGImageRef sourceImageRef = [image CGImage];
//    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);
//    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
//    CGImageRelease(newImageRef);
//    return newImage;
//}

@end
