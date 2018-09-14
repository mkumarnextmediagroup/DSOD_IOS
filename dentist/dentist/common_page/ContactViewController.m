//
//  ContactViewController.m
//  dentist
//
//  Created by Jacksun on 2018/8/21.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "ContactViewController.h"
#import "ContactTableViewCell.h"
#import "MagazineTableViewCell.h"
#import "Common.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>

@interface ContactViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate,UITextViewDelegate>
{
    UITableView *myTable;
    UIImage     *selectImage;
    NSString    *selectImageName;
}


@end

@implementation ContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *backImg = [UIImage imageNamed:@"close.png"];
    [self setTopTitle:@"CONTACT US" imageName:backImg];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    myTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVHEIGHT, SCREENWIDTH, SCREENHEIGHT - 130) style:UITableViewStylePlain];
    myTable.delegate = self;
    myTable.dataSource = self;
    [self.view addSubview:myTable];
    
    UIButton *sendButton = [UIButton new];
    [sendButton title:localStr(@"SendMess")];
    [sendButton stylePrimary];
    [self.view addSubview:sendButton];
    StackLayout *sl = [StackLayout new];
    [sl push:sendButton height:BTN_HEIGHT marginBottom:20];
    [sl install];
    
    [sendButton onClick:self action:@selector(clickSend:)];
    // Do any additional setup after loading the view.
}

- (void)clickSend:(UIButton *)btn
{
    NSLog(@"send message");
    [self Den_showAlertWithTitle:@"Message sent successfully" message:nil appearanceProcess:^(DenAlertController * _Nonnull alertMaker) {
        alertMaker.
        addActionCancelTitle(@"OK");
    } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, DenAlertController * _Nonnull alertSelf) {
        
    }];
}

#pragma mark UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

#pragma mark UITableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            return 50;
            break;
        case 1:
            return 70;
            break;
        case 2:
            return 220;
            break;
        case 3:
            return 49;
            break;
        case 4:
            return 180;
            break;
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 3) {
        static NSString *brand_region_Cell = @"Cell";
        
        MagazineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:brand_region_Cell];
        
        if (cell == nil)
        {
            cell = [[MagazineTableViewCell alloc]
                    initWithStyle:UITableViewCellStyleDefault
                    reuseIdentifier:brand_region_Cell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (selectImageName.length != 0) {
            cell.notice.text = selectImageName;
            [cell.phoneBtn setImage:selectImage forState:UIControlStateNormal];
            cell.deleteBtn.hidden = NO;
            [cell.deleteBtn addTarget:self action:@selector(deleteSelect) forControlEvents:UIControlEventTouchUpInside];
            [cell.phoneBtn setFrame:CGRectMake(22, 10, 29, 29)];

        }else
        {
            cell.deleteBtn.hidden = YES;
            [cell.phoneBtn setImage:[UIImage imageNamed:@"photo"] forState:UIControlStateNormal];
            [cell.phoneBtn setFrame:CGRectMake(0, 0, 80, 49)];
            cell.notice.text = localStr(@"addAttach");
        }
        return cell;

    }else if (indexPath.section == 4) {
        static NSString *brand_region_Cell = @"Cell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:brand_region_Cell];
        
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc]
                    initWithStyle:UITableViewCellStyleDefault
                    reuseIdentifier:brand_region_Cell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.textLabel.text = localStr(@"we will");
        cell.textLabel.numberOfLines = 0;
        [cell.textLabel textColorMain];
        cell.textLabel.font = [Fonts semiBold:17];

        return cell;
        
    }else
    {
        static NSString *brand_region_Cell = @"MyCell";
        
        ContactTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:brand_region_Cell];
        
        if (cell == nil)
        {
            cell = [[ContactTableViewCell alloc]
                    initWithStyle:UITableViewCellStyleDefault
                    reuseIdentifier:brand_region_Cell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        switch (indexPath.section) {
            case 0:
            {
                cell.notice.text = localStr(@"haveQuestion");
            }
                break;
            case 1:
            {
                cell.notice.text = localStr(@"your email");
                cell.emailField.hidden = NO;
                cell.emailField.delegate = self;
            }
                break;
            case 2:
            {
                cell.notice.text = localStr(@"write brief");
                cell.content.hidden = NO;
                cell.content.delegate = self;
            }
                break;
            default:
                break;
        }
        return cell;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){
        
        [textView resignFirstResponder];
        return NO; 
    }
    
    return YES;
}

- (void)deleteSelect
{
    selectImageName = nil;
    selectImage = nil;
    [myTable reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 3) {//click the add an attachment btn
        [self callActionSheetFunc];
    }
    
    [self.view endEditing:YES];
}

