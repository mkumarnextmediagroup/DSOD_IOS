//
//  DentistImageBrowserToolBar.h
//  imagebrowser
//
//  Created by fengzhenrong on 2018/10/13.
//  Copyright © 2018年 fengzhenrong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YBImageBrowserToolBarProtocol.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^YBImageBrowserToolBarOperationBlock)(id<YBImageBrowserCellDataProtocol> data);

@interface DentistImageBrowserToolBar : UIView <YBImageBrowserToolBarProtocol>

@property (nonatomic, strong, readonly) CAGradientLayer *gradient;
@property (nonatomic, strong, readonly) UILabel *indexLabel;
@property (nonatomic, strong, readonly) UILabel *imagesizeLabel;
@property (nonatomic, copy) NSArray *detailArray;

@end
NS_ASSUME_NONNULL_END
