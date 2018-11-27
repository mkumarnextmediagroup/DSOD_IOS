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
