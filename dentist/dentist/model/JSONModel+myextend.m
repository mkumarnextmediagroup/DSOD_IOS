//
// Created by entaoyang on 2018/9/6.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "JSONModel+myextend.h"


@implementation JSONModel (myextend)

- (id)initWithJson:(NSString *)string {
	JSONModelError *err = nil;
    id objModel = [self initWithString:string error:&err];
//    NSLog(@"jsonmodelerr=%@",err);
    return objModel;
}
@end
