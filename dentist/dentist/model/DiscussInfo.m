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
    [coder encodeObject:_starCount forKey:@"starCount"];
    [coder encodeObject:_disDate forKey:@"disDate"];
    [coder encodeObject:_content forKey:@"content"];
}

-(id)initWithCoder:(NSCoder *)coder {
    if (self = [super init]) {
        _disImg = [coder decodeObjectForKey:@"disImg"];
        _name = [coder decodeObjectForKey:@"name"];
        _starCount = [coder decodeObjectForKey:@"starCount"];
        _disDate = [coder decodeObjectForKey:@"disDate"];
        _content = [coder decodeObjectForKey:@"content"];
    }
    return self;
}
@end
