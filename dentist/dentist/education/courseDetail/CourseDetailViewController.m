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
#import "CourseDetailReviewsViewController.h"
#import "CourseDetailLessonsViewController.h"
#import "CourseModel.h"
#import "AllowMultiGestureTableView.h"
#import "NSDate+customed.h"

@interface CourseDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) NSString *courseId;

@property (nonatomic,strong) UIView* tableContentView;
@property (nonatomic) BOOL isCanScroll;
@property (nonatomic,strong) CourseDetailLessonsViewController *lessonsVC;
@property (nonatomic,strong) CourseDescriptionViewController *descriptionVC;
@property (nonatomic,strong) CourseDetailReviewsViewController *reviewsVC;



@end

@implementation CourseDetailViewController{
    CourseModel *courseModel;
    
    int edge;
    
    UIView *contentView;
    UITableView *tableView;
    
    UILabel *lessonsLabel;
    UIView *lessonsTabLine;
    UILabel *descriptionLabel;
    UIView *descriptonTabLine;
    UILabel *reviewsLabel;
    UIView *reviewsTabLine;
    
    

}


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
    
    
    edge = 18;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self addNavBar];
    
    [self setupTableContentVC];
    
    [self loadData];
}


/**
 add navigation bar
 */
-(void)addNavBar{
    UINavigationItem *item = [self navigationItem];
    item.title = @"LEARNING";
    item.leftBarButtonItem = [self navBarBack:self action:@selector(dismiss)];
    
    if(courseModel){
        UIBarButtonItem *shareItem = [self navBarCustomImageBtn:@"ic_nav_share" target:self action:@selector(share)];
        UIBarButtonItem *bookmarkItem = [self navBarCustomImageBtn:@"ic_nav_bookmark" target:self action:@selector(bookmark)];

        item.rightBarButtonItems  = @[bookmarkItem,[self barButtonItemSpace:20],shareItem];
    }
}

/**
 load course detail info from server
 */
-(void)loadData{
    
    [self showLoading];
    [Proto findCourseDetail:self.courseId completed:^(BOOL success, NSString *msg, CourseModel *courseModel) {
        [self hideLoading];
        if(success){
            [self addNavBar];
            
            [self buildViews:courseModel];
        }else{
            [self alertMsg:[NSString isBlankString:msg]?@"Failed to get data":msg onOK:^{
                [self dismiss];
            }];
        }
        
    }];
}


/**
 build views and show course info
 build table view and table view header

 @param courseModel CourseModel instance
 
 */
-(void)buildViews:(CourseModel*)courseModel{
    self->courseModel = courseModel;
    
    contentView  = self.view.addView;
    [[[[[contentView.layoutMaker leftParent:0]rightParent:0] topParent:NAVHEIGHT]bottomParent:0] install];
    contentView.backgroundColor = UIColor.whiteColor;
    
    tableView = [AllowMultiGestureTableView new];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    tableView.showsVerticalScrollIndicator = NO;
    [contentView addSubview:tableView];
    [[[[[tableView.layoutMaker leftParent:0] rightParent:0] topParent:0] bottomParent:0] install];
    tableView.tableHeaderView =[self buildHeader];
    [[[tableView.tableHeaderView.layoutUpdate topParent:0]leftParent:0] install];
    
    [self changeDescrpitionTab];
}


/**
 build  header view of table view, set datas
 
 @return header view
 */
