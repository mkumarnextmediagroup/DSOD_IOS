//
//  CourseDescriptionViewController.m
//  dentist
//
//  Created by Shirley on 2019/2/15.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "CourseDescriptionViewController.h"
#import "Common.h"
#import "Proto.h"
#import "EducationSpeakerDetailViewController.h"

@interface CourseDescriptionViewController ()<UIScrollViewDelegate>
@property (nonatomic,strong) CourseModel *courseModel;

@end

@implementation CourseDescriptionViewController{
    int edge;
    
    UIScrollView *scrollView;
    UIView *contentView;
    
    UILabel *descriptionLabel;
    
    UIImageView *headImageView;
    UILabel *locationLabel;
    UILabel *specialtyLabel;
    UILabel *nameLabel;
    
    UILabel *lessonsNumberLabel;
    UILabel *quizzesNumberLabel;
    UILabel *certificateLabel;
    UIImageView *certificateIV
;

    
    AuthorModel *authorModel;
}

/**
 build views
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self buildViews];
}


/**
 buid views
 description、author info、course contains
 */
-(void)buildViews{
    edge = 18;
    self.view.backgroundColor = rgbHex(0xf8f8f8);
    
    scrollView = [UIScrollView new];
    [self.view addSubview:scrollView];
    [scrollView layoutFill];
    scrollView.alwaysBounceVertical = YES;
    scrollView.delegate = self;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    [[scrollView.layoutUpdate topParent:0]install];

    contentView = scrollView.addView;
    [[[[[[contentView.layoutMaker topParent:0]leftParent:0] rightParent:0] widthEq:SCREENWIDTH] bottomParent:0] install];
    
    //course description
    UIView *courseDescriptionView = contentView.addView;
    courseDescriptionView.backgroundColor = UIColor.whiteColor;
    [[[[courseDescriptionView.layoutMaker leftParent:0]topParent:10]rightParent:0]install];
    
    UILabel *courseDescriptionLabel = courseDescriptionView.addLabel;
    courseDescriptionLabel.font = [Fonts regular:13];
    courseDescriptionLabel.textColor = rgbHex(0x9B9B9B);
    courseDescriptionLabel.text = @"Course description";
    [[[[courseDescriptionLabel.layoutMaker leftParent:edge] topParent:edge ] rightParent:-edge] install];
    
    
    descriptionLabel = courseDescriptionView.addLabel;
    descriptionLabel.font = [Fonts regular:16];
    descriptionLabel.textColor = rgbHex(0x1A191A);
    [[[[descriptionLabel.layoutMaker leftParent:edge] below:courseDescriptionLabel offset:edge ] rightParent:-edge] install];
    
    
    UILabel *lineLabel = courseDescriptionView.lineLabel;
    [[[[[lineLabel.layoutMaker leftParent:0] below:descriptionLabel offset:edge ] rightParent:0]heightEq:1] install];
    
    //author info
    UIView *authorView = courseDescriptionView.addView;
    [[[[authorView.layoutMaker below:lineLabel offset:edge]leftParent:0]rightParent:0]install];
    [authorView onClickView:self action:@selector(openSpeakDetailPage)];
    
    headImageView = authorView.addImageView;
    headImageView.layer.masksToBounds = YES;
    headImageView.layer.cornerRadius = 36;
    [headImageView scaleFillAspect];
    headImageView.imageName = @"user_img";
    [[[[[headImageView.layoutMaker topParent:0]leftParent:edge]bottomParent:0] sizeEq:72 h:72] install];
    
    
    nameLabel = authorView.addLabel;
    nameLabel.font = [Fonts regular:20];
    nameLabel.textColor = rgbHex(0x1A191A);
    [[[[nameLabel.layoutMaker toRightOf:headImageView offset:edge] topOf:headImageView offset: 3] rightParent:0] install];
    
    
    specialtyLabel = authorView.addLabel;
    specialtyLabel.font = [Fonts regular:14];
    specialtyLabel.textColor = rgbHex(0x4A4A4A);
    [[[[specialtyLabel.layoutMaker leftOf:nameLabel] below:nameLabel offset:5 ] rightOf:nameLabel] install];
    
    locationLabel = authorView.addLabel;
    locationLabel.font = [Fonts regular:14];
    locationLabel.textColor = rgbHex(0x4A4A4A);
    [[[[locationLabel.layoutMaker leftOf:nameLabel] below:specialtyLabel offset:5 ] rightOf:nameLabel] install];
    
    UIImageView *arrow = authorView.addImageView;
    arrow.imageName = @"arrow_small";
    [[[[arrow.layoutMaker rightParent:-edge]centerYParent:0]sizeEq:20 h:20]install];
    
    UILabel *lineLabel2 = courseDescriptionView.lineLabel;
    [[[[[[lineLabel2.layoutMaker leftParent:0] below:authorView offset:edge ] rightParent:0]heightEq:1] bottomParent:0] install];
    
    
    
    //This course contains:
    UIView *courseContainsView = contentView.addView;
    courseContainsView.backgroundColor = UIColor.whiteColor;
    [[[[[courseContainsView.layoutMaker leftParent:0]below:courseDescriptionView offset:10]rightParent:0]bottomParent:-edge] install];
    
    UILabel *courseContainsLabel = courseContainsView.addLabel;
    courseContainsLabel.font = [Fonts regular:13];
    courseContainsLabel.textColor = rgbHex(0x9B9B9B);
    courseContainsLabel.text = @"This course contains:";
    [[[[courseContainsLabel.layoutMaker leftParent:edge] topParent:edge ] rightParent:-edge] install];
    
    //lessons number
    lessonsNumberLabel = courseContainsView.addLabel;
    lessonsNumberLabel.font = [Fonts regular:17];
    lessonsNumberLabel.textColor = rgbHex(0x1A191A);
    lessonsNumberLabel.text = @"";
    [[[[lessonsNumberLabel.layoutMaker leftParent:60] below:courseContainsLabel offset:edge *2 ] rightParent:-edge] install];
    
    UIImageView *lessonsIV = courseContainsView.addImageView;
    lessonsIV.imageName = @"ic_course_lessons";
    [[[[lessonsIV.layoutMaker leftParent:edge]centerYOf:lessonsNumberLabel offset:0]sizeEq:30 h:30]install];
    
    //quizzes number
    quizzesNumberLabel = courseContainsView.addLabel;
    quizzesNumberLabel.font = [Fonts regular:17];
    quizzesNumberLabel.textColor = rgbHex(0x1A191A);
    quizzesNumberLabel.text = @"";
    [[[[quizzesNumberLabel.layoutMaker leftParent:60] below:lessonsNumberLabel offset:edge *2] rightParent:-edge] install];
    
    UIImageView *quizzesIV = courseContainsView.addImageView;
    quizzesIV.imageName = @"ic_course_quizzes";
    [[[[quizzesIV.layoutMaker leftParent:edge]centerYOf:quizzesNumberLabel offset:0]sizeEq:30 h:30]install];
    
    //Certificate
    certificateLabel = courseContainsView.addLabel;
    certificateLabel.font = [Fonts regular:17];
    certificateLabel.textColor = rgbHex(0x1A191A);
    certificateLabel.text = @"Certificate" ;
    [[[[[certificateLabel.layoutMaker leftParent:60] below:quizzesNumberLabel offset:edge *2] rightParent:-edge] bottomParent:-edge] install];

    certificateIV = courseContainsView.addImageView;
    certificateIV.imageName = @"ic_course_certificate";
    [[[[certificateIV.layoutMaker leftParent:edge]centerYOf:certificateLabel offset:0]sizeEq:30 h:30]install];
    
    
    [contentView.layoutUpdate.bottom.greaterThanOrEqualTo(courseContainsView) install];
    
}

