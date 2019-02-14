//
// Created by entaoyang on 2018/9/18.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "EducationPage.h"
#import "Common.h"
#import "Proto.h"

@implementation EducationPage {

}


- (void)viewDidLoad {
	[super viewDidLoad];
    
    //test

	UINavigationItem *item = [self navigationItem];
	item.title = @"LEARNING";

	UILabel *lb = self.view.addLabel;
	lb.text = @"Education Page";
	[lb textColorMain];
	[[[lb.layoutMaker centerParent] sizeFit] install];
    //query lms category data
//    [Proto queryLMSCategoryTypes:nil completed:^(NSArray<IdName *> *array) {
//        NSLog(@"array=%@",array);
//    }];


}
@end
