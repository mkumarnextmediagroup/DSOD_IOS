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
/**
 add navigation bar
 */
- (void)addNavBar;
/**
 build views
 table view and apply button
 */
- (void)buildView;
/**
 set apply button status and text
 
 @param enable enable
 */
- (void)setApplyButtonEnable:(BOOL)enable;
/**
 build  header view of table view, set datas
 
 @return header view
 */
- (UIView*_Nullable)buildHeader;
/**
 显示视频、在html代码中找出视频的内容调整格式并且显示
 Display the video, find the content of the video in the html code, adjust the format and display
 
 @param videoHtmlString 视频内容的html代码；Video html code
 */
- (void)showVideo:(NSString*_Nullable)videoHtmlString;
/**
 关闭页面，执行回调事件
 Close the page and execute the callback event
 */
- (void)closePage;
/**
 打开地图界面并在地图中显示职位位置
 Open the map page and display the position in the map
 */
- (void)showLocation;
/**
 attention event
 */
- (void)attention;
/**
 share event
 */
- (void)share;
/**
 UploadResumeDelegate
 Clicked the upload resume button、Open the Select File page
 
 */
- (void)uploadResume;
/**
 申请按钮点击事件
 1、已经申请过了职位、关闭界面
 2、没有申请过职位且不存在简历打开上传简历界面
 3、没有申请过职位且存在简历，直接请求申请职位
 
 Clicked the apply button
 1, has applied for a position, close the interface
 2, did not apply for a position and does not exist resume open upload resume interface
 3. If you have not applied for a position and have a resume, you can directly apply for a position.
 */
- (void)applyNow;
/**
 Request server to apply for this job
 
 @param completion callback function
 */
- (void)applyForJob:(void(^)(BOOL success))completion;
/**
 UIDocumentPickerDelegate
 Select the file successfully and execute the upload resume
 
 @param controller UIDocumentPickerViewController
 @param url The url of the selected file
 */
- (void)documentPicker:(UIDocumentPickerViewController *_Nullable)controller didPickDocumentAtURL:(NSURL *_Nullable)url;
/**
 Resume upload progress
 
 @param current current progress
 @param total total progress
 @param percent current percent
 */
- (void)onHttpProgress:(int)current total:(int)total percent:(int)percent;
/**
 Url decode
 
 @param input Encoded url
 @return decoded url
 */
- (NSString *_Nullable)decoderUrlEncodeStr: (NSString *_Nullable) input;
/**
 从路径中取出文件名称
 get the file name from the path
 
 @param filePath file path
 @return filt name
 */
- (NSString*_Nullable)fileName:(NSString*_Nullable)filePath;
- (void)setupTableContentVC;
/**
 表格内容布局视图
 Table cell view
 
 @return UIView
 */
- (UIView*_Nullable)tableContentView;
/**
 页签切换时候，控制视图显示和隐藏
 Control view display and hide when tabs are switched
 
 @param index Currently selected index
 */
- (void)didDentistSelectItemAtIndex:(NSInteger)index;
- (CGFloat)tableView:(UITableView *_Nullable)tableView heightForHeaderInSection:(NSInteger)section;
- (UIView *_Nullable)tableView:(UITableView *_Nullable)tableView viewForHeaderInSection:(NSInteger)section;
- (NSInteger)tableView:(UITableView *_Nullable)tableView numberOfRowsInSection:(NSInteger)section;
- (CGFloat)tableView:(UITableView *_Nullable)tableView heightForRowAtIndexPath:(NSIndexPath *_Nullable)indexPath;
- (UITableViewCell *_Nullable)tableView:(UITableView *_Nullable)tableView cellForRowAtIndexPath:(NSIndexPath *_Nullable)indexPath;
- (void)tableView:(UITableView *_Nullable)tableView didSelectRowAtIndexPath:(NSIndexPath *_Nullable)indexPath;
/**
 tableview scroll event
 
 @param scrollView UIScrollView
 */
- (void)scrollViewDidScroll:(UIScrollView *_Nullable)scrollView;

@end