-(UIView*)buildHeader{
    UIView *lastView;
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, CGFLOAT_MIN)];
    headerView.backgroundColor = rgbHex(0xf8f8f8);
    
    //配置没有注册课程状态是的界面
    //Configure the page where the course status is not enroll
    UIImageView *imageView = headerView.addImageView;
    [imageView scaleFillAspect];
    imageView.clipsToBounds = YES;
    [[[[[imageView.layoutMaker leftParent:0]rightParent:0]topParent:0]sizeEq:SCREENWIDTH h:SCREENWIDTH * 241 / 375]install];
    
    UIView *infoView = headerView.addView;
    infoView.backgroundColor = argbHex(0x50000000);
    [[[[[infoView.layoutMaker leftOf:imageView]rightOf:imageView]topOf:imageView offset:0]bottomOf:imageView offset:0] install];
    
    
    UILabel *nameLabel = infoView.addLabel;
    nameLabel.font = [Fonts regular:17];
    nameLabel.textColor = UIColor.whiteColor;
    nameLabel.textAlignment = NSTextAlignmentCenter;
    [[[[[nameLabel.layoutMaker topParent:65]centerXParent:0]leftParent:edge*2]rightParent:-edge*2]install];
    
    UILabel *priceLabel = infoView.addLabel;
    priceLabel.font = [Fonts regular:20];
    priceLabel.textColor = UIColor.whiteColor;
    priceLabel.textAlignment = NSTextAlignmentCenter;
    [[[[[priceLabel.layoutMaker below:nameLabel offset:15]centerXParent:0]leftParent:edge*2]rightParent:-edge*2]install];
    
    //level
    UIView *levelView = infoView.addView;
    [[[[levelView.layoutMaker leftParent:edge]below:priceLabel offset:25]widthEq:(SCREENWIDTH-2*edge )/ 4]install];
    
    UIImageView *levelIV = levelView.addImageView;
    levelIV.imageName = @"ic_course_level";
    [[[[levelIV.layoutMaker topParent:0]centerXParent:0]sizeEq:24 h:24]install];
    
    UILabel *levelLabel = levelView.addLabel;
    levelLabel.font = [Fonts regular:13];
    levelLabel.textColor = UIColor.whiteColor;
    [[[levelLabel.layoutMaker below:levelIV offset:10]centerXParent:0]install];
    
    
    //star
    UIView *starView = infoView.addView;
    [[[[starView.layoutMaker toRightOf:levelView offset:0]topOf:levelView offset:0]widthOf:levelView]install];
    
    UIImageView *starIV = starView.addImageView;
    starIV.imageName = @"ic_course_star";
    [[[[starIV.layoutMaker topParent:0]centerXParent:0]sizeEq:24 h:24]install];
    
    UILabel *starLabel = starView.addLabel;
    starLabel.font = [Fonts regular:13];
    starLabel.textColor = UIColor.whiteColor;
    [[[starLabel.layoutMaker below:starIV offset:10]centerXParent:0]install];
    
    //timeRequired
    UIView *timeRequiredView = infoView.addView;
    [[[[timeRequiredView.layoutMaker toRightOf:starView offset:0]topOf:levelView offset:0]widthOf:levelView]install];
    
    UIImageView *timeRequiredIV = timeRequiredView.addImageView;
    timeRequiredIV.imageName = @"ic_course_time";
    [[[[timeRequiredIV.layoutMaker topParent:0]centerXParent:0]sizeEq:24 h:24]install];
    
    UILabel *timeRequiredLabel = timeRequiredView.addLabel;
    timeRequiredLabel.font = [Fonts regular:13];
    timeRequiredLabel.textColor = UIColor.whiteColor;
    [[[timeRequiredLabel.layoutMaker below:timeRequiredIV offset:10]centerXParent:0]install];
    
    
    //accessDate
    UIView *accessDateView = infoView.addView;
    [[[[accessDateView.layoutMaker toRightOf:timeRequiredView offset:0]topOf:levelView offset:0]widthOf:levelView]install];
    
    UIImageView *accessDateIV = accessDateView.addImageView;
    accessDateIV.imageName = @"ic_course_publish_date";
    [[[[accessDateIV.layoutMaker topParent:0]centerXParent:0]sizeEq:24 h:24]install];
    
    UILabel *accessDateLabel = accessDateView.addLabel;
    accessDateLabel.font = [Fonts regular:13];
    accessDateLabel.textColor = UIColor.whiteColor;
    [[[accessDateLabel.layoutMaker below:accessDateIV offset:10]centerXParent:0]install];
    

    UIButton *enrollNowBtn = headerView.addButton;
    enrollNowBtn.tag=99;
    enrollNowBtn.backgroundColor = Colors.textDisabled;
    enrollNowBtn.titleLabel.font = [Fonts regular:14];
    [enrollNowBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [enrollNowBtn setTitle:@"Enroll Now" forState:UIControlStateNormal];
    [[[[[enrollNowBtn.layoutMaker below:imageView offset:edge] leftParent:edge]rightParent:-edge]heightEq:40]install];
    [enrollNowBtn onClick:self action:@selector(enrollNow)];
    
    UIImageView *arrowIV = enrollNowBtn.addImageView;
    arrowIV.imageName = @"ic_arrow_right_white";
    [[[[arrowIV.layoutMaker centerYParent:0]centerXParent:50]sizeEq:13 h:13]install];
    

    
    //tab views
    int singleTabWidth = (SCREENWIDTH-2*edge )/ 2;
    
    UIView *tabView = headerView.addView;
    [[[[[tabView.layoutMaker leftParent:edge]rightParent:-edge]below:enrollNowBtn offset:10 ] heightEq:50] install];
    
    //LESSONS TAB
    lessonsLabel = tabView.addLabel;
    lessonsLabel.font = [Fonts regular:14];
    lessonsLabel.textColor = rgbHex(0x1A191A);
    lessonsLabel.textAlignment = NSTextAlignmentCenter;
    lessonsLabel.text = @"LESSONS";
    [[[[lessonsLabel.layoutMaker leftParent:0]topParent:0]sizeEq:singleTabWidth h:50] install];
    [lessonsLabel onClickView:self action:@selector(changeLessonsTab)];
    
    lessonsTabLine = lessonsLabel.addView;
    lessonsTabLine.backgroundColor = rgbHex(0x1A191A);
    lessonsTabLine.layer.cornerRadius = 3;
    [[[[[lessonsTabLine.layoutMaker leftParent:0]rightParent:0]bottomParent:0]heightEq:5]install];
    
    
    //DESCRIPTION TAB
    descriptionLabel = tabView.addLabel;
    descriptionLabel.font = [Fonts regular:14];
    descriptionLabel.textColor = rgbHex(0x1A191A);
    descriptionLabel.textAlignment = NSTextAlignmentCenter;
    descriptionLabel.text = @"DESCRIPTION";
    [[[[descriptionLabel.layoutMaker toRightOf:lessonsLabel offset:0]topParent:0]sizeEq:singleTabWidth h:50] install];
    [descriptionLabel onClickView:self action:@selector(changeDescrpitionTab)];
    
    descriptonTabLine = descriptionLabel.addView;
    descriptonTabLine.backgroundColor = rgbHex(0x1A191A);
    descriptonTabLine.layer.cornerRadius = 3;
    [[[[[descriptonTabLine.layoutMaker leftParent:0]rightParent:0]bottomParent:0]heightEq:5]install];
    
    
    //DESCRIPTION TAB
    reviewsLabel = tabView.addLabel;
    reviewsLabel.font = [Fonts regular:14];
    reviewsLabel.textColor = rgbHex(0x1A191A);
    reviewsLabel.textAlignment = NSTextAlignmentCenter;
    reviewsLabel.text = @"REVIEWS";
    [[[[reviewsLabel.layoutMaker toRightOf:descriptionLabel offset:0]topParent:0]sizeEq:singleTabWidth h:50] install];
    [reviewsLabel onClickView:self action:@selector(changeReviewsTab)];
    
    reviewsTabLine = reviewsLabel.addView;
    reviewsTabLine.backgroundColor = rgbHex(0x1A191A);
    reviewsTabLine.layer.cornerRadius = 3;
    [[[[[reviewsTabLine.layoutMaker leftParent:0]rightParent:0]bottomParent:0]heightEq:5]install];
    
    
    
    
    //sponsor Image
    CGFloat sponstorimgh=((50.0/375.0)*SCREENWIDTH);
    UIButton *sponsorImageBtn = [headerView addButton];
    [[[[[sponsorImageBtn.layoutMaker leftParent:0] rightParent:0] below:tabView offset:edge] heightEq:sponstorimgh] install];
    [sponsorImageBtn setBackgroundImage:[UIImage imageNamed:@"sponsor_gsk"] forState:UIControlStateNormal];
    
    lastView = sponsorImageBtn;
//    [[[[[lastView.layoutMaker leftParent:0]rightParent:0]below:sponsorImageBtn offset:0]heightEq:edge]install];
    
    
    
    //set datas
//    [imageView loadUrl:@"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=2848697186,66457746&fm=26&gp=0.jpg" placeholderImage:nil];
    
    [imageView loadUrl:[Proto getCourseDetailImageUrlByObjectId:courseModel.image] placeholderImage:nil];
    
    nameLabel.text = courseModel.name;
    
    //TODO 需要完善
    priceLabel.text = courseModel.free ? @"free" : [NSString stringWithFormat:@"$%.2f" ,courseModel.price];
    
    levelLabel.text = courseModel.level;
    starLabel.text = [NSString stringWithFormat:@"%.1f",courseModel.rating];
    timeRequiredLabel.text = courseModel.timeRequired;
    accessDateLabel.text = [NSDate USDateShortFormatWithTimestamp:courseModel.accessDate.time];
    
    
    //sponsor
    NSDictionary *sponsorInfo = @{
      @"260":@{@"name":@"Align" ,@"fullName":@"Align",@"imgName":@"sponsor_align"},
      @"259":@{@"name":@"Nobel" ,@"fullName":@"Nobel Biocare" ,@"imgName":@"sponsor_nobel"},
      @"197":@{@"name":@"GSK",@"fullName":@"GSK",@"imgName":@"sponsor_gsk"}};
    if(courseModel.sponsoredId && sponsorInfo[courseModel.id]){
        [sponsorImageBtn setBackgroundImage:[UIImage imageNamed:sponsorInfo[courseModel.id][@"imgName"]] forState:UIControlStateNormal];
    }else{
        [[[sponsorImageBtn.layoutUpdate heightEq:0]below:tabView offset:0] install];
    }
    
    //not enroll state ,hide lesson tab
    [[lessonsLabel.layoutUpdate widthEq:0]install];
    
    [headerView.layoutUpdate.bottom.equalTo(lastView.mas_bottom) install];
    [headerView layoutIfNeeded];
    
    
    return headerView;
}


