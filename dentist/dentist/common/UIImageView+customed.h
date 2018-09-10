//
// Created by yet on 2018/8/18.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>

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


- (void)loadUrl:(NSString *)url placeholderImage:(NSString *)localImage;
@end