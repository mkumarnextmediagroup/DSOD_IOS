//
//  UploadData.h
//  dentist
//
//  Created by Jacksun on 2018/9/9.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@protocol UploadData;

@interface UploadData : JSONModel

@property(nullable) NSString <Optional> *uploadName;
@property(nullable) NSString <Optional> *detailLabel;


@end
