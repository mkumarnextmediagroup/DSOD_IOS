//
//  UploadResumeItemView.m
//  dentist
//
//  Created by Shirley on 2018/11/18.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "UploadResumeItemView.h"
#import "Common.h"
#import "DenActionSheet.h"
#import "Proto.h"
#import "PreviewResumeViewController.h"
#import <QuickLook/QuickLook.h>




@interface UploadResumeItemView ()<MyActionSheetDelegate,UIDocumentPickerDelegate,HttpProgress>
{
    
}
@end

@implementation UploadResumeItemView{
    
    UIProgressView *progressView;
    UILabel *nameLabel;
    UILabel *sizeLabel;
    
    
    NSString *filePath;//new upload filepath
    NSURL *fileURL;//new upload fileURL or new download fileUrl
    
    NSString *lastResumeUrl;//server return last resume url
    NSString *lastResumeFileName;//server return last resume file name
    
}


- (NSString*)uploadedResumeName{
    if(_uploadedResumeName){
        return _uploadedResumeName;
    }else{
        return @"";
    }
}

- (instancetype)init {
    self = [super init];
    
    Padding *p = self.padding;
    p.left = 16;
    p.right = 16;
    p.top = 16;
    p.bottom = 16;
    self.layoutParam.height = 78;
 
    [self showNoResumeMode];
    
    return self;
}


- (void)showNoResumeMode{
    NSLog(@"%@",NSHomeDirectory());
    
    [self removeAllChildren];
    
    UIImageView *imageView = self.addImageView;
    [imageView alignCenter];
    imageView.imageName = @"cloud";
    [[[[[imageView layoutMaker] sizeEq:48 h:48] leftParent:self.padding.left] centerYParent:0] install];
    [imageView onClick:self action:@selector(uploadResume)];
    
    
    UILabel *titleLabel = self.addLabel;
    UILabel *msgLabel = self.addLabel;
    
    [titleLabel textColorMain];
    titleLabel.font = [Fonts semiBold:14];
    
    [msgLabel textColorMain];
    msgLabel.font = [Fonts regular:12];
    msgLabel.numberOfLines = 2;
    
    
    titleLabel.text = @"Upload Resume";
    msgLabel.text = @"Your professional information will be imported automatically.";
    
    
    [[[[[[titleLabel layoutMaker] topParent:16] toRightOf:imageView offset:14] rightParent:-self.padding.right] heightEq:20] install];
    [[[[[[msgLabel layoutMaker] bottomParent:-16] toRightOf:imageView offset:14] rightParent:-self.padding.right] heightGe:24] install];
    
    
    [titleLabel onClick:self action:@selector(uploadResume)];
    [msgLabel onClick:self action:@selector(uploadResume)];
    
}