/**
 配置表格视图的内容控制器
 Configuring the content controller for the table view
 lessons、description、reviews
 */
-(void)setupTableContentVC{
    self.isCanScroll = YES;
    self.lessonsVC = [CourseDetailLessonsViewController new];
    self.descriptionVC = [CourseDescriptionViewController new];
    self.reviewsVC = [CourseDetailReviewsViewController new];
    
    
    //滚动事件关联
    //Rolling event correlation
    WeakSelf;
    self.lessonsVC.noScrollAction = ^{
        weakSelf.isCanScroll = YES;
        weakSelf.descriptionVC.isCanScroll = NO;
        [weakSelf.descriptionVC contentOffsetToPointZero];
        weakSelf.reviewsVC.isCanScroll = NO;
        [weakSelf.reviewsVC contentOffsetToPointZero];
    };
    self.descriptionVC.noScrollAction = ^{
        weakSelf.isCanScroll = YES;
        weakSelf.lessonsVC.isCanScroll = NO;
        [weakSelf.lessonsVC contentOffsetToPointZero];
        weakSelf.reviewsVC.isCanScroll = NO;
        [weakSelf.reviewsVC contentOffsetToPointZero];
        
    };
    self.reviewsVC.noScrollAction = ^{
        weakSelf.isCanScroll = YES;
        weakSelf.lessonsVC.isCanScroll = NO;
        [weakSelf.lessonsVC contentOffsetToPointZero];
        weakSelf.descriptionVC.isCanScroll = NO;
        [weakSelf.descriptionVC contentOffsetToPointZero];
    };
}

