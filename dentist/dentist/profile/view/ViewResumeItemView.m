//
//  ViewResumeItemView.m
//  dentist
//
//  Created by Shirley on 2018/11/23.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "ViewResumeItemView.h"
#import "common.h"

@implementation ViewResumeItemView


-(id)initWithViewController:(UIViewController*)vc{
    self = [super init];
    if (self) {
        self.vc = vc;
    }
    return self;
}

-(void)showWithLastResumeUrl:(NSString*)resumeUrl fileName:(NSString*)resumeName{
    [super showWithLastResumeUrl:resumeUrl fileName:resumeName resumeDic:nil];
}

-(void)uploadResume{
    NSLog(@"uploadResume");
}

@end
