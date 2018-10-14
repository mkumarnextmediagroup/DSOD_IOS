//
//  DentistImageBrowserToolBar.m
//  imagebrowser
//
//  Created by fengzhenrong on 2018/10/13.
//  Copyright © 2018年 fengzhenrong. All rights reserved.
//

#import "DentistImageBrowserToolBar.h"
#import "YBIBFileManager.h"
#import "YBImageBrowserTipView.h"
#import "YBIBCopywriter.h"
#import "YBIBUtilities.h"
#import "YBImageBrowseCellData.h"
#import "UIImageView+WebCache.h"

//pod 'YBImageBrowser'
//pod 'YYImage'


static CGFloat kToolBarDefaultsHeight = 50.0;

@interface DentistImageBrowserToolBar() {
    YBImageBrowserToolBarOperationBlock _operation;
    id<YBImageBrowserCellDataProtocol> _data;
}
@property (nonatomic, strong) UILabel *indexLabel;
@property (nonatomic, strong) UILabel *imagesizeLabel;
@property (nonatomic, strong) CAGradientLayer *gradient;
@end

@implementation DentistImageBrowserToolBar

@synthesize yb_browserShowSheetViewBlock = _yb_browserShowSheetViewBlock;

#pragma mark - life cycle

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.layer addSublayer:self.gradient];
        [self addSubview:self.indexLabel];
        [self addSubview:self.imagesizeLabel];
    }
    return self;
}

#pragma mark - <YBImageBrowserToolBarProtocol>

- (void)yb_browserUpdateLayoutWithDirection:(YBImageBrowserLayoutDirection)layoutDirection containerSize:(CGSize)containerSize {
    CGFloat screenheight=containerSize.height;
    CGFloat labelheight=15;
    CGFloat height = kToolBarDefaultsHeight, width = containerSize.width, hExtra = 20;
    if (containerSize.height > containerSize.width && YBIB_IS_IPHONEX) height += YBIB_HEIGHT_STATUSBAR;
    if (containerSize.height < containerSize.width && YBIB_IS_IPHONEX) hExtra += YBIB_HEIGHT_EXTRABOTTOM;
    
    self.frame = CGRectMake(0, screenheight-height, width, height);
    self.gradient.frame = self.bounds;
    self.indexLabel.frame = CGRectMake(hExtra, height/2.0-labelheight-2, width-hExtra*2, labelheight);
    self.imagesizeLabel.frame = CGRectMake(hExtra, height/2.0+2, width-hExtra*2, labelheight);
}

- (void)yb_browserPageIndexChanged:(NSUInteger)pageIndex totalPage:(NSUInteger)totalPage data:(id<YBImageBrowserCellDataProtocol>)data {
    
    self->_data = data;
    
    
    if (totalPage <= 1) {
        self.indexLabel.hidden = YES;
    } else {
        self.indexLabel.hidden  = NO;
        self.indexLabel.text = [NSString stringWithFormat:@"Image %ld of %ld", pageIndex + 1, totalPage];
        
//        YBImageBrowseCellData *celldata=data;
//        if(celldata.image){ NSLog(@"imagew=%@;imagew=%@;",@(celldata.image.size.width),@(celldata.image.size.height));
//            self.imagesizeLabel.text=[NSString stringWithFormat:@"Size:%@ × %@", @(celldata.image.size.width),@(celldata.image.size.height)];
//        }else{
//            if(celldata.url){
//                // 通过GCD的方式创建一个新的线程来异步加载图片
//                dispatch_queue_t queue =
//                dispatch_queue_create("browsercacheimage", DISPATCH_QUEUE_CONCURRENT);
//                dispatch_async(queue, ^{
//                    NSData *imageData = [NSData dataWithContentsOfURL:celldata.url];
//                    // 通知主线程更新UI
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        if (imageData) {
//                            UIImage *image = [UIImage imageWithData:imageData];
//                            self.imagesizeLabel.text=[NSString stringWithFormat:@"Size:%@ × %@", @(image.size.width),@(image.size.height)];
//                            image=nil;
//                        }
//                    });
//                });
//            }
//
//        }
    }
    if (self.detailArray && self.detailArray.count>pageIndex) {
        self.imagesizeLabel.text=[NSString stringWithFormat:@"%@",[self.detailArray objectAtIndex:pageIndex]];
    }
}

#pragma mark - getter

- (UILabel *)indexLabel {
    if (!_indexLabel) {
        _indexLabel = [UILabel new];
        _indexLabel.textColor = [UIColor grayColor];
        _indexLabel.font = [UIFont boldSystemFontOfSize:13];
        _indexLabel.textAlignment = NSTextAlignmentLeft;
        _indexLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _indexLabel;
}

- (UILabel *)imagesizeLabel {
    if (!_imagesizeLabel) {
        _imagesizeLabel = [UILabel new];
        _imagesizeLabel.textColor = [UIColor whiteColor];
        _imagesizeLabel.font = [UIFont boldSystemFontOfSize:13];
        _imagesizeLabel.textAlignment = NSTextAlignmentLeft;
        _imagesizeLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _imagesizeLabel;
}

- (CAGradientLayer *)gradient {
    if (!_gradient) {
        _gradient = [CAGradientLayer layer];
        _gradient.startPoint = CGPointMake(0.5, 0);
        _gradient.endPoint = CGPointMake(0.5, 1);
        _gradient.colors = @[(id)[UIColor colorWithRed:0  green:0  blue:0 alpha:0.3].CGColor, (id)[UIColor colorWithRed:0  green:0  blue:0 alpha:0].CGColor];
    }
    return _gradient;
}

@end
