//
//  CareerMeViewController.h
//  dentist
//
//  Created by feng zhenrong on 2018/12/18.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CareerMeViewController : UIViewController

-(void)reloadMeData:(UIImage *)placeholderImage;
-(void)reloadMeData;
- (void)onBack;
-(void)back;
- (void)editPortrait:(id)sender;
- (void)callActionSheetFunc;
- (UIView *)makeHeaderView;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
-(void)previewResume;
- (void)clickTheBtnWithSourceType:(UIImagePickerControllerSourceType)sourceType;
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info;
- (void)afterSelectDo:(UIImage *)image;
- (NSString *)getDocumentImage;
- (void)saveImageDocuments:(UIImage *)image;
- (void)uploadHeaderImage:(NSString *)url;
- (void)saveUserHeader;

@end

NS_ASSUME_NONNULL_END
