//
// Created by yet on 2018/8/18.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <SDWebImage/UIImageView+WebCache.h>
#import "UIImageView+customed.h"
#import "TapGesture.h"
#import "Platform.h"
#import "NSString+myextend.h"
#import "UIImage+GIF.h"
#import "UIImageViewLoading.h"

@implementation UIImageView (customed)


- (void)alignCenter {
	self.contentMode = UIViewContentModeCenter;
}

- (void)alignLeft {
	self.contentMode = UIViewContentModeLeft;
}

- (void)alignTop {
	self.contentMode = UIViewContentModeTop;
}

- (void)alignRight {
	self.contentMode = UIViewContentModeRight;
}

- (void)alignBottom {
	self.contentMode = UIViewContentModeBottom;
}

- (void)alignTopLeft {
	self.contentMode = UIViewContentModeTopLeft;
}

- (void)alignTopRight {
	self.contentMode = UIViewContentModeTopRight;
}

- (void)alignBottomRight {
	self.contentMode = UIViewContentModeBottomRight;
}

- (void)alignBottomLeft {
	self.contentMode = UIViewContentModeBottomLeft;
}

- (void)scaleFill {
	self.contentMode = UIViewContentModeScaleToFill;
}

- (void)scaleFit {
	self.contentMode = UIViewContentModeScaleAspectFit;
}

- (void)scaleFillAspect {
	self.contentMode = UIViewContentModeScaleAspectFill;
}

- (NSString *)imageName {
	return @"";
}

- (void)setImageName:(NSString *)name {
	self.image = [UIImage imageNamed:name];
}


- (void)onClick:(id)target action:(SEL)action {
	self.userInteractionEnabled = YES;
	TapGesture *t = [[TapGesture alloc] initWithTarget:self action:@selector(_onClickLabel:)];
	t.target = target;
	t.action = action;
	[self addGestureRecognizer:t];
}

- (void)_onClickLabel:(UITapGestureRecognizer *)recognizer {
	TapGesture *t = (TapGesture *) recognizer;
	objcSendMsg(t.target, t.action, t.view);
}

- (void)loadUrl:(NSString *)url placeholderImage:(NSString *)localImage {
    if ([self isKindOfClass:[UIImageViewLoading class]]) {
        UIImageViewLoading *newself  =(UIImageViewLoading*)self;
        newself.isShowLoading=YES;
    }
	if (url != nil && ![url isKindOfClass:NSNull.class] && [url isKindOfClass:[NSString class]]) {
        [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:localImage] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if ([self isKindOfClass:[UIImageViewLoading class]]) {
                UIImageViewLoading *newself  =(UIImageViewLoading*)self;
                newself.isShowLoading=NO;
            }
        }];
	} else {
        if ([self isKindOfClass:[UIImageViewLoading class]]) {
            UIImageViewLoading *newself  =(UIImageViewLoading*)self;
            newself.isShowLoading=NO;
        }
		self.imageName = localImage;
	}
}
- (void)loadUrl:(NSString * _Nullable)url placeholderImageNormal:(UIImage * _Nullable)localImage
{
    if ([self isKindOfClass:[UIImageViewLoading class]]) {
        UIImageViewLoading *newself  =(UIImageViewLoading*)self;
        newself.isShowLoading=YES;
    }
    if (url != nil && ![url isKindOfClass:NSNull.class] && [url isKindOfClass:[NSString class]]) {
        [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:localImage completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if ([self isKindOfClass:[UIImageViewLoading class]]) {
                UIImageViewLoading *newself  =(UIImageViewLoading*)self;
                newself.isShowLoading=NO;
            }
        }];
    } else {
        if ([self isKindOfClass:[UIImageViewLoading class]]) {
            UIImageViewLoading *newself  =(UIImageViewLoading*)self;
            newself.isShowLoading=NO;
        }
        self.image = localImage;
    }
}

-(void)loadUrl:(NSString *)url placeholderImage:(NSString *)localImage completed:(nullable SDExternalCompletionBlock)completedBlock
{
    if ([self isKindOfClass:[UIImageViewLoading class]]) {
        UIImageViewLoading *newself  =(UIImageViewLoading*)self;
        newself.isShowLoading=YES;
    }
    if (url != nil && ![url isKindOfClass:NSNull.class] && [url isKindOfClass:[NSString class]]) {
        [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:localImage] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if ([self isKindOfClass:[UIImageViewLoading class]]) {
                UIImageViewLoading *newself  =(UIImageViewLoading*)self;
                newself.isShowLoading=NO;
            }
            if (completedBlock) {
                completedBlock(image,error,cacheType,imageURL);
            }
        }];
    } else {
        if ([self isKindOfClass:[UIImageViewLoading class]]) {
            UIImageViewLoading *newself  =(UIImageViewLoading*)self;
            newself.isShowLoading=NO;
        }
        self.imageName = localImage;
        if (completedBlock) {
            completedBlock(nil,nil,SDImageCacheTypeNone,nil);
        }
    }
}

- (UIImageView *)roundedRectImageViewWithCornerRadius:(CGFloat)cornerRadius {
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:cornerRadius];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = bezierPath.CGPath;
    self.layer.mask = layer;
    return self;
}

@end
