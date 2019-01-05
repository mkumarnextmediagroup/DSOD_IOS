//
//  CareerMeViewController.m
//  dentist
//
//  Created by feng zhenrong on 2018/12/18.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "CareerMeViewController.h"
#import "Proto.h"
#import "CareerMeTableViewCell.h"
#import "UIViewController+myextend.h"
#import "UserInfo.h"
#import "UIViewController+myextend.h"
#import <AssetsLibrary/ALAsset.h>
#import "ProfileViewController.h"
#import "PreviewResumeViewController.h"
#import "AppDelegate.h"
#import "SlideController.h"
#import "NSDate+customed.h"
#import "CareerAlertsAddViewController.h"

@interface CareerMeViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UITableView *myTable;
    UIImageView *headerImg;
    UIButton *editBtn;
    UserInfo *_userInfo;
    UIImage *_selectImage;
    NSString *username;
    NSString *filename;
    NSURL *fileURL;
    NSString *uploadPortraitResult;
}
@end

@implementation CareerMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = rgb255(246, 245, 245);
    UINavigationItem *item = self.navigationItem;
    item.title = @"ME";
    item.leftBarButtonItem = [self navBarImage:@"back_arrow" target:self action:@selector(onBack)];
    // Do any additional setup after loading the view.
    
    CGFloat _topBarH = 0;
    CGFloat _bottomBarH = 0;
    if (self.navigationController != nil) {
        _topBarH = NAVHEIGHT;
    }
    if (self.tabBarController != nil) {
        _bottomBarH = TABLEBAR_HEIGHT;
    }
    
    myTable = [UITableView new];
    myTable.backgroundColor=[UIColor clearColor];
    [self.view addSubview:myTable];
    myTable.separatorStyle=UITableViewCellSeparatorStyleNone;
    myTable.dataSource = self;
    myTable.delegate = self;
    myTable.tableHeaderView=[self makeHeaderView];
    [[[[myTable.layoutMaker widthEq:SCREENWIDTH] topParent:_topBarH] bottomParent:-_bottomBarH] install];
//    [myTable registerClass:[CareerMeTableViewCell class] forCellReuseIdentifier:NSStringFromClass([CareerMeTableViewCell class])];
    [self reloadMeData];
}

-(void)reloadMeData:(UIImage *)placeholderImage{
    _userInfo = [Proto lastUserInfo];
    if(![NSString isBlankString:_userInfo.userId]){
        UIImage *placeimage=[UIImage imageNamed:@"user_img"];
        if (placeholderImage) {
            placeimage=placeholderImage;
        }
        [headerImg loadUrl:_userInfo.portraitUrlFull placeholderImageNormal:placeimage];
        
        [myTable reloadData];
    }else{
        [self showIndicator];
        backTask(^() {
            [Proto getProfileInfo];
            foreTask(^() {
                [self hideIndicator];
                self->_userInfo = [Proto lastUserInfo];
                self->headerImg.imageName = @"user_img";
                [self->headerImg loadUrl:self->_userInfo.portraitUrlFull placeholderImage:@"user_img"];
                [self->myTable reloadData];
            });
        });
    }
    
}

-(void)reloadMeData{
    [self reloadMeData:nil];
}

- (void)onBack
{
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UITabBarController *tabvc=(UITabBarController *)appdelegate.careersPage;
    [tabvc setSelectedIndex:0];
    [self back];
    
}

