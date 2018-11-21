//
// Created by yet on 2018/8/19.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "NSString+myextend.h"
#import "Common.h"


@implementation NSString (myextend)

- (NSString *)base64Encoded {
	NSData *d = self.dataUTF8;
	return [d base64EncodedStringWithOptions:0];
}

- (NSString *)base64Decoded {
	NSData *d = [[NSData alloc] initWithBase64EncodedString:self options:0];
	return d.stringUTF8;
}

- (BOOL)containsChar:(unichar)ch {
	for (int i = 0; i < self.length; ++i) {
		if (ch == [self characterAtIndex:i]) {
			return YES;
		}
	}
	return NO;
}

- (unichar)lastChar {
	if (self.length == 0) {
		return 0;
	}
	return [self characterAtIndex:self.length - 1];
}

- (NSString *)textAddPhoneNor {
    NSMutableString *compStr = [[NSMutableString alloc] initWithCapacity:15];
    for (int i = 0; i < self.length; i++) {
        NSString *letter = [self substringWithRange:NSMakeRange(i,1)];
        if (i == 3 || i == 6) {
            [compStr appendString:@"-"];
        }
        [compStr appendString:letter];
    }
    return compStr;
}

+ (NSString *)timeWithTimeIntervalString:(NSString *)timeString
{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"America/Chicago"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"MMM dd, yyyy"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]/ 1000.0];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}

