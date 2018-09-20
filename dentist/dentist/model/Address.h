//
// Created by entaoyang on 2018/9/6.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSONModel.h"

@protocol Address;

@interface Address : JSONModel

@property(nullable) NSString <Optional> *stateLabel;
@property(nullable) NSString <Optional> *city;
@property(nullable) NSString <Optional> *zipCode;
@property(nullable) NSString <Optional> *address1;
@property(nullable) NSString <Optional> *address2;

@property (readonly) NSString* detailAddress;

@end