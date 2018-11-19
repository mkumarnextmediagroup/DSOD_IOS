//
//  PreviewResumeViewController.m
//  dentist
//
//  Created by Shirley on 2018/11/19.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "PreviewResumeViewController.h"
#import "common.h"
#import "Proto.h"

@interface PreviewResumeViewController ()<QLPreviewControllerDataSource,QLPreviewControllerDelegate>

@end

@implementation PreviewResumeViewController

-(void)viewDidLoad{
    [super viewDidLoad];

    QLPreviewController *qlVc = [[QLPreviewController alloc] init];
    qlVc.view.frame = CGRectMake(0, NAVHEIGHT, self.view.frame.size.width, self.view.frame.size.height - NAVHEIGHT);
    qlVc.delegate = self;
    qlVc.dataSource = self;
    qlVc.navigationController.navigationBar.userInteractionEnabled = YES;
    qlVc.view.userInteractionEnabled = YES;
    [self addChildViewController:qlVc];
    [self.view addSubview:qlVc.view];
    
    UINavigationItem *item = self.navigationItem;
    item.title = @"RESUME";
    item.leftBarButtonItem = [self navBarBack:self action:@selector(onBack:)];
}

- (void)onBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - QLPreviewControllerDataSource
-(id<QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index {

    return self.fileURL;
   
}

- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)previewController{
    return 1;
}



//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//
//    //    UINavigationItem *item = [self navigationItem];
//    //    item.title = self.webTitle;
//    //    item.leftBarButtonItem = [self navBarImage:@"back_arrow" target:self  action:@selector(popBtnClick:)];
//
//
//    UIView *topVi = [UIView new];
//    topVi.backgroundColor = Colors.bgNavBarColor;
//    [self.view addSubview:topVi];
//    [[[[[topVi.layoutMaker leftParent:0] rightParent:0] topParent:0] heightEq:NAVHEIGHT] install];
//
//    UILabel *content = [topVi addLabel];
//    content.font = [Fonts semiBold:15];
//    content.textColor = [UIColor whiteColor];
//    content.text = @"aaa";
//    content.textAlignment = NSTextAlignmentCenter;
//    [[[[content.layoutMaker leftParent:(SCREENWIDTH - 200)/2] topParent:23+NAVHEIGHT_OFFSET] sizeEq:200 h:40] install];
//
//    UIButton *dismissBtn = [topVi addButton];
//    [dismissBtn setImage:[UIImage imageNamed:@"back_arrow"] forState:UIControlStateNormal];
//    [dismissBtn addTarget:self action:@selector(popBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [[[[dismissBtn.layoutMaker leftParent:0] topParent:24+NAVHEIGHT_OFFSET] sizeEq:60 h:40] install];
//
//    UIWebView *webv = [UIWebView new];
//    [self.view addSubview:webv];
//    [[[[[webv layoutMaker] sizeEq:SCREENWIDTH h:SCREENHEIGHT-NAVHEIGHT] leftParent:0] topParent:NAVHEIGHT] install];
//    webv.delegate = self;
//
////    NSString *path = [[NSBundle mainBundle] pathForResource:@"" ofType:@"html"];
////    NSString *htmlString = [NSString stringWithContentsOfFile:path
////                                                     encoding:NSUTF8StringEncoding
////                                                        error:NULL];
//
////    [webv loadHTMLString:htmlString baseURL:[[NSBundle mainBundle] bundleURL]];
//
////
////    NSString *url = @"http://dsod.aikontec.com/profile-service/v1/resumeDownload?Username=460999789@qq.com";
////
//////    url = @"https://www.tutorialspoint.com/ios/ios_tutorial.pdf";
////    NSURL *filePath = [NSURL URLWithString:url];
////    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: filePath];
////
////
////    [request addValue:strBuild(@"Bearer ", Proto.lastToken) forHTTPHeaderField:@"Authorization"];
////
////
////    url = @"file:///Users/apple/Library/Developer/CoreSimulator/Devices/A2EF1B64-C431-4BAB-9F9C-DA9670D613DC/data/Containers/Data/Application/B156FB4B-9F5D-49F2-82C0-2C1E06042E3B/tmp/com.thenextmediagroup.dentist-Inbox/a.pdf";
////
//
////    [webv loadRequest:request];
//
//
//
//
//    NSURL *filePath1 = [NSURL URLWithString:self.filePath];
//    NSURLRequest *request1 = [NSURLRequest requestWithURL: filePath1];
//    [webv loadRequest:request1];
//    //使文档的显示范围适合UIWebView的bounds
////    [myWebView setScalesPageToFit:YES];
//}
//
//- (void)webViewDidFinishLoad:(UIWebView *)webView{
//    NSLog(@"webView--------webViewDidFinishLoad");
//}
//- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
//
//    NSLog(@"webView--------%@",error);
//}
//
//- (void)popBtnClick:(id)sender {
//    NSLog(@"popBtnClick");
//    [self popPage];
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
///*
// #pragma mark - Navigation
//
// // In a storyboard-based application, you will often want to do a little preparation before navigation
// - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
// // Get the new view controller using [segue destinationViewController].
// // Pass the selected object to the new view controller.
// }
// */


@end
