//
// Created by entaoyang on 2018/8/29.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HttpResult : NSObject

@property NSData *data;
@property NSHTTPURLResponse *response;
@property NSError *error;

@property(readonly) BOOL OK;
@property(readonly) int httpCode;
@property(readonly) NSString *strBody;

-(void) dump;

@end