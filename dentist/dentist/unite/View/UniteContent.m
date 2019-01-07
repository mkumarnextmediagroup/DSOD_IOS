//
//  UniteContent.m
//  dentist
//
//  Created by Jacksun on 2018/11/1.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "UniteContent.h"
#import "Proto.h"

@interface UniteContent()<UIWebViewDelegate>

@end
#define edge 16
@implementation UniteContent
{
    UIImageView *imageView;
    UILabel *categoryLabel;
    UILabel *titleLabel;
    UILabel *authorLabel;
    UIWebView *webview;
}
- (instancetype)init {
    self = [super init];
    
    [self buildViews];
    
    return self;
}

- (void)buildViews
{
    imageView = self.addImageView;
    [imageView scaleFillAspect];
    [[[[[imageView.layoutMaker topParent:0] leftParent:0] rightParent:0] heightEq:352] install];
    
    categoryLabel = [self addLabel];
    categoryLabel.font = [Fonts semiBold:13];
    categoryLabel.textColor = rgb255(1, 122, 185);
    [[[[[categoryLabel.layoutMaker leftParent:edge] below:imageView offset:18] heightEq:24] rightParent:-90] install];
    
    titleLabel = [self addLabel];
    titleLabel.font = [Fonts semiBold:16];
    [titleLabel textColorMain];
    titleLabel.numberOfLines = 2;
    [[[[[titleLabel.layoutMaker leftParent:edge] below:categoryLabel offset:14] heightEq:50] rightParent:-90] install];
    
    authorLabel = [self addLabel];
    authorLabel.font = [Fonts semiBold:13];
    authorLabel.textColor = rgb255(155, 155, 155);
    [[[[[authorLabel.layoutMaker leftParent:edge] below:titleLabel offset:0] heightEq:24] rightParent:-90] install];
    
    webview = [UIWebView new];
    [self addSubview:webview];
    webview.delegate = self;
    [[[[[webview.layoutMaker leftParent:edge] below:authorLabel offset:edge] heightEq:240] rightParent:-edge] install];
}

-(void)bind:(DetailModel *)bindInfo
{
    NSString *urlstr;
    if (bindInfo.featuredMediaId) {
        urlstr=[Proto getFileUrlByObjectId:bindInfo.featuredMediaId];
    }
    [imageView loadUrl:urlstr placeholderImage:@"art-img"];
    [webview loadHTMLString:bindInfo.content baseURL:nil];
    categoryLabel.text = @"Think Outside The Box";
    titleLabel.text = @"Practice Success In a New World";
    authorLabel.text = @"by Richard M. Groves";
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    CGFloat webViewHeight = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"] floatValue];
    [[webview.layoutUpdate heightEq:webViewHeight] install];
}


@end
