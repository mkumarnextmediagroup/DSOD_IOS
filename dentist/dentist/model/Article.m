//
// Created by entaoyang on 2018/9/18.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "Article.h"
#import "ArticleComment.h"
#import "NSObject+NSCoding.h"

@implementation Article
-(void)encodeWithCoder:(NSCoder *)coder {
//    [self autoEncodeWithCoder:coder];
    [coder encodeInteger:_id forKey:@"id"];
    [coder encodeObject:_type forKey:@"type"];
    [coder encodeObject:_title forKey:@"title"];
    [coder encodeObject:_title forKey:@"title"];
    [coder encodeObject:_content forKey:@"content"];
    [coder encodeObject:_subContent forKey:@"subContent"];
    [coder encodeObject:_publishDate forKey:@"publishDate"];
    [coder encodeObject:_gskString forKey:@"gskString"];
    [coder encodeObject:_authAccount forKey:@"authAccount"];
    [coder encodeObject:_authName forKey:@"authName"];
    [coder encodeObject:_authAdd forKey:@"authAdd"];
    [coder encodeObject:_resImage forKey:@"resImage"];
    [coder encodeObject:_resType forKey:@"resType"];
    
    [coder encodeBool:_isSponsor forKey:@"isSponsor"];
    [coder encodeBool:_isBookmark forKey:@"isBookmark"];
    [coder encodeBool:_isDownload  forKey:@"isDownload"];
    [coder encodeObject:_comments forKey:@"comments"];
    [coder encodeObject:_discussInfo forKey:@"discussInfo"];
}

-(id)initWithCoder:(NSCoder *)coder {
    if (self = [super init]) {
        _id = [coder decodeIntegerForKey:@"id"];
        _type = [coder decodeObjectForKey:@"type"];
        _title = [coder decodeObjectForKey:@"title"];
        _content = [coder decodeObjectForKey:@"content"];
        _subContent = [coder decodeObjectForKey:@"subContent"];
        _publishDate = [coder decodeObjectForKey:@"publishDate"];
        _gskString = [coder decodeObjectForKey:@"gskString"];
        _authAccount = [coder decodeObjectForKey:@"authAccount"];
        _authName = [coder decodeObjectForKey:@"authName"];
        _authAdd = [coder decodeObjectForKey:@"authAdd"];
        _resImage = [coder decodeObjectForKey:@"resImage"];
        _resType = [coder decodeObjectForKey:@"resType"];
        _isSponsor = [coder decodeBoolForKey:@"isSponsor"];
        _isBookmark = [coder decodeBoolForKey:@"isBookmark"];
        _isDownload = [coder decodeBoolForKey:@"isDownload"];
        _comments = [coder decodeObjectForKey:@"comments"];
        _discussInfo = [coder decodeObjectForKey:@"discussInfo"];
    }
    return self;
}
@end