/**
 表格内容布局视图
 Table cell view
 
 @return UIView
 */
-(UIView*)tableContentView{
    if(!_tableContentView){
        int height = [self tableView:tableView heightForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        _tableContentView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH,height)];
        

        self.lessonsVC.view.frame = _tableContentView.frame;
        self.lessonsVC.courseId =  courseModel.id;
        [_tableContentView addSubview:self.lessonsVC.view];
        
        self.descriptionVC.view.frame = _tableContentView.frame;
        [self.descriptionVC showData:courseModel];
        self.descriptionVC.vc = self;
        [_tableContentView addSubview:self.descriptionVC.view];
        
        self.reviewsVC.view.frame = _tableContentView.frame;
        self.reviewsVC.courseId = courseModel.id;
        [_tableContentView addSubview:self.reviewsVC.view];

    }
    return _tableContentView;
}

/**
 切换到课程标签 改变标签颜色 切换到课程界面
 switch to lesson tag 、 change label color 、switch to lessons page
 */
-(void)changeLessonsTab{
    lessonsLabel.textColor = rgbHex(0x1A191A);
    lessonsTabLine.backgroundColor = rgbHex(0x1A191A);
    descriptionLabel.textColor = rgbHex(0x5E6E7A);
    descriptonTabLine.backgroundColor = rgbHex(0xDDDDDD);
    reviewsLabel.textColor = rgbHex(0x5E6E7A);
    reviewsTabLine.backgroundColor = rgbHex(0xDDDDDD);
    
    self.lessonsVC.view.hidden = NO;
    self.descriptionVC.view.hidden = YES;
    self.reviewsVC.view.hidden = YES;
}