-(void)back{
    NSArray *viewcontrollers=self.navigationController.viewControllers;
    if (viewcontrollers.count>1) {
        if ([viewcontrollers objectAtIndex:viewcontrollers.count-1]==self) {
            //push方式
            [self.navigationController popViewControllerAnimated:NO];
        }
    }
    else{
        //present方式
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}

- (void)editPortrait:(id)sender {
    
    Confirm *cf = [Confirm new];
    cf.title = localStr(@"userCamera");
    cf.msg = localStr(@"usePhoto");
    cf.cancelText = localStr(@"notallow");
    [cf show:self onOK:^() {
        Log(@"click OK ");
        [self callActionSheetFunc];
    }];
    
    
}

- (void)callActionSheetFunc {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        [self Den_showActionSheetWithTitle:nil message:nil appearanceProcess:^(DenAlertController *_Nonnull alertMaker) {
            alertMaker.
            addActionCancelTitle(@"cancel").
            addActionDefaultTitle(@"Camera").
            addActionDefaultTitle(@"Gallery");
        }                     actionsBlock:^(NSInteger buttonIndex, UIAlertAction *_Nonnull action, DenAlertController *_Nonnull alertSelf) {
            if ([action.title isEqualToString:@"cancel"]) {
                NSLog(@"cancel");
            } else if ([action.title isEqualToString:@"Camera"]) {
                NSLog(@"Camera");
                [self clickTheBtnWithSourceType:UIImagePickerControllerSourceTypeCamera];
            } else if ([action.title isEqualToString:@"Gallery"]) {
                NSLog(@"Gallery");
                [self clickTheBtnWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
            }
        }];
        
    } else {
        [self Den_showActionSheetWithTitle:nil message:nil appearanceProcess:^(DenAlertController *_Nonnull alertMaker) {
            alertMaker.
            addActionCancelTitle(@"cancel").
            addActionDefaultTitle(@"Gallery");
        }                     actionsBlock:^(NSInteger buttonIndex, UIAlertAction *_Nonnull action, DenAlertController *_Nonnull alertSelf) {
            if ([action.title isEqualToString:@"cancel"]) {
                NSLog(@"cancel");
            } else if ([action.title isEqualToString:@"Gallery"]) {
                NSLog(@"Gallery");
                [self clickTheBtnWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
            }
        }];
    }
}

- (UIView *)makeHeaderView {
    UIView *panel = [UIView new];
    panel.frame = makeRect(0, 0, SCREENWIDTH, 200);
    panel.backgroundColor=[UIColor clearColor];
    headerImg = [UIImageView new];
    
    headerImg.imageName = @"default_avatar";
    [panel addSubview:headerImg];
    [[[[headerImg.layoutMaker sizeEq:100 h:100] topParent:44] centerXParent:0] install];
    
    editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [editBtn setImage:[UIImage imageNamed:@"edit_photo"] forState:UIControlStateNormal];
    [editBtn onClick:self action:@selector(editPortrait:)];
    [panel addSubview:editBtn];
    [[[[editBtn.layoutMaker sizeEq:38 h:38] toRightOf:headerImg offset:-19] below:headerImg offset:-19] install];
    return panel;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = @"careermetablecell";
    CareerMeTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.backgroundColor=[UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (!cell) {
        cell = [[CareerMeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
//    CareerMeTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CareerMeTableViewCell class]) forIndexPath:indexPath];
    if (indexPath.row==0) {
        cell.headerView.image=[UIImage imageNamed:@"icons8-user"];
        cell.desLabel.text=@"Profile";
    }else if (indexPath.row==1) {
        cell.headerView.image=[UIImage imageNamed:@"icons8-resume"];
        cell.titleLabel.text=@"Resume";
        cell.lineLabel.hidden=YES;
    }
    if (_userInfo) {
        if (indexPath.row==0) {
            cell.titleLabel.text=[NSString stringWithFormat:@"%@",_userInfo.fullName];
        }else if (indexPath.row==1) {
            NSString *createtime;
            if (![NSString isBlankString:_userInfo.resume_url]) {
                NSArray *resumeurlarr=[_userInfo.resume_url componentsSeparatedByString:@"&"];
                for (NSString *param in resumeurlarr) {
                    if ([param rangeOfString:@"createTime"].location != NSNotFound){
                        NSArray *paramarr=[param componentsSeparatedByString:@"="];
                        if (paramarr.count>1) {
                            createtime=paramarr[1];
                        }
                    }
                }
            }
            if (![NSString isBlankString:createtime]) {
                cell.desLabel.text=[NSString stringWithFormat:@"%@",[NSDate USDateLongFormatWithStringTimestamp:createtime]];
            }
            else if (![NSString isBlankString:_userInfo.resume_name]) {
                cell.desLabel.text=[NSString stringWithFormat:@"%@",_userInfo.resume_name];
            }else{
                cell.desLabel.text=@"No uploaded resume";
            }
            
        }
    }
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.row==0){
//        ProfileViewController *profilevc=[ProfileViewController new];
//        UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:profilevc];
//        navVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//        [self presentViewController:navVC animated:NO completion:NULL];
        
        ProfileViewController *profilevc=[ProfileViewController new];
        profilevc.isSecond=YES;
        [self.navigationController pushViewController:profilevc animated:YES];
//        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"You will now be taken to 'My Profile' section.You can come back to the Career section by the menu." preferredStyle:UIAlertControllerStyleAlert];
//
//        [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//
//            NSLog(@"点击取消");
//        }]];
//        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//            NSLog(@"点击ok");
//            AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//            UIViewController *leftvc=appdelegate.mainLeftPage;
//            if ([leftvc isKindOfClass:[SlideController class]]) {
//                SlideController *slidevc=(SlideController *)leftvc;
//                [slidevc slideItem:5];
//                [self back];
//            }
//        }]];
//        [self presentViewController:alertController animated:YES completion:nil];
    }else if(indexPath.row==1){
        if (![NSString isBlankString:_userInfo.resume_name]) {
            [self showLoading];
            
            backTask(^{
                NSURL *fileurl = [Proto downloadResume:self->_userInfo.resume_url fileName:self->_userInfo.resume_name];
                foreTask(^{
                    [self hideLoading];
                    if(fileurl){
                        self->fileURL = fileurl;
                        [self previewResume];
                    }else{
                        NSLog(@"download resume file");
                    }
                });
            });
        }else{
            ProfileViewController *profilevc=[ProfileViewController new];
            profilevc.isSecond=YES;
            [self.navigationController pushViewController:profilevc animated:YES];
        }
    }
}

-(void)previewResume{
    PreviewResumeViewController *vc = [PreviewResumeViewController new];
    vc.fileURL = self->fileURL;
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc] ;
    
    [self presentViewController:nvc animated:YES completion:nil ];
}

- (void)clickTheBtnWithSourceType:(UIImagePickerControllerSourceType)sourceType {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    imagePickerController.sourceType = sourceType;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = nil;
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        picker.cameraDevice = UIImagePickerControllerCameraDeviceFront;
        image = info[@"UIImagePickerControllerEditedImage"];
        
        [self afterSelectDo:image];
        
    } else {
        image = info[UIImagePickerControllerEditedImage];
        
        [self afterSelectDo:image];
    }
    [self dismissViewControllerAnimated:NO completion:nil];
    
}

- (void)afterSelectDo:(UIImage *)image
{
    _selectImage=image;
    [self saveImageDocuments:_selectImage];
    
    NSString *localFile = [self getDocumentImage];
    if (localFile != nil) {
        Log(@"Image File: ", localFile);
        [self uploadHeaderImage:localFile];
    }
}

- (NSString *)getDocumentImage {
    // 读取沙盒路径图片
    NSString *aPath3 = [NSString stringWithFormat:@"%@/Documents/%@.png", NSHomeDirectory(), @"test"];
    return aPath3;
}

- (void)saveImageDocuments:(UIImage *)image {
    
    CGFloat f = 300.0f / image.size.width;
    //拿到图片
    UIImage *imagesave = [image scaledBy:f];
    NSString *path_sandox = NSHomeDirectory();
    //设置一个图片的存储路径
    NSString *imagePath = [path_sandox stringByAppendingString:@"/Documents/test.png"];
    
    [UIImagePNGRepresentation(imagesave) writeToFile:imagePath atomically:YES];
}

- (void)uploadHeaderImage:(NSString *)url {
    [self showIndicator];
    backTask(^() {
       self->uploadPortraitResult= [Proto uploadHeaderImage:url];
        foreTask(^() {
            [self hideIndicator];
            if (![NSString isBlankString:self->uploadPortraitResult]) {
                self->headerImg.image=self->_selectImage;
                [self saveUserHeader];
            }else{
                [self alertMsg:@"Failed, please try again." onOK:^() {
                }];
            }
            
        });
    });
    
}

-(void)saveUserHeader{
    
    if (_userInfo) {
        NSDictionary *d = @{
                            @"full_name": _userInfo.fullName,
                            @"email": _userInfo.email,
                            @"is_student": _userInfo.isStudent ? @"1" : @"0",
                            @"is_linkedin": _userInfo.isLinkedin ? @"1" : @"0"
                            };
        
        
        NSMutableDictionary *md = [NSMutableDictionary dictionaryWithDictionary:d];
        if (uploadPortraitResult != nil) {
            md[@"photo_album"] = @{@"photo_name": uploadPortraitResult};
        } else {
            md[@"photo_album"] = @{@"photo_name": @""};
        }
        [self showIndicator];
        backTask(^() {
            HttpResult *saveInfo = [Proto saveProfileInfo:md];
            foreTask(^() {
                [self hideIndicator];
                if (saveInfo.OK) {
                    [self alertMsg:@"Saved successfully" onOK:^() {
                        [self reloadMeData:self->_selectImage];
                    }];
                } else if (saveInfo.error.code == -1001) {
                    [self alertMsg:@"Failed, please try again." onOK:^() {
                    }];
                } else {
                    [self alertMsg:saveInfo.msg onOK:^() {
                    }];
                }
                
            });
        });
    }else{
        [self hideIndicator];
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
