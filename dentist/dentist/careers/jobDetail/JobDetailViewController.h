//
//  JobDetailViewController.h
//  dentist
//
//  Created by Shirley on 2018/12/9.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseController.h"

typedef void (^CareerJobDetailCloseCallback) (NSString *_Nullable jobid,NSString *_Nullable unFollowjobid,NSString *_Nullable Followjobid);
@interface JobDetailViewController : BaseController
@property (nonatomic,strong) NSString *jobId;

/**
 打开职位详情页面
 open the job details page

 @param vc UIViewController
 @param jobId job id
 */
+(void)presentBy:(UIViewController* _Nullable)vc jobId:(NSString*_Nullable)jobId;
/**
 打开职位详情页面，包含界面关闭回调事件
 Open the job details page, including the interface close callback event

 @param vc UIViewController
 @param jobId job id
 @param closeBack close callback event
 */
+(void)presentBy:(UIViewController* _Nullable)vc jobId:(NSString*_Nonnull)jobId closeBack:(CareerJobDetailCloseCallback _Nullable)closeBack;
- (void)addNavBar;
- (void)buildView;
- (void)setApplyButtonEnable:(BOOL)enable;
- (UIView*_Nullable)buildHeader;
- (void)showVideo:(NSString*_Nullable)videoHtmlString;
- (void)closePage;
- (void)showLocation;
- (void)attention;
- (void)share;
- (void)uploadResume;
- (void)applyNow;
- (void)applyForJob:(void(^)(BOOL success))completion;
- (void)documentPicker:(UIDocumentPickerViewController *_Nullable)controller didPickDocumentAtURL:(NSURL *_Nullable)url;
- (void)onHttpProgress:(int)current total:(int)total percent:(int)percent;
- (NSString *_Nullable)decoderUrlEncodeStr: (NSString *_Nullable) input;
- (NSString*_Nullable)fileName:(NSString*_Nullable)filePath;
- (void)setupTableContentVC;
- (UIView*_Nullable)tableContentView;
- (void)didDentistSelectItemAtIndex:(NSInteger)index;
- (CGFloat)tableView:(UITableView *_Nullable)tableView heightForHeaderInSection:(NSInteger)section;
- (UIView *_Nullable)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
- (NSInteger)tableView:(UITableView *_Nullable)tableView numberOfRowsInSection:(NSInteger)section;
- (CGFloat)tableView:(UITableView *_Nullable)tableView heightForRowAtIndexPath:(NSIndexPath *_Nullable)indexPath;
- (UITableViewCell *_Nullable)tableView:(UITableView *_Nullable)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *_Nullable)tableView didSelectRowAtIndexPath:(NSIndexPath *_Nullable)indexPath;
- (void)scrollViewDidScroll:(UIScrollView *_Nullable)scrollView;

@end
