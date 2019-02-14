//
//  EducationSpeakerDetailViewController.m
//  dentist
//
//  Created by Shirley on 2019/2/13.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "EducationSpeakerDetailViewController.h"
#import "Common.h"
#import "Proto.h"
#import "Author.h"

@interface EducationSpeakerDetailViewController ()

@property (nonatomic,strong) NSString *authorId;

@end

@implementation EducationSpeakerDetailViewController{
    int edge;
    
    UIScrollView *scrollView;
    UIView *contentView;
    
    UIImageView *headImageView;
    UILabel *bioLabel;
    UILabel *locationLabel;
    UILabel *specialtyLabel;
    UILabel *nameLabel;
}


/**
 open speaker detail page
 
 @param vc UIViewController
 @param authorId author id
 */
+(void)openBy:(UIViewController*)vc authorId:(NSString*)authorId{
    
    EducationSpeakerDetailViewController *newVc = [EducationSpeakerDetailViewController new];
    newVc.authorId = authorId;
    [vc pushPage:newVc];
}

/**
 view did load
 add navigation bar
 build views
 get author info form server
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    edge = 18;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self addNavBar];
    
    [self buildViews];
    
    [self loadData];
}

/**
 add navigation bar
 */
-(void)addNavBar{
    UINavigationItem *item = [self navigationItem];
    item.title = @"SPEAKER";
    item.leftBarButtonItem = [self navBarBack:self action:@selector(dismiss)];
}

/**
 build views
 */
-(void)buildViews{
    
    scrollView = [UIScrollView new];
    [self.view addSubview:scrollView];
    [scrollView layoutFill];
    [[scrollView.layoutUpdate topParent:NAVHEIGHT]install];
    
    
    contentView = scrollView.addView;
    [[[[[[contentView.layoutMaker topParent:0]leftParent:edge] rightParent:-edge] widthEq:SCREENWIDTH - 2* edge] bottomParent:0] install];
    
    headImageView = contentView.addImageView;
    headImageView.layer.masksToBounds = YES;
    headImageView.layer.cornerRadius = 36;
    [headImageView scaleFillAspect];
    [[[[headImageView.layoutMaker topParent:edge]leftParent:0]sizeEq:72 h:72]install];
    
    
    nameLabel = contentView.addLabel;
    nameLabel.font = [Fonts regular:20];
    nameLabel.textColor = rgbHex(0x1A191A);
    [[[[nameLabel.layoutMaker toRightOf:headImageView offset:edge] topParent:edge + 3] rightParent:0] install];
    
    
    specialtyLabel = contentView.addLabel;
    specialtyLabel.font = [Fonts regular:14];
    specialtyLabel.textColor = rgbHex(0x4A4A4A);
    [[[[specialtyLabel.layoutMaker leftOf:nameLabel] below:nameLabel offset:5 ] rightOf:nameLabel] install];
    
    locationLabel = contentView.addLabel;
    locationLabel.font = [Fonts regular:14];
    locationLabel.textColor = rgbHex(0x4A4A4A);
    [[[[locationLabel.layoutMaker leftOf:nameLabel] below:specialtyLabel offset:5 ] rightOf:nameLabel] install];
    
    bioLabel = contentView.addLabel;
    bioLabel.font = [Fonts regular:14];
    bioLabel.textColor = rgbHex(0x1A191A);
    [[[[bioLabel.layoutMaker leftParent:0] below:headImageView offset:edge ] rightParent:0] install];
    
    
    [contentView.layoutUpdate.bottom.greaterThanOrEqualTo(bioLabel) install];
}


/**
  get author info form server
 */
-(void)loadData{
    
    [self showLoading];
    [Proto findCourseAuthor:self.authorId completed:^(BOOL success, NSString *msg, AuthorModel *AuthorModel) {
        [self hideLoading];
        if(success){
            [self showData:AuthorModel];
        }else{
            [self alertMsg:[NSString isBlankString:msg]?@"Failed to get data":msg onOK:^{
                [self dismiss];
            }];
        }
    }];
}
     
/**
 show author info

 @param authorModel AuthorModel
 */
-(void)showData:(AuthorModel *)authorModel{
    [headImageView loadUrl:[Proto getCourseAuthorAvatarUrlByObjectId:authorModel.objectId] placeholderImage:@"user_img"];
    nameLabel.text = strBuild(authorModel.firstName, authorModel.lastName);
    specialtyLabel.text = @"";
    locationLabel.text = @"";
    bioLabel.text = authorModel.authorDetails;


//    nameLabel.text = @"Dr. Barry Glaser";
//    specialtyLabel.text = @"Orthodontist";
//    locationLabel.text = @"New Jersey, NJ";
//    bioLabel.text = @"Dr. Barry Glaser, an Invisalign® Elite Preferred Provider, has been providing quality dental care since 1988. He was awarded his dental degree from the University of Pennsylvania, School of Dental Medicine in 1988 and earned his Specialty in Orthodontics from Boston University School of Graduate Dentistry in 1992. Dr. Glaser was an early adopter of Invisalign Teen® and the iTero® digital scanner. He participated in the pilot for SmartTrack®, and has a featured case in Align’s ClinCheck® II Toolkit. He has spoken at several Invisalign Summits and has been a speaker at Invisalign courses and events since 2008.\nDr. Barry Glaser, an Invisalign® Elite Preferred Provider, has been providing quality dental care since 1988. He was awarded his dental degree from the University of Pennsylvania, School of Dental Medicine in 1988 and earned his Specialty in Orthodontics from Boston University School of Graduate Dentistry in 1992. Dr. Glaser was an early adopter of Invisalign Teen® and the iTero® digital scanner. He participated in the pilot for SmartTrack®, and has a featured case in Align’s ClinCheck® II Toolkit. He has spoken at several Invisalign Summits and has been a speaker at Invisalign courses and events since 2008.\nDr. Barry Glaser, an Invisalign® Elite Preferred Provider, has been providing quality dental care since 1988. He was awarded his dental degree from the University of Pennsylvania, School of Dental Medicine in 1988 and earned his Specialty in Orthodontics from Boston University School of Graduate Dentistry in 1992. Dr. Glaser was an early adopter of Invisalign Teen® and the iTero® digital scanner. He participated in the pilot for SmartTrack®, and has a featured case in Align’s ClinCheck® II Toolkit. He has spoken at several Invisalign Summits and has been a speaker at Invisalign courses and events since 2008.\nDr. Barry Glaser, an Invisalign® Elite Preferred Provider, has been providing quality dental care since 1988. He was awarded his dental degree from the University of Pennsylvania, School of Dental Medicine in 1988 and earned his Specialty in Orthodontics from Boston University School of Graduate Dentistry in 1992. Dr. Glaser was an early adopter of Invisalign Teen® and the iTero® digital scanner. He participated in the pilot for SmartTrack®, and has a featured case in Align’s ClinCheck® II Toolkit. He has spoken at several Invisalign Summits and has been a speaker at Invisalign courses and events since 2008.\n";
}

@end