- (void)showLastResumeMode{
    [self removeAllChildren];
    
    UIImageView *imageView = self.addImageView;
    [imageView alignCenter];
    imageView.imageName = @"cloud";
    [[[[[imageView layoutMaker] sizeEq:48 h:48] leftParent:self.padding.left] centerYParent:0] install];
    [imageView onClick:self action:@selector(uploadResume)];
    
    
    
    UIButton *viewBtn = self.addButton;
    viewBtn.titleLabel.font = [Fonts regular:16];
    [viewBtn setTitleColor:rgbHex(0x0e78b9) forState:UIControlStateNormal];
    [viewBtn setTitle:@"View"  forState:UIControlStateNormal];
    [[[[viewBtn.layoutMaker rightParent:-self.padding.right] centerYParent:0] sizeEq:55 h:48 ]install];
    [viewBtn addTarget:self action:@selector(viewResume) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel *titleLabel = self.addLabel;
    [titleLabel textColorMain];
    titleLabel.font = [Fonts semiBold:14];
    titleLabel.text = @"Upload Resume";
    [[[[[[titleLabel layoutMaker] topParent:16] toRightOf:imageView offset:14] toLeftOf:viewBtn offset:-10] heightEq:20] install];
    
    UILabel *msgLabel = self.addLabel;
    msgLabel.textColor = rgbHex(0x0e78b9);
    msgLabel.font = [Fonts regular:12];
    msgLabel.numberOfLines = 2;
    msgLabel.text = [NSString stringWithFormat:@"Last upload time : %@",[NSDate USDateShortFormatWithStringTimestamp:[lastResumeUrl substringFromIndex:lastResumeUrl.length-13]]];
    [[[[[[msgLabel layoutMaker] bottomParent:-16] toRightOf:imageView offset:14] toLeftOf:viewBtn offset:-10] heightGe:24] install];
    
    
}

- (void)showUploadResumeMode{
    [self removeAllChildren];
    
    UIImageView *imageView = self.addImageView;
    [imageView alignCenter];
    imageView.imageName = @"cloud";
    [[[[[imageView layoutMaker] sizeEq:48 h:48] leftParent:self.padding.left] centerYParent:0] install];
    [imageView onClick:self action:@selector(uploadResume)];
    
    UIView *bgView = self.addView;
    bgView.backgroundColor = UIColor.whiteColor;
    bgView.layer.borderWidth = 1;
    bgView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    [[[[[bgView.layoutMaker toRightOf:imageView offset:10] rightParent:-self.padding.right]heightEq:48]centerYParent:0]install];
    [self addShadowToView:bgView withColor:UIColor.lightGrayColor];
    
    
    UIActivityIndicatorView *iv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    iv.tag = 998;
    iv.color = UIColor.blueColor;
    iv.backgroundColor = [UIColor clearColor];
    [bgView addSubview:iv];
    [[[[iv.layoutMaker sizeEq:10 h:10]rightParent:-10] topParent:10] install];
    [iv startAnimating];
    
    UILabel *uploadLabel = bgView.addLabel;
    uploadLabel.font = [Fonts regular:12];
    uploadLabel.textColor = rgbHex(0x879aa8);
    uploadLabel.numberOfLines = 1;
    uploadLabel.text = @"Uploading";
    [[[[uploadLabel.layoutMaker toLeftOf:iv offset:-5] centerYOf:iv offset:0] widthEq:65]install];
    
    
    nameLabel = bgView.addLabel;
    nameLabel.font = [Fonts semiBold:14];
    nameLabel.numberOfLines = 1;
    [[[[nameLabel.layoutMaker leftParent:5] toLeftOf:uploadLabel offset:-5] centerYOf:iv offset:0]install];
    
    
    progressView = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
    [bgView addSubview:progressView];
    [[[[progressView.layoutMaker leftParent:5] rightParent:-5]below:nameLabel offset:10]install];
    
    progressView.progress = 0;
    nameLabel.text = [self fileName:filePath];
    
}

- (void)showPreviewResumeMode{
    [self removeAllChildren];
    
    UIImageView *imageView = self.addImageView;
    [imageView alignCenter];
    imageView.imageName = @"cloud";
    [[[[[imageView layoutMaker] sizeEq:48 h:48] leftParent:self.padding.left] centerYParent:0] install];
    [imageView onClick:self action:@selector(uploadResume)];
    
    UIView *bgView = self.addView;
    bgView.backgroundColor = UIColor.whiteColor;
    bgView.layer.borderWidth = 1;
    bgView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    [[[[[bgView.layoutMaker toRightOf:imageView offset:10] rightParent:-self.padding.right]heightEq:48]centerYParent:0]install];
    [self addShadowToView:bgView withColor:UIColor.lightGrayColor];
    
    
    UIButton *delIcon = [bgView addButton];
    [delIcon setImage:[UIImage imageNamed:@"Delete_Icon"] forState:UIControlStateNormal];
    [delIcon addTarget:self action:@selector(delResumeAction) forControlEvents:UIControlEventTouchUpInside];
    [[[[delIcon.layoutMaker rightParent:-5] centerYParent:0] sizeEq:48 h:48] install];
    [delIcon setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    
    
    UIButton *previewBtn = bgView.addButton;
    previewBtn.titleLabel.font = [Fonts regular:12];
    [previewBtn setTitleColor:rgbHex(0x0e78b9) forState:UIControlStateNormal];
    [previewBtn setTitle:@"Preview"  forState:UIControlStateNormal];
    [[[[previewBtn.layoutMaker toLeftOf:delIcon offset:10] centerYParent:0] sizeEq:55 h:48 ]install];
    [previewBtn addTarget:self action:@selector(previewResume) forControlEvents:UIControlEventTouchUpInside];
    
    
    nameLabel = bgView.addLabel;
    nameLabel.font = [Fonts semiBold:14];
    nameLabel.numberOfLines = 1;
    [[[[nameLabel.layoutMaker leftParent:5] toLeftOf:previewBtn offset:-5] topParent:5]install];
    
    sizeLabel = bgView.addLabel;
    sizeLabel.font = [Fonts regular:12];
    sizeLabel.textColor = rgbHex(0x9b9b9b);
    sizeLabel.numberOfLines = 1;
    [[[sizeLabel.layoutMaker leftParent:5] below:nameLabel offset:5]install];
    
    
    nameLabel.text = [self fileName:filePath];
    sizeLabel.text = [self fileSize:filePath];
    
    }

- (void)addShadowToView:(UIView *)theView withColor:(UIColor *)theColor {
    theView.layer.shadowColor = theColor.CGColor;
    theView.layer.shadowOffset = CGSizeMake(0,0);
    theView.layer.shadowOpacity = 0.5;
    theView.layer.shadowRadius = 2;
    theView.layer.masksToBounds = NO;
    
}


-(void)showWithLastResumeUrl:(NSString*)resumeUrl fileName:(NSString*)resumeName{
    lastResumeUrl = resumeUrl;
    lastResumeFileName = resumeName;
    if(self->fileURL && self->filePath && self.uploadedResumeName){
        [self showPreviewResumeMode];
    }else if(lastResumeUrl && lastResumeFileName){
        [self showLastResumeMode];
    }else{
        [self showNoResumeMode];
    }
}

-(void)uploadResume{
    DenActionSheet *denSheet = [[DenActionSheet alloc] initWithDelegate:self title:@"Upload Resume" cancelButton:nil imageArr:nil otherTitle:@"Browse", nil];
    denSheet.linePaddingLeft = 18;
    [denSheet show:self.vc.view];
}

-(void)delResumeAction{
    fileURL = nil;
    filePath = nil;
    self.uploadedResumeName = nil;
    
    [self showWithLastResumeUrl:lastResumeUrl fileName:lastResumeFileName];
}

-(void)viewResume{
    [self.vc showLoading];
    
    backTask(^{
        NSURL *fileURL = [Proto downloadResume:self->lastResumeUrl fileName:self->lastResumeFileName];
        foreTask(^{
            [self.vc hideLoading];
            if(fileURL){
                self->fileURL = fileURL;
                [self previewResume];
            }else{
                NSLog(@"download resume file");
            }
        });
    });
}
-(void)previewResume{
    PreviewResumeViewController *vc = [PreviewResumeViewController new];
    vc.fileURL = self->fileURL;
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc] ;

    [self.vc presentViewController:nvc animated:YES completion:nil ];
}


-(NSString*)fileName:(NSString*)filePath{
    return [[filePath componentsSeparatedByString:@"/"] lastObject];
}

- (NSString*)fileSize:(NSString*)filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        long long size =  [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
        NSString *sizeString = nil;
        if (size < 1000) {
            sizeString = [NSString stringWithFormat:@"%lldB",size];
        } else if (size < 1000000) {
            sizeString = [NSString stringWithFormat:@"%lldKB",size /1000];
        } else if (size < 1000000000) {
            sizeString = [NSString stringWithFormat:@"%.1fMB",(float)size /1000000];
        }
        return sizeString;
    }
    return nil;
}



