//
//  JobDetailViewController.h
//  dentist
//
//  Created by Shirley on 2018/12/9.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseController.h"

typedef void (^CareerJobDetailCloseCallback) (NSString *_Nullable jobid,NSString *_Nullable unFollowjobid);
@interface JobDetailViewController : BaseController

+(void)presentBy:(UIViewController* _Nullable)vc jobId:(NSString*_Nullable)jobId;
+(void)presentBy:(UIViewController* _Nullable)vc jobId:(NSString*_Nonnull)jobId closeBack:(CareerJobDetailCloseCallback _Nullable)closeBack;
+(void)presentBy:(UIViewController* _Nullable)vc jobId:(NSString*_Nonnull)jobId isShowApply:(BOOL)isShowApply closeBack:(CareerJobDetailCloseCallback _Nullable)closeBack;
- (void)viewDidLoad;
- (void)viewWillAppear:(BOOL)animated;
- (void)viewWillDisappear:(BOOL)animated;
- (void)addNavBar;
- (void)buildView;
- (void)setApplyButtonEnable:(BOOL)enable;
- (UIView*)buildHeader;
- (void)showVideo:(NSString*)videoHtmlString;
- (void)closePage;
- (void)showLocation;
- (void)attention;
- (void)share;
- (void)clickOkBtn;
- (void)uploadResume;
- (void)applyNow;
- (void)applyForJob;
- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentAtURL:(NSURL *)url;
- (void)onHttpProgress:(int)current total:(int)total percent:(int)percent;
- (NSString *)decoderUrlEncodeStr: (NSString *) input;
- (NSString*)fileName:(NSString*)filePath;
- (void)setupTableContentVC;
- (UIView*)tableContentView;
- (void)didDentistSelectItemAtIndex:(NSInteger)index;
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;

@end
