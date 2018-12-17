//
//  UIImageViewLoading.m
//  dentist
//
//  Created by feng zhenrong on 2018/12/13.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "UIImageViewLoading.h"
#import "UIImage+GIF.h"
@interface UIImageViewLoading()
@property (nonatomic,strong) UIImageView *loadingImageview;
@end
@implementation UIImageViewLoading

-(instancetype)init
{
    self = [super init];
    
    if (self)
    {
        [self addSubview:self.loadingImageview];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self)
    {
        [self addSubview:self.loadingImageview];
        
    }
    return self;
}

-(void)setIsShowLoading:(BOOL)isShowLoading
{
    _isShowLoading=isShowLoading;
     _loadingImageview.hidden=!_isShowLoading;
}

-(UIImageView *)loadingImageview{
    if (!_loadingImageview) {
        _loadingImageview=[UIImageView new];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"loading" ofType:@"gif"];
        NSData *data = [NSData dataWithContentsOfFile:path];
        _loadingImageview.image=[UIImage sd_animatedGIFWithData:data];
    }
    return _loadingImageview;
}

-(void)setLoadingImageViewFrame
{
    CGFloat superw=(self.frame.size.width/3.0);
    if (self.frame.size.width>self.frame.size.height) {
        superw=(self.frame.size.height/3.0);
    }
    self.loadingImageview.frame=CGRectMake(0, 0, superw, superw);
    self.loadingImageview.center=self.center;
}

-(void)layoutSubviews{
    [self setLoadingImageViewFrame];
}

@end
