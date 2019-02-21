//
//  AboutViewController.m
//  dentist
//
//  Created by Shirley on 2019/1/5.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "AboutViewController.h"
#import "Common.h"
#import "DentistTabView.h"

@interface AboutViewController ()<DentistTabViewDelegate>

@end

@implementation AboutViewController{
    
    //content webView
    UIWebView *mywebView;
}


/**
 Open about page
 @param vc UIViewController
 */
+(void)openBy:(UIViewController*)vc {
    AboutViewController *newVc = [AboutViewController new];
    [vc pushPage:newVc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self addNavBar];
    
    [self buildViews];
}

/**
 add navigation bar
 */
-(void)addNavBar{
    UINavigationItem *item = [self navigationItem];
    item.title = @"ABOUT";
    item.leftBarButtonItem = [self navBarBack:self action:@selector(dismiss)];
}

/**
 build views
 */
-(void)buildViews{
    self.view.backgroundColor = UIColor.whiteColor;
    
    DentistTabView *tabView = [DentistTabView new];
    [self.view addSubview:tabView];
    tabView.isScrollEnable=NO;
    tabView.isScrollToFirst=NO;
    tabView.itemCount=2;
    tabView.delegate=self;
    [[[[[tabView.layoutMaker leftParent:0] rightParent:0] topParent:NAVHEIGHT]heightEq:50]  install];
    tabView.titleArr=[NSMutableArray arrayWithArray:@[@"Privacy Policy",@"Terms of Service"]];
    
    
    mywebView = [UIWebView new];
    mywebView.scrollView.scrollEnabled = YES;
    mywebView.userInteractionEnabled = YES;
    mywebView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:mywebView];
    [[[[[mywebView.layoutMaker leftParent:0]rightParent:0] below:tabView offset:0]bottomParent:0] install];
    
    [self didDentistSelectItemAtIndex:0];
}



#pragma mark DentistTabViewDelegate
/**
 DentistTabView Delegate
 Tab change callback
 @param index Currently selected tab index
 */
- (void)didDentistSelectItemAtIndex:(NSInteger)index{
    NSString *fileName = @"";
    switch (index) {
        case 0:
            fileName = @"DSODentist_Privacy_Policy";
            break;
        case 1:
            fileName = @"DSODentist_Terms_of_Service";
            break;
            
        default:
            break;
    }
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"html"];
    NSString *htmlString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    [mywebView loadHTMLString:htmlString baseURL:[[NSBundle mainBundle] bundleURL]];
}


@end