#pragma mark ---MyActionSheetDelegate
- (void)myActionSheet:(DenActionSheet *)actionSheet parentView:(UIView *)parentView subLabel:(UILabel *)subLabel index:(NSInteger)index{
    
    switch (index) {
        case 1://---click the Browse button
        {
            if (@available(iOS 11.0, *)) {
                UIDocumentPickerViewController *pickerVC = [[UIDocumentPickerViewController alloc]initWithDocumentTypes:@[
                                                              @"com.adobe.pdf",
                                                              @"org.openxmlformats.wordprocessingml.document",
                                                              @"com.microsoft.word.doc"]inMode:UIDocumentPickerModeImport];
                pickerVC.delegate = self;
                [[UINavigationBar appearance] setTintColor:rgbHex(0x0a73ff)];
                [self.vc presentViewController:pickerVC animated:YES completion:nil];
                
            }else{
                [self.vc Den_showAlertWithTitle:@"Below ios11 version is not supported." message:nil appearanceProcess:^(DenAlertController * _Nonnull alertMaker) {
                    alertMaker.addActionCancelTitle(@"OK");
                } actionsBlock:nil];
            }
        }
            break;
        case 2://---click the OneDrive button
        {
            
            
        }
            break;
        default:
            break;
    }
}

#pragma mark ---UIDocumentPickerDelegate
- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentAtURL:(NSURL *)url {
    if(url){
        filePath = [self decoderUrlEncodeStr:url.path];
        fileURL = url;
        
        [self showUploadResumeMode];
        backTask(^{
            HttpResult *result = [Proto uploadResume:self->filePath progress:self];
            
            foreTask(^{
                id name = result.resultMap[@"resumeName"];
                if (result.OK && name != nil && name != NSNull.null) {
                    self.uploadedResumeName = name;
                    [self showPreviewResumeMode];
                }else{
                    [self.vc alertMsg:result.msg?result.msg:@"Upload resume fail" onOK:^{
                        [self showNoResumeMode];
                    }];
                }
            });
        });
    }
}

- (NSString *)decoderUrlEncodeStr: (NSString *) input{
    NSMutableString *outputStr = [NSMutableString stringWithString:input];
    [outputStr replaceOccurrencesOfString:@"+" withString:@"" options:NSLiteralSearch range:NSMakeRange(0,[outputStr length])];
    return [outputStr stringByRemovingPercentEncoding];
}



#pragma mark ---HttpProgress
- (void)onHttpProgress:(int)current total:(int)total percent:(int)percent{
    progressView.progress = (float)percent / 100;
    NSLog(@"%d-----%d",current,total);
}

@end
