//
//  DiscussInfo.m
//  dentist
//
//  Created by 孙兴国 on 2018/9/20.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "DiscussInfo.h"
#import "NSObject+NSCoding.h"
@implementation DiscussInfo
-(void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:_disImg forKey:@"disImg"];
    [coder encodeObject:_name forKey:@"name"];
    [coder encodeInteger:_commentRating forKey:@"starCount"];
    [coder encodeObject:_createTime forKey:@"disDate"];
    [coder encodeObject:_commentText forKey:@"content"];
}

-(id)initWithCoder:(NSCoder *)coder {
    if (self = [super init]) {
        _disImg = [coder decodeObjectForKey:@"disImg"];
        _name = [coder decodeObjectForKey:@"name"];
        _commentRating = [coder decodeIntegerForKey:@"starCount"];
        _createTime = [coder decodeObjectForKey:@"disDate"];
        _commentText = [coder decodeObjectForKey:@"content"];
    }
    return self;
}
@end
