//
//  NoticeViewController.m
//  dentist
//
//  Created by Jacksun on 2018/8/20.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "NoticeViewController.h"
#import "ContactViewController.h"
#import "Common.h"

@interface NoticeViewController ()

@end

@implementation NoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //add the Navigation
    
    UIImage *backImg = [UIImage imageNamed:@"close.png"];
    [self setTopTitle:@"RESOLVE YOUR ISSUE" bgColor:[UIColor whiteColor] imageName:backImg];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITextView *textView = [UITextView new];
//    textView.backgroundColor = [UIColor blueColor];
    textView.text = localStr(@"issue_context");
    textView.editable = NO;
    textView.textColor = [UIColor blackColor];
    textView.font = [Fonts light:16];
    textView.frame =CGRectMake(0, NAVHEIGHT, SCREENWIDTH, SCREENHEIGHT - 120);
    [self.view addSubview:textView];
    
    UIButton *retryButton = [UIButton new];
    [retryButton title:localStr(@"Contact Us")];
    retryButton.stylePrimary;
    [self.view addSubview:retryButton];
    
    StackLayout *sl = [StackLayout new];
    [sl push:retryButton height:BTN_HEIGHT marginBottom:15+TABLEBAR_SAFE_BOTTOM_MARGIN];
    [sl install];
    
    [retryButton onClick:self action:@selector(contactClick:)];
    // Do any additional setup after loading the view.
}

- (void)contactClick:(UIButton *)btn
{
    NSLog(@"contact us");
    ContactViewController *contact = [ContactViewController new];
    [self openPage:contact];
}

@end
