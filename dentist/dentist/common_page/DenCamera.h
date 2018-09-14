//
//  DenCamera.h
//  dentist
//
//  Created by Jacksun on 2018/9/14.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

@interface DenCamera : NSObject

+ (BOOL)isCameraDenied;

+ (BOOL)isCameraNotDetermined;

+ (BOOL)isPhotoAlbumDenied;

+ (BOOL)isPhotoAlbumNotDetermined;

+ (void)clickTheBtnWithSourceType:(UIImagePickerControllerSourceType)sourceType block:(void(^)(NSString *isAllow))block;

@end
