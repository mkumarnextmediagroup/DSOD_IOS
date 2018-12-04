//
// Created by entaoyang on 2018/9/18.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "CareerExplorePage.h"
#import "Common.h"
#import "DSOProfilePage.h"
#import "UIButton+styled.h"
#import "FilterView.h"
#import "MyTabBarViewController.h"
#import "AppDelegate.h"
#import "Proto.h"

#define kMaxBtnCount 4
#define leftToX 20
#define IMAGE_HEIGHT SCREENWIDTH*253/375
#define FUNBTN_WIDTH ([[UIScreen mainScreen] bounds].size.width - 24*2)/2
#define FUNBTN_HEIGHT IPHONE_X?((SCREENHEIGHT-IMAGE_HEIGHT-NAVHEIGHT-65-leftToX*3)/2):((SCREENHEIGHT-IMAGE_HEIGHT-NAVHEIGHT-50-leftToX*3)/2)//FUNBTN_WIDTH*9/16

@implementation CareerExplorePage {
    NSArray *titleArr;
    NSArray *imageArr;
    UIImageView *img;
}

- (void)viewDidLoad {
	[super viewDidLoad];
    
	UINavigationItem *item = [self navigationItem];
	item.title = @"CAREER";
    titleArr = [NSArray arrayWithObjects:@"Search",@"Me",@"Review",@"DSO Profiles", nil];
    imageArr = [NSArray arrayWithObjects:@"career-search",@"career-me",@"career-review",@"career-profiles", nil];
    //d1d0d0
    [self createFunBtn];
    
    [Proto findExtensionCompleted:^(NSString *picUrl) {
        NSLog(@"%@",picUrl);
        [self->img sd_setImageWithURL:[NSURL URLWithString:picUrl] placeholderImage:[UIImage imageNamed:@"career-image"]];
    }];
    
//    UIBlurEffect *blurEffect =[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
//    UIVisualEffectView *effectView =[[UIVisualEffectView alloc]initWithEffect:blurEffect];
//    effectView.frame = CGRectMake(0,0,self.view.frame.size.width, self.view.frame.size.height);
//    [self.view addSubview:effectView];

    
}

- (void)createFunBtn
{
    img = [UIImageView new];
    [self.view addSubview:img];
    [[[[img.layoutMaker sizeEq:SCREENWIDTH h:IMAGE_HEIGHT] topParent:NAVHEIGHT] leftParent:0] install];
    img.image = [UIImage imageNamed:@"career-image"];
    
    UILabel *content = self.view.addLabel;
    content.font = [Fonts heavy:26];
    content.numberOfLines = 2;
    content.textColor = [UIColor whiteColor];
    content.text = @" Employment Opportunities";
    [[[[content.layoutMaker sizeEq:200 h:70] topParent:IMAGE_HEIGHT-20] leftParent:(SCREENWIDTH-200)/2] install];
    
    
    for (int i=0; i<kMaxBtnCount; i++) {
        UIButton *funBtn = self.view.addButton;
//        [funBtn setBackgroundColor:[UIColor greenColor]];

        [funBtn setTitle:titleArr[i] forState:UIControlStateNormal];
        [funBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        funBtn.titleLabel.font = [Fonts semiBold:17];
        [funBtn.layer setMasksToBounds:YES];
        [funBtn setImage:[UIImage imageNamed:imageArr[i]] forState:UIControlStateNormal];
        [funBtn.layer setCornerRadius:3.0]; //设置矩形四个圆角半径
        [funBtn addTarget:self action:@selector(functionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        funBtn.tag = 10+i;
        //边框宽度
        [funBtn.layer setBorderWidth:1.0];
        funBtn.layer.borderColor=rgb255(209, 208, 208).CGColor;
        funBtn.imageEdgeInsets = UIEdgeInsetsMake(- (funBtn.frame.size.height - funBtn.titleLabel.frame.size.height- funBtn.titleLabel.frame.origin.y),(funBtn.frame.size.width -funBtn.titleLabel.frame.size.width)/2.0f -funBtn.imageView.frame.size.width, 0, 0);
        funBtn.titleEdgeInsets = UIEdgeInsetsMake(funBtn.frame.size.height-funBtn.imageView.frame.size.height-funBtn.imageView.frame.origin.y, -funBtn.imageView.frame.size.width, 0, 0);
        
        if (i < 2) {
            [[[[funBtn.layoutMaker sizeEq:FUNBTN_WIDTH h:FUNBTN_HEIGHT] leftParent:leftToX + (FUNBTN_WIDTH + 15) * i] below:img offset:leftToX] install];
        }else
        {
            float offset = FUNBTN_HEIGHT;
            [[[[funBtn.layoutMaker sizeEq:FUNBTN_WIDTH h:FUNBTN_HEIGHT] leftParent:leftToX + (FUNBTN_WIDTH + 15) * (i%2)] below:img offset:offset+leftToX+15] install];
        }
        [funBtn verticalImageAndTitle:10];
    }
}


- (void)functionBtnClick:(UIButton *)btn
{
    if (btn.tag == 13) {//DSO Profile button
        NSLog(@"DSO Profile");
        UIViewController *viewController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
        DSOProfilePage *dso = [DSOProfilePage new];
        UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:dso];
        [viewController presentViewController:navVC animated:YES completion:NULL];

    }else if (btn.tag == 12)//review button click
    {
        [[FilterView initSliderView] showFilter];
    }else if (btn.tag == 10){
        AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        MyTabBarViewController *tabvc=(MyTabBarViewController *)appdelegate.careersPage;
        [tabvc tabbarSelected:1];
    }
}

@end