- (NSString *)urlEncoded {
	return [self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

- (NSData *)dataUTF8 {
	return [self dataUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)trimed {
	return [self stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
}

- (BOOL)match:(NSString *)reg {
	NSPredicate *p = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", reg];
	return [p evaluateWithObject:self];
}

- (BOOL)matchEmail {
	return [self match:REG_EMAIL];
}

- (BOOL)matchPassword {
	return [self match:MATCH_PWD];
}

- (NSString *)add:(NSString *)s {
	return [self stringByAppendingString:s];
}

+(BOOL)isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    string=[NSString stringWithFormat:@"%@",string];
    if ([string isEqualToString:@"(null)"]) {
        return YES;
    }
    if ([string isEqualToString:@"<null>"]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}
//正则去除标签
+(NSString *)getWithoutHtmlString:(NSString *)string{
    NSRegularExpression *regularExpretion=[NSRegularExpression regularExpressionWithPattern:@"<[^>]*>|\n"
                                                                                    options:0
                                                                                      error:nil];
    string=[regularExpretion stringByReplacingMatchesInString:string options:NSMatchingReportProgress range:NSMakeRange(0, string.length) withTemplate:@""];
    return string;
}

+ (NSString *)webHtmlString:(NSString *)html
{
    NSString *htmlString = [NSString stringWithFormat:@"%@%@%@%@%@ %@%@%@%@%@ %@",
                            @"<meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0'><meta name='apple-mobile-web-app-capable' content='yes'><meta name='apple-mobile-web-app-status-bar-style' content='black'><meta name='format-detection' content='telephone=no'>",
                            @"<style type=\"text/css\">",
                            @"body{padding:0px;margin:0px;background:#fff;font-family:SFUIText-Regular;}",
                            @"p{width:100%;margin: 10px auto;color:#4a4a4a;font-size:0.9em;}",
                            @"em{font-style:normal}",
                            @".first-big p:first-letter{float: left;font-size:1.9em;padding-right:8px;text-transform:uppercase;color:#4a4a4a;}",
                            @"blockquote{color:#4a4a4a;font-size:1.2em;font-weight:bold;margin: 20px 10px 10px 25px;position:relative;line-height:110%;text-indent:0px}",
                            @"blockquote:before{color:#4a4a4a;font-family:PingFangTC-Regular;content:'“';font-size:1.6em;position:absolute;left:-20px;top:15px;line-height:.1em}",
                            //@"blockquote:after{color:#4a4a4a;content:'”';font-size:5em;position:absolute;right:15px;bottom:0;line-height:.1em}"
                            @"figure{ margin:0 auto; background:#fff; }",
                            @"figure img{width:100%;height:''} img{width:100%;height:auto}",
                            @"</style>"
                            ];
    
    
    html = [html stringByReplacingOccurrencesOfString :@"pre" withString:@"blockquote"];
    html = [html stringByReplacingOccurrencesOfString :@"<p>&nbsp;</p>" withString:@""];
    //    html = [self htmlRemoveReferences:html];
    
    BOOL isFirst = YES;
    NSArray *array = [html componentsSeparatedByString:@"<p>"];
    for (int i = 0; i < [array count]; i++) {
        NSString *currentString = [array objectAtIndex:i];
        if(i>0){
            if([currentString rangeOfString:@"<iframe"].location !=NSNotFound){
                continue;
            }
            if(isFirst){
                //错误格式兼容<strong> </strong>厉害了中间还不是空格
                //                 htmlString = [htmlString stringByReplacingOccurrencesOfString :@"<strong> </strong>" withString:@""];
                htmlString = [NSString stringWithFormat:@"%@<div class='first-big'><p>%@</div>",htmlString,currentString];
                isFirst = NO;
            }else{
                htmlString = [NSString stringWithFormat:@"%@<p>%@",htmlString,currentString];
            }
        }
    }
    
    //地址跳转测试
    //    htmlString = [NSString stringWithFormat:@"%@%@",htmlString,@"<p><a href=\"dsodentistapp://com.thenextmediagroup.dentist/openCMSDetail?articleId=5be29d5f0e88c608b8186e52\">Converting Invisalign brand online consumers to new patients</a></p>"];
    
    htmlString = [NSString stringWithFormat:@"%@%@%@%@",
                  htmlString,
                  @"<script type=\"text/javascript\">",
                  @"var figureArr = document.getElementsByTagName('figure');",
                  @"for (let i = 0;i < figureArr.length;i++){figureArr[i].style.width = '100%'}"
                  @"</script>"
                  ];
    
    return htmlString;
}

@end


__attribute__((overloadable))   NSString *strBuild(NSString *value, NSString *v2) {
	if (value == nil) {
		return v2;
	}
	if (v2 == nil) {
		return value;
	}
	return [value stringByAppendingString:v2];
}

__attribute__((overloadable))   NSString *strBuild(NSString *value, NSString *v2, NSString *v3) {
	return strBuild(strBuild(value, v2), v3);
}

__attribute__((overloadable))   NSString *strBuild(NSString *value, NSString *v2, NSString *v3, NSString *v4) {
	return strBuild(strBuild(value, v2, v3), v4);
}

__attribute__((overloadable))   NSString *strBuild(NSString *value, NSString *v2, NSString *v3, NSString *v4, NSString *v5) {
	return strBuild(strBuild(value, v2, v3, v4), v5);
}

__attribute__((overloadable))   NSString *strBuild(NSString *value, NSString *v2, NSString *v3, NSString *v4, NSString *v5, NSString *v6) {
	return strBuild(strBuild(value, v2, v3, v4, v5), v6);
}

__attribute__((overloadable))   NSString *strBuild(NSString *value, NSString *v2, NSString *v3, NSString *v4, NSString *v5, NSString *v6, NSString *v7) {
	return strBuild(strBuild(value, v2, v3, v4, v5, v6), v7);
}

__attribute__((overloadable))   NSString *strBuild(NSString *value, NSString *v2, NSString *v3, NSString *v4, NSString *v5, NSString *v6, NSString *v7, NSString *v8) {
	return strBuild(strBuild(value, v2, v3, v4, v5, v6, v7), v8);
}

__attribute__((overloadable))   NSString *strBuild(NSString *value, NSString *v2, NSString *v3, NSString *v4, NSString *v5, NSString *v6, NSString *v7, NSString *v8, NSString *v9) {
	return strBuild(strBuild(value, v2, v3, v4, v5, v6, v7, v8), v9);
}

