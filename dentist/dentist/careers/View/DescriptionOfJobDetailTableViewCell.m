//
//  DescriptionOfJobDetailTableViewCell.m
//  dentist
//
//  Created by Shirley on 2018/11/29.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "DescriptionOfJobDetailTableViewCell.h"
#import "common.h"

@interface DescriptionOfJobDetailTableViewCell() <UIWebViewDelegate>
@end

@implementation DescriptionOfJobDetailTableViewCell {

    UIWebView *mywebView;
    UIView *lastView ;
    
    
    int edge;
   
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        edge = 18;
        [self buildView];
    }
    return self;
}

-(void)buildView{
   
    mywebView = [UIWebView new];
    mywebView.delegate = self;
    mywebView.scrollView.scrollEnabled = NO;
    mywebView.userInteractionEnabled = NO;
    mywebView.backgroundColor=[UIColor clearColor];
    [self addSubview:mywebView];
    [[[[[[mywebView.layoutMaker leftParent:0]rightParent:0] topParent:edge]bottomParent:-edge]heightEq:1] install];
    
    
    
    
}


-(void)setData:(JobModel*)model{
    if(model.jobDescription){
        [self showContent:model.jobDescription];
    }
}


-(void)showContent:(NSString*)html{
    [mywebView loadHTMLString:[self htmlString:html] baseURL:nil];
}



- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    //禁止用户选择
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    
    //禁止长按弹出选择框
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
    
    CGFloat webViewHeight = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"] floatValue];
    
    
    [self.tableView beginUpdates];
//    [mywebView.layoutUpdate.height.mas_equalTo(webViewHeight).with.priority(1000) install];
    [[mywebView.layoutUpdate heightEq:webViewHeight] install];
    [self.tableView endUpdates];
    
}

- (NSString *)htmlString:(NSString *)html{
    NSString *htmlString = [NSString stringWithFormat:@"%@%@%@%@%@ %@%@%@%@%@ %@%@%@",
                            @"<meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0'><meta name='apple-mobile-web-app-capable' content='yes'><meta name='apple-mobile-web-app-status-bar-style' content='black'><meta name='format-detection' content='telephone=no'>",
                            @"<style type=\"text/css\">",
                            @"body{padding:0px;margin:0px;background:#fff;font-family:SFUIText-Regular;font-size:0.9em;color:#4a4a4a}",
                            @"p{margin: 10px auto;padding-left:18px;padding-right:18px}",
                            @"h1,h2,h3,h4,h5,h6{font-size:1.1em;padding-left:18px;padding-right:18px}",
                            @"ol,ul{background:#fff;margin-left:18px;margin-right:18px;padding-left:18px;}",
                            @"em{font-style:normal}",
                            @".first-big p:first-letter{float: left;font-size:2.8em;margin-top:-6px;margin-bottom:-18px;margin-right:5px;text-transform:uppercase;color:#879aa8;}",
                            @"blockquote{color:#4a4a4a;font-size:1.1em;font-weight:bold;margin: 20px 50px 10px 50px;position:relative;line-height:110%;text-indent:0px；background:#f00}",
                            @"blockquote:before{color:#4a4a4a;font-family:PingFangTC-Regular;content:'“';font-size:1.6em;position:absolute;left:-20px;top:15px;line-height:.1em}",
                            //@"blockquote:after{color:#4a4a4a;content:'”';font-size:5em;position:absolute;right:15px;bottom:0;line-height:.1em}"
                            @"figure{ margin:0 auto; background:#fff; }",
                            @"figure img{width:100%;height:''} img{width:100%;height:auto}",
                            @"</style>"
                            ];
//    html = [html stringByReplacingOccurrencesOfString :@"<p>&nbsp;</p>" withString:@""];
//    html = [html stringByReplacingOccurrencesOfString :@"</p>\r\n</p>" withString:@""];
    
    
    return [htmlString stringByAppendingString:html];
}

@end
