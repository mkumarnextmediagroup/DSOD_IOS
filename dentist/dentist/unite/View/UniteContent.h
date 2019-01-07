//
//  UniteContent.h
//  dentist
//
//  Created by Jacksun on 2018/11/1.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"
#import "DetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface UniteContent : UIView

- (void)bind:(DetailModel *)bindInfo;
- (void)webViewDidFinishLoad:(UIWebView *)webView;

@end

NS_ASSUME_NONNULL_END
