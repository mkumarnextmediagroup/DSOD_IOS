//
//  LMSResourceTableViewCell.m
//  dentist
//
//  Created by Shirley on 2019/2/28.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "LMSResourceTableViewCell.h"
#import "Common.h"
#import "DentistDownloadModel.h"
#import "DentistDownloadButton.h"
#import "DenActionSheet.h"

@implementation LMSResourceTableViewCell{

    int edge;
    
    UIView *contentView;
    UILabel *numberLabel;
    UIImageView *iconIV;
    UILabel *nameLabel;
    UILabel *timeLabel;
    UIView *downloadView;
    DentistDownloadButton *downloadBtn;
    
    __block DentistDownloadModel *downloadModel;
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        edge = 18;
        [self buildView];
    }
    return self;
}


/**
 build views
 */
-(void)buildView{
    
    contentView = self.addView;
    [[[[[contentView.layoutMaker leftParent:0]topParent:0]rightParent:0]bottomParent:0] install];
    contentView.userInteractionEnabled = YES;
    
    
    numberLabel = contentView.addLabel;
    numberLabel.textColor = rgbHex(0x4A4A4A);
    numberLabel.font = [Fonts regular:14];
    [[[[numberLabel.layoutMaker leftParent:edge] centerYParent:0]widthEq:25] install];
    
    iconIV = contentView.addImageView;
    iconIV.imageName = @"ic_lms_resource_pdf";
    [[[[iconIV.layoutMaker toRightOf:numberLabel offset:0]centerYParent:0]sizeEq:24 h:24]install];
    
    
    nameLabel = contentView.addLabel;
    nameLabel.textColor = rgbHex(0x1A191A);
    nameLabel.font = [Fonts regular:14];
    [[[[nameLabel.layoutMaker toRightOf:iconIV offset:10] centerYParent:0] rightParent:-50]install];
    
    CGFloat downloadViewWidth = 40;
    downloadView = contentView.addView;
    [[[[downloadView.layoutMaker rightParent:-10]centerYParent:0]sizeEq:downloadViewWidth h:downloadViewWidth]install];
    [downloadView onClickView:self action:@selector(downloadViewClick)];
    
    

    CGFloat btnW = 24.f;
//    CGFloat btnW = 40.f;
    downloadBtn = [[DentistDownloadButton alloc] initWithFrame:CGRectMake((downloadViewWidth-btnW)/2 , (downloadViewWidth-btnW)/2 , btnW, btnW)];
    downloadBtn.userInteractionEnabled = NO;
    [downloadView addSubview:downloadBtn];
    
}


/**
 show data

 @param model download info m
 @param number sort number
 @param resourceType resource type （1.Video 2.audio 3.ScormCourse 4.file  100.test）
 @param showDownloadBtn Control download button display
 */
-(void)showData:(DentistDownloadModel*)model number:(int)number resourceType:(NSInteger)resourceType showDownloadBtn:(BOOL)showDownloadBtn{
    downloadModel = model;
    
    numberLabel.text = [NSString stringWithFormat:@"%d.",number];
    nameLabel.text = model.fileName;
    
    downloadBtn.model = model;
    downloadBtn.progress = model.progress;
    
    if(resourceType==100){
//        iconIV.imageName =
        
    }else{
        
    }
    
}

/**
 Update download progress

 @param model DentistDownloadModel
 */
- (void)updateViewWithModel:(DentistDownloadModel *)model{
    downloadModel = model;
    downloadBtn.model = model;
    downloadBtn.progress = model.progress;
}


-(void)downloadViewClick{
    
    if (downloadModel.state == DentistDownloadStateDefault
        || downloadModel.state == DentistDownloadStatePaused
        || downloadModel.state == DentistDownloadStateError) {
        // 点击默认、暂停、失败状态，调用开始下载
        [[DentistDownloadManager shareManager] startDownloadTask:downloadModel];
        
    }else if (downloadModel.state == DentistDownloadStateDownloading
          || downloadModel.state == DentistDownloadStateWaiting) {
        // 点击正在下载、等待状态，弹出取消菜单
        [self showCancelDownloadMenu:downloadModel];
    }else if(downloadModel.state == DentistDownloadStateFinish){
        // 点击完成状态，弹出删除菜单
        [self showRemoveDownloadMenu:downloadModel];
    }
}


/**
 弹出取消下载对话框
 Pop-up cancel download dialog box
 
  @param downloadModel DentistDownloadModel
 */
-(void)showCancelDownloadMenu:(DentistDownloadModel*)downloadModel{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    UIAlertAction *cancelDownloadAction = [UIAlertAction actionWithTitle:@"Cancel Download" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[DentistDownloadManager shareManager] deleteTaskAndCache:downloadModel];
        if(self.cancelDownloadCallback){
            self.cancelDownloadCallback();
        }
        
    }];
    
    
    [cancelAction setValue:rgbHex(0x5E6E7A) forKey:@"titleTextColor"];
    [cancelDownloadAction setValue:rgbHex(0x5E6E7A) forKey:@"titleTextColor"];
    
    [alertController addAction:cancelAction];
    [alertController addAction:cancelDownloadAction];

    [self.vc presentViewController:alertController animated:YES completion:nil];
}
/**
 弹出删除下载内容对话框
 Pop-up remove download dialog box

 @param downloadModel DentistDownloadModel
 */
-(void)showRemoveDownloadMenu:(DentistDownloadModel*)downloadModel{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    UIAlertAction *cancelDownloadAction = [UIAlertAction actionWithTitle:@"Remove Download" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[DentistDownloadManager shareManager] deleteTaskAndCache:downloadModel];
        
        if(self.removeDownloadCallback){
            self.removeDownloadCallback();
        }
    }];
    
    
    [cancelAction setValue:rgbHex(0x5E6E7A) forKey:@"titleTextColor"];
    [cancelDownloadAction setValue:rgbHex(0x5E6E7A) forKey:@"titleTextColor"];
    
    [alertController addAction:cancelAction];
    [alertController addAction:cancelDownloadAction];
    
    [self.vc presentViewController:alertController animated:YES completion:nil];
}

@end