/**
 切换到描述标签 改变标签颜色 切换到描述界面
 switch to description tag 、 change label color 、switch to description page
 */
-(void)changeDescrpitionTab{
    lessonsLabel.textColor = rgbHex(0x5E6E7A);
    lessonsTabLine.backgroundColor = rgbHex(0xDDDDDD);
    descriptionLabel.textColor = rgbHex(0x1A191A);
    descriptonTabLine.backgroundColor = rgbHex(0x1A191A);
    reviewsLabel.textColor = rgbHex(0x5E6E7A);
    reviewsTabLine.backgroundColor = rgbHex(0xDDDDDD);
    
    self.lessonsVC.view.hidden = YES;
    self.descriptionVC.view.hidden = NO;
    self.reviewsVC.view.hidden = YES;
}

/**
 切换到评论标签 改变标签颜色 切换到评论界面
 switch to reviews tag 、 change label color 、switch to reviews page
 */
-(void)changeReviewsTab{
    lessonsLabel.textColor = rgbHex(0x5E6E7A);
    lessonsTabLine.backgroundColor = rgbHex(0xDDDDDD);
    descriptionLabel.textColor = rgbHex(0x5E6E7A);
    descriptonTabLine.backgroundColor = rgbHex(0xDDDDDD);
    reviewsLabel.textColor = rgbHex(0x1A191A);
    reviewsTabLine.backgroundColor = rgbHex(0x1A191A);
    
    self.lessonsVC.view.hidden = YES;
    self.descriptionVC.view.hidden = YES;
    self.reviewsVC.view.hidden = NO;
}




-(void)bookmark{
    
}

-(void)share{
    
}

-(void)enrollNow{
    
}

#pragma mark UITableViewDelegate,UITableViewDataSource
/**
 UITableViewDataSource
 numberOfRowsInSection
 
 @param tableView UITableView
 @param section section index
 @return number of rows in section
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

/**
 UITableViewDataSource
 heightForRowAtIndexPath
 
 @param tableView UITableView
 @param indexPath NSIndexPath
 @return height for row
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SCREENHEIGHT - NAVHEIGHT - 50;
}

/**
 UITableViewDataSource
 cellForRowAtIndexPath
 
 @param tableView UITableView
 @param indexPath NSIndexPath
 @return UITableViewCell
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [UITableViewCell new];
    [cell.contentView addSubview:self.tableContentView];
    return cell;
}

/**
 UITableViewDataSource
 didSelectRowAtIndexPath
 
 @param tableView UITableView
 @param indexPath NSIndexPath
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

/**
 tableview scroll event
 
 @param scrollView UIScrollView
 */
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat scrollY = [tableView rectForSection:0].origin.y;
    if (tableView.contentOffset.y >= scrollY) {
        if (self.isCanScroll == YES) {
            self.isCanScroll = NO;
            
            self.lessonsVC.isCanScroll = YES;
            [self.lessonsVC contentOffsetToPointZero];
            self.descriptionVC.isCanScroll = YES;
            [self.descriptionVC contentOffsetToPointZero];
            self.reviewsVC.isCanScroll = YES;
            [self.reviewsVC contentOffsetToPointZero];
        }
        
        tableView.contentOffset = CGPointMake(0, scrollY);
    }else{
        if (self.isCanScroll == NO) {
            tableView.contentOffset = CGPointMake(0, scrollY);
        }
    }
}

@end
