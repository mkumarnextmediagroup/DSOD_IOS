//
//  DentistDownloadButton.m
//  DentistProject
//
//  Created by feng zhenrong on 2019/2/28.
//  Copyright © 2019年 thenextmediagroup.com. All rights reserved.
//

#import "DentistDownloadButton.h"
#import "Common.h"

@interface DentistDownloadButton () {
    id _target;
    SEL _action;
}

@property (nonatomic, weak) UILabel *proLabel;    // 进度标签
@property (nonatomic, weak) UIImageView *imgView; // 状态视图

@end

@implementation DentistDownloadButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        
        // 百分比标签
        UILabel *proLabel = [[UILabel alloc] initWithFrame:self.bounds];
        proLabel.font = [UIFont boldSystemFontOfSize:15.0f];
        proLabel.textColor = [UIColor colorWithRed:0/255.0 green:191/255.0 blue:255/255.0 alpha:1];
        proLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:proLabel];
        _proLabel = proLabel;
        
        // 状态视图
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:self.bounds];
        imgView.backgroundColor = UIColor.whiteColor;
        imgView.image = [UIImage imageNamed:@"com_download_default"];
        [self addSubview:imgView];
        _imgView = imgView;
    }
    
    return self;
}

- (void)setProgress:(CGFloat)progress
{
    _progress = progress;

    _proLabel.text = [NSString stringWithFormat:@"%d%%", (int)floor(progress * 100)];

    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    if(_state == DentistDownloadStateDownloading){
        CAShapeLayer *layer = [CAShapeLayer new];
        layer.lineWidth = 3;
        layer.strokeColor = rgbHex(0x37c872).CGColor;
        layer.fillColor = [UIColor clearColor].CGColor;
        CGFloat radius = (MIN(rect.size.width, rect.size.height) - layer.lineWidth - 1) * 0.5;
        CGPoint center =(CGPoint){rect.size.width * 0.5, rect.size.height * 0.5};
        
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius
            startAngle:M_PI * 1.5 endAngle:M_PI * 1.5 + M_PI * 2 * _progress  clockwise:YES];
        
        layer.path = [path CGPath];
        [self.layer addSublayer:layer];
        
    }else{
        NSArray<CALayer *> *subLayers = self.layer.sublayers;
        NSArray<CALayer *> *removedLayers = [subLayers filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
            return [evaluatedObject isKindOfClass:[CAShapeLayer class]];
        }]];
        [removedLayers enumerateObjectsUsingBlock:^(CALayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperlayer];
        }];
    }
    
}

- (void)setModel:(DentistDownloadModel *)model
{
    _model = model;

    self.state = model.state;
}

- (void)setState:(DentistDownloadState)state
{
//    _imgView.hidden = state == DentistDownloadStateDownloading;
//    _proLabel.hidden = !_imgView.hidden;
    
    //暂时需求下载时不显示数字进度
    _imgView.hidden = NO;
    _proLabel.hidden = YES;
    
    switch (state) {
        case DentistDownloadStateDefault:
            _imgView.image = [UIImage imageNamed:@"com_download_default"];
            break;

        case DentistDownloadStateDownloading:
            _imgView.image = [UIImage imageNamed:@"com_download_default"];
            break;
            
        case DentistDownloadStateWaiting:
            _imgView.image = [UIImage imageNamed:@"com_download_waiting"];
            break;
            
        case DentistDownloadStatePaused:
            _imgView.image = [UIImage imageNamed:@"com_download_pause"];
            break;
            
        case DentistDownloadStateFinish:
            _imgView.image = [UIImage imageNamed:@"com_download_finish"];
            break;
            
        case DentistDownloadStateError:
            _imgView.image = [UIImage imageNamed:@"com_download_error"];
            break;
            
        default:
            break;
    }
    
    _state = state;
}

- (void)addTarget:(id)target action:(SEL)action
{
    _target = target;
    _action = action;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (_state == DentistDownloadStateDefault || _state == DentistDownloadStatePaused || _state == DentistDownloadStateError) {
        // 点击默认、暂停、失败状态，调用开始下载
        [[DentistDownloadManager shareManager] startDownloadTask:_model];
        
    }else if (_state == DentistDownloadStateDownloading || _state == DentistDownloadStateWaiting) {
        // 点击正在下载、等待状态，调用暂停下载
        [[DentistDownloadManager shareManager] pauseDownloadTask:_model];
    }

    if (!_target || !_action) return;
    ((void (*)(id, SEL, id))[_target methodForSelector:_action])(_target, _action, self);
}

@end
