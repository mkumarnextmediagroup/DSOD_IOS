//
//  DSOWebViewController.m
//  dentist
//
//  Created by wennan on 2018/10/13.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "DSOWebViewController.h"
#import "Proto.h"

@interface DSOWebViewController ()

@end

@implementation DSOWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UINavigationItem *item = [self navigationItem];
    item.title = self.webTitle;
    item.leftBarButtonItem = [self navBarImage:@"back_arrow" target:self  action:@selector(popBtnClick:)];
    
    WKWebView *webv = self.view.addWebview;
    [[[[[webv layoutMaker] sizeEq:SCREENWIDTH h:SCREENHEIGHT-NAVHEIGHT] leftParent:0] topParent:NAVHEIGHT] install];
    
   
    NSString *path = [[NSBundle mainBundle] pathForResource:self.localHtmlName ofType:@"html"];
    NSString *htmlString = [NSString stringWithContentsOfFile:path
                                                     encoding:NSUTF8StringEncoding
                                                        error:NULL];
    [webv loadHTMLString:htmlString baseURL:[[NSBundle mainBundle] bundleURL]];
    
}


- (void)popBtnClick:(id)sender {
    NSLog(@"popBtnClick");
    [self popPage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
