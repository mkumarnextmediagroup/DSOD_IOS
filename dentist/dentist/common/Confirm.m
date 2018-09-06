//
// Created by entaoyang@163.com on 2018/9/6.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "Confirm.h"
#import "Common.h"


@implementation Confirm {

}
- (void)show:(UIViewController *)c onOK:(void (^)(void))onOK {
	UIAlertController *a = [UIAlertController alertControllerWithTitle:self.title
	                                                           message:self.msg
	                                                    preferredStyle:UIAlertControllerStyleAlert];
	NSString *okLabel = self.okText;
	if (okLabel == nil) {
		okLabel = localStr(@"ok");
	}
	UIAlertAction *okBtn = [UIAlertAction actionWithTitle:okLabel style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
		if (onOK != nil) {
			onOK();
		}
	}];
	[a addAction:okBtn];


	NSString *cancelLabel = self.cancelText;
	if (cancelLabel == nil) {
		cancelLabel = localStr(@"cancel");
	}
	UIAlertAction *cancelBtn = [UIAlertAction actionWithTitle:cancelLabel style:UIAlertActionStyleCancel handler:nil];
	[a addAction:cancelBtn];

	[c presentViewController:a animated:YES completion:nil];
}
@end