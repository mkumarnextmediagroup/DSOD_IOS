//
//  NoticeViewController.m
//  dentist
//
//  Created by Jacksun on 2018/8/20.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "NoticeViewController.h"

@interface NoticeViewController ()

@end

@implementation NoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //add the Navigation
    
    UIImage *backImg = [UIImage imageNamed:@"close.png"];
    [self setTopTitle:@"RESLOVE YOUR ISSUE" imageName:backImg];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITextView *textView = [UITextView new];
//    textView.backgroundColor = [UIColor blueColor];
    textView.text = localStr(@"forgot");
    textView.textColor = [UIColor blackColor];
    textView.text = @"If you are getting a message saying there's no internet connection when you are onlin, please try the following things: \t First, try using the app with a different internet connection to rule out the possibility that something is blocking DSODentist from using the internet connection.\t If the app works a cellular network but not on a WIFI connection, there may be content filter enforced by the Internet Service Provider(ISP) that is blocking DSODentist from using the connection. Please check this with your ISP and if you find you have a content filter, make sure you  allow or white list the following \n domains:\n www.dsodentist.com \t app.dsodentist.com \n *.dsodentist.com \n\n If the app works on a WIFI connection and not on your cellular network, DSODDentist might not have access to your mobile data. Allow DSODDentist to access the mobile data by enabling this switch.";
    textView.font = [Fonts light:16];
    textView.frame =CGRectMake(0, NAVHEIGHT, SCREENWIDTH, SCREENHEIGHT - 120);
    [self.view addSubview:textView];
    
    UIButton *retryButton = [UIButton new];
    [retryButton title:localStr(@"Contact Us")];
    retryButton.stylePrimary;
    [self.view addSubview:retryButton];
    
    StackLayout *sl = [StackLayout new];
    [sl push:retryButton height:BTN_HEIGHT marginBottom:15];
    [sl install];
    
    [retryButton onClick:self action:@selector(contactClick:)];
    // Do any additional setup after loading the view.
}

- (void)contactClick:(UIButton *)btn
{
    NSLog(@"contact us");
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
