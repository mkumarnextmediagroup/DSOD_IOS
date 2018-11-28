//
// Created by yet on 2018/8/18.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>
@interface UIImageView (customed)

@property NSString *imageName;

- (void)onClick:(id)target action:(SEL)action;

- (void)scaleFill;

- (void)scaleFit;

- (void)scaleFillAspect;

- (void)alignCenter;

- (void)alignLeft;

- (void)alignTop;

- (void)alignRight;

- (void)alignBottom;

- (void)alignTopLeft;

- (void)alignTopRight;

- (void)alignBottomRight;

- (void)alignBottomLeft;


- (void)loadUrl:(NSString * _Nullable)url placeholderImage:(NSString * _Nullable)localImage;
-(void)loadUrl:(NSString * _Nullable)url placeholderImage:(NSString * _Nullable)localImage completed:(nullable SDExternalCompletionBlock)completedBlock;
@end
