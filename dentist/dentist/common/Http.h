//
// Created by yet on 2018/8/20.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpProgress.h"
#import "HttpResult.h"

typedef void (^HttpCallback)(HttpResult *);


@interface Http : NSObject

@property NSString *url;
@property NSTimeInterval timeout;
@property id <HttpProgress> progressRecv;
@property id <HttpProgress> progressSend;


- (HttpResult *)get;

- (HttpResult *)post;

- (HttpResult *)postRaw:(NSData *)data;

- (HttpResult *)multipart;


- (void)getAsync:(HttpCallback)callback;

- (void)postAsync:(HttpCallback)callback;

- (void)multipartAsync:(HttpCallback)callback;

- (void)postRawAsync:(HttpCallback)callback;


- (void)auth:(NSString *)user value:(NSString *)pwd;

- (void)contentTypeJson;
- (void)contentType:(NSString *)value;

- (void)userAgent:(NSString *)value;

- (void)acceptJson;

- (void)acceptHtml;

- (void)accept:(NSString *)value;

- (void)arg:(NSString *)name value:(NSString *)value;
- (void) args:(NSDictionary*) dic;

- (void)header:(NSString *)name value:(NSString *)value;

- (void)file:(NSString *)name value:(NSString *)value;

- (void)fileData:(NSString *)name value:(NSData *)value;

@end
