//
//  Profile.h
//  dentist
//
//  Created by wennan on 2018/9/2.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Profile : NSObject

@property (nonatomic,strong) NSString *avatatUrl;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *specialityTitle;
@property (nonatomic,strong) NSString *speciality;
@property (nonatomic,strong) NSString  *avataName;
@property (nonatomic) NSInteger  lineType;

@end
