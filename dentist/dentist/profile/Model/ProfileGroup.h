//
//  ProfileGroup.h
//  dentist
//
//  Created by wennan on 2018/9/2.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Profile.h"

@interface ProfileGroup : NSObject


@property (nonatomic,strong) NSString *groupName;
@property (nonatomic,strong) NSMutableArray *profiles;

@end
