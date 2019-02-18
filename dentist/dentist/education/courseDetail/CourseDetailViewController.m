//
//  CourseDetailViewController.m
//  dentist
//
//  Created by Shirley on 2019/2/15.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "CourseDetailViewController.h"
#import "Common.h"
#import "Proto.h"
#import "CourseDescriptionViewController.h"

@interface CourseDetailViewController ()
@property (nonatomic,strong) NSString *courseId;

@property (nonatomic,strong) UIView* tableContentView;
@property (nonatomic) BOOL isCanScroll;
@property (nonatomic,strong) CourseDescriptionViewController *descriptionVC;

@end

@implementation CourseDetailViewController


/**
 open course detail page
 
 @param vc UIViewController
 @param courseId course id
 */
+(void)openBy:(UIViewController*)vc courseId:(NSString*)courseId{
    CourseDetailViewController *newVc = [CourseDetailViewController new];
    newVc.courseId = courseId;
    [vc pushPage:newVc];
}

/**
  add navigation bar
  build views
  load course detail info from server
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addNavBar];
    
    [self buildViews];
    
}


/**
 add navigation bar
 */
-(void)addNavBar{
    UINavigationItem *item = [self navigationItem];
    item.title = @"LEARNING";
    item.leftBarButtonItem = [self navBarBack:self action:@selector(dismiss)];
    
    UIBarButtonItem *shareItem = [self navBarCustomImageBtn:@"ic_nav_share" target:self action:@selector(share)];
    UIBarButtonItem *bookmarkItem = [self navBarCustomImageBtn:@"ic_nav_bookmark" target:self action:@selector(bookmark)];

    item.rightBarButtonItems  = @[bookmarkItem,[self barButtonItemSpace:20],shareItem];
}

-(void)buildViews{
    
}

-(void)bookmark{
    
}

-(void)share{
    
}

@end
