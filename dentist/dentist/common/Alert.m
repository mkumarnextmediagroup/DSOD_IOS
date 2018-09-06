//
// Created by entaoyang@163.com on 2018/9/6.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "Alert.h"
#import "Common.h"


@implementation Alert {

}

- (void)show:(UIViewController *)c {
	UIAlertController *a = [UIAlertController alertControllerWithTitle:self.title
	                                                           message:self.msg
	                                                    preferredStyle:UIAlertControllerStyleAlert];
	NSString *okLabel = self.okText;
	if (okLabel == nil) {
		okLabel = localStr(@"ok");
	}
	UIAlertAction *okBtn = [UIAlertAction actionWithTitle:okLabel style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
		if (self.onOK != nil) {
			self.onOK();
		}
	}];
	[a addAction:okBtn];

	[c presentViewController:a animated:YES completion:nil];
}
@end