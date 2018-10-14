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
    
//    UINavigationItem *item = [self navigationItem];
//    item.title = self.webTitle;
//    item.leftBarButtonItem = [self navBarImage:@"back_arrow" target:self  action:@selector(popBtnClick:)];
    
    
    UIView *topVi = [UIView new];
    topVi.backgroundColor = Colors.bgNavBarColor;
    [self.view addSubview:topVi];
    [[[[[topVi.layoutMaker leftParent:0] rightParent:0] topParent:0] heightEq:NAVHEIGHT] install];
    
    UILabel *content = [topVi addLabel];
    content.font = [Fonts semiBold:15];
    content.textColor = [UIColor whiteColor];
    content.text = self.webTitle;
    content.textAlignment = NSTextAlignmentCenter;
    [[[[content.layoutMaker leftParent:(SCREENWIDTH - 200)/2] topParent:23+NAVHEIGHT_OFFSET] sizeEq:200 h:40] install];
    
    UIButton *dismissBtn = [topVi addButton];
    [dismissBtn setImage:[UIImage imageNamed:@"back_arrow"] forState:UIControlStateNormal];
    [dismissBtn addTarget:self action:@selector(popBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [[[[dismissBtn.layoutMaker leftParent:0] topParent:24+NAVHEIGHT_OFFSET] sizeEq:60 h:40] install];
    
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