/**
 get author info form server
 */
-(void)getAuthorById:(NSString*)authorId{
    
    [Proto findCourseAuthor:authorId completed:^(BOOL success, NSString *msg, AuthorModel *authorModel) {
        if(success){
            self->authorModel = authorModel;
            [self->headImageView loadUrl:[Proto getCourseAuthorAvatarUrlByObjectId:authorModel.objectId] placeholderImage:@"user_img"];
            self->nameLabel.text = strBuild(authorModel.firstName, authorModel.lastName);
            self->specialtyLabel.text = authorModel.specialty;
            self->locationLabel.text = authorModel.location;
        }
    }];
}


/**
 open speaker detail page
 */
-(void)openSpeakDetailPage{
    if(authorModel){
        [EducationSpeakerDetailViewController openBy:self.vc authorId:authorModel.id];
    }
}

/**
 show course info
 description、author info、lesson
 
 @param courseModel CourseModel instance
 */
-(void)showData:(CourseModel*)courseModel{
    _courseModel = courseModel;
    
    descriptionLabel.text = courseModel.courseDescription;
    
    lessonsNumberLabel.text = [NSString stringWithFormat:@"%d Lessons",(int)courseModel.lessons.count];
    quizzesNumberLabel.text = [NSString stringWithFormat:@"%d Quizzes",(int)courseModel.tests.count];
    
    if(!courseModel.hasCertificate){
        //not has certificate,hide certificate item
        certificateLabel.hidden = YES;
        [[[certificateLabel.layoutUpdate heightEq:0] below:quizzesNumberLabel offset:0] install];

        certificateIV.hidden = YES;
        [[certificateIV.layoutUpdate heightEq:0]install];
    }

    if(courseModel.authorIds && courseModel.authorIds.count > 0){
        [self getAuthorById:courseModel.authorIds[0]];
    }
    
}


#pragma mark - 滑动方法
/**
 UIScrollViewDelegate
 scroll view did scroll
 
 @param scrollView UIScrollView
 */
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (!self.isCanScroll) {
        scrollView.contentOffset = CGPointZero;
    }
    
    /// 当偏移量小于0时，不能滑动，并且使主要视图的UITableView滑动
    if (scrollView.contentOffset.y < 0 ) {
        self.isCanScroll = NO;
        scrollView.contentOffset = CGPointZero;
        if (self.noScrollAction) {
            self.noScrollAction();
        }
    }
}


/**
 滚动到初始位置
 Scroll to the initial position
 */
-(void)contentOffsetToPointZero{
    scrollView.contentOffset = CGPointZero;
}

@end
