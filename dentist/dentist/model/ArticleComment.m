//
// Created by entaoyang on 2018/9/18.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "ArticleComment.h"
#import "NSObject+NSCoding.h"
@implementation ArticleComment
-(void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeInteger:_articleId forKey:@"articleId"];
    [coder encodeObject:_authAccount forKey:@"authAccount"];
    [coder encodeObject:_authName forKey:@"authName"];
    [coder encodeObject:_authPortrait forKey:@"authPortrait"];
    [coder encodeObject:_content forKey:@"content"];
    [coder encodeObject:_publishDate forKey:@"publishDate"];
    [coder encodeInteger:_rate forKey:@"rate"];
}

-(id)initWithCoder:(NSCoder *)coder {
    if (self = [super init]) {
        _articleId = [coder decodeIntegerForKey:@"articleId"];
        _authAccount = [coder decodeObjectForKey:@"authAccount"];
        _authName = [coder decodeObjectForKey:@"authName"];
        _authPortrait = [coder decodeObjectForKey:@"authPortrait"];
        _content = [coder decodeObjectForKey:@"content"];
        _publishDate = [coder decodeObjectForKey:@"publishDate"];
        _rate = [coder decodeIntegerForKey:@"rate"];
    }
    return self;
}
@end
