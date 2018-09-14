//
//  DenCamera.m
//  dentist
//
//  Created by Jacksun on 2018/9/14.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "DenCamera.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@implementation DenCamera

+ (BOOL)isCameraDenied
{
    AVAuthorizationStatus author = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (author == AVAuthorizationStatusRestricted || author == AVAuthorizationStatusDenied)
    {
        return YES;
    }
    return NO;
}

+ (BOOL)isCameraNotDetermined
{
    AVAuthorizationStatus author = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (author == AVAuthorizationStatusNotDetermined)
    {
        return YES;
    }
    return NO;
}

+ (BOOL)isPhotoAlbumDenied
{
    ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
    if (author == ALAuthorizationStatusRestricted || author == ALAuthorizationStatusDenied)
    {
        return YES;
    }
    return NO;
}

+ (BOOL)isPhotoAlbumNotDetermined
{
    ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
    if (author == ALAuthorizationStatusNotDetermined)
    {
        return YES;
    }
    return NO;
}

+ (void)clickTheBtnWithSourceType:(UIImagePickerControllerSourceType)sourceType block:(void(^)(NSString *isAllow))block
{
    if (sourceType == UIImagePickerControllerSourceTypeCamera) {//user select camera
        if ([DenCamera isCameraNotDetermined]) {//first alert view
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (granted)
                    {
                        // 用户授权
                        block(@"allow");
                    }
                    else
                    {
                        // 用户拒绝授权
                        block(@"CameraRefuseFirst");
                    }
                });
                
            }];
        }else if ([DenCamera isCameraDenied])
        {
            //拒绝访问摄像头，可去设置隐私里开启
            block(@"CameraRefuse");
        }else
        {
            // 用户允许访问摄像头
            block(@"allow");
        }
    }else if (sourceType == UIImagePickerControllerSourceTypePhotoLibrary)
    {
        if ([DenCamera isPhotoAlbumNotDetermined])
        {
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (status == PHAuthorizationStatusRestricted || status == PHAuthorizationStatusDenied)
                    {
                        // 用户拒绝，跳转到自定义提示页面
                        block(@"PhotoRefuseFirst");
                    }
                    else if (status == PHAuthorizationStatusAuthorized)
                    {
                        // 用户授权，弹出相册对话框
                        block(@"allow");
                    }
                });
            }];
        }else if ([DenCamera isPhotoAlbumDenied])
        {
            // 如果已经拒绝，则弹出对话框
            block(@"PhotoRefuse");
        }
        else
        {
            // 已经授权，跳转到相册页面
            block(@"allow");
        }
    }
}

@end