- (void)callActionSheetFunc{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        
        [self Den_showActionSheetWithTitle:nil message:nil appearanceProcess:^(DenAlertController * _Nonnull alertMaker) {
            alertMaker.
            addActionCancelTitle(@"cancel").
            addActionDefaultTitle(@"Camera").
            addActionDefaultTitle(@"Gallery");
        } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, DenAlertController * _Nonnull alertSelf) {
            if ([action.title isEqualToString:@"cancel"]) {
                NSLog(@"cancel");
            }
            else if ([action.title isEqualToString:@"Camera"]) {
                NSLog(@"Camera");
                [self clickTheBtnWithSourceType:UIImagePickerControllerSourceTypeCamera];
            }else if ([action.title isEqualToString:@"Gallery"]) {
                NSLog(@"Gallery");
                [self clickTheBtnWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
            }
        }];
        
    }else{
        [self Den_showActionSheetWithTitle:nil message:nil appearanceProcess:^(DenAlertController * _Nonnull alertMaker) {
            alertMaker.
            addActionCancelTitle(@"cancel").
            addActionDefaultTitle(@"Gallery");
        } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, DenAlertController * _Nonnull alertSelf) {
            if ([action.title isEqualToString:@"cancel"]) {
                NSLog(@"cancel");
            }
            else if ([action.title isEqualToString:@"Gallery"]) {
                NSLog(@"Gallery");
                [self clickTheBtnWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
            }
        }];
    }
}

- (void)clickTheBtnWithSourceType:(UIImagePickerControllerSourceType)sourceType
{
    [DenCamera clickTheBtnWithSourceType:sourceType block:^(NSString *isAllow) {
        NSLog(@"%@",isAllow);
        if ([isAllow isEqualToString:@"CameraRefuse"]) {
            Confirm *cf = [Confirm new];
            cf.title = @"Unauthorized use of camera";
            cf.msg = @"Please open it in IOS “settings”-“privacy”-“camera”";
            [cf show:self onOK:^() {
            }];
        }else if ([isAllow isEqualToString:@"PhotoRefuse"])
        {
            Confirm *cf = [Confirm new];
            cf.title = @"Unauthorized use of photo";
            cf.msg = @"Please open it in IOS “settings”-“privacy”-“photo”";
            [cf show:self onOK:^() {
            }];
        }else if ([isAllow isEqualToString:@"allow"])
        {
            [self presentImagePickerViewController:sourceType];
        }
    }];
}

- (void)presentImagePickerViewController:(UIImagePickerControllerSourceType)sourceType
{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    imagePickerController.sourceType = sourceType;
    [self presentViewController:imagePickerController animated:YES completion:nil];

}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = nil;
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        
        NSString *imageName = [info valueForKey:UIImagePickerControllerMediaType];
        NSLog(@"imageName1:%@", imageName);
        selectImageName = imageName;
        selectImage = image;
        [myTable reloadData];

    }else{
        image = info[UIImagePickerControllerOriginalImage];
        
        NSURL *imageURL = [info valueForKey:UIImagePickerControllerReferenceURL];
        
        ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
        //根据url获取asset信息, 并通过block进行回调
        [assetsLibrary assetForURL:imageURL resultBlock:^(ALAsset *asset) {
            ALAssetRepresentation *representation = [asset defaultRepresentation];
            NSString *imageName = representation.filename;
            NSLog(@"imageName:%@", imageName);
            self->selectImageName = imageName;
            selectImage = image;
            [myTable reloadData];
            
        } failureBlock:^(NSError *error) {
            NSLog(@"%@", [error localizedDescription]);
        }];
        
        PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
        if (status == PHAuthorizationStatusNotDetermined) {
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                if(status == PHAuthorizationStatusAuthorized) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        // user click "OK"
                    });
                } else {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        // user click refuse
                    });
                }
            }];
        }
    }
    [self dismissViewControllerAnimated:NO completion:nil];
    
    
}

- (void)setTopTitle:(NSString *)title imageName:(UIImage *)imageName
{
    UIView *topVi = [UIView new];
    topVi.frame = CGRectMake(0, 0, SCREENWIDTH, NAVHEIGHT);
    topVi.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topVi];
    
    UILabel *content = [UILabel new];
    content.font = [UIFont systemFontOfSize:19];
    content.textColor = [UIColor blackColor];
    content.text = title;
    content.textAlignment = NSTextAlignmentCenter;
    content.frame = CGRectMake(50, 23, SCREENWIDTH - 100, 40);
    [topVi addSubview:content];
    
    UIButton *dismissBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [dismissBtn setImage:imageName forState:UIControlStateNormal];
    dismissBtn.frame = CGRectMake(SCREENWIDTH - 60, 24, 60, 40);
    [topVi addSubview:dismissBtn];
    [dismissBtn addTarget:self action:@selector(dismissBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *line = [UILabel new];
    line.frame = CGRectMake(0, NAVHEIGHT - 1.5, SCREENWIDTH, 1.5);
    line.backgroundColor = rgb255(222, 222, 222);
    [topVi addSubview:line];
}

- (void)dismissBtnClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
