//
//  DsoToast.h
//  Toast
//
//  Created by li yaping on 2018/11/20.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UIView+Toast.h"

@interface DsoToast : NSObject
+(UIView *)toastViewForMessage:(NSString *)message title:(NSString * )title ishowActivity:(BOOL)ishowActivity;
+(UIView *)toastViewForMessage:(NSString *)message ishowActivity:(BOOL)ishowActivity;
@end
