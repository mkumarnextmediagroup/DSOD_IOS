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




@interface UploadResumeItemView ()<MyActionSheetDelegate,UIDocumentPickerDelegate,HttpProgress>
{
    NSMutableArray<NSString *> *segItems;
}
@end

@implementation UploadResumeItemView{
    UIImageView *imageView;
    UILabel *titleLabel;
    UILabel *msgLabel;
    
}



- (instancetype)init {
    self = [super init];
    
    Padding *p = self.padding;
    p.left = 16;
    p.right = 16;
    p.top = 16;
    p.bottom = 16;
    self.layoutParam.height = 78;

    imageView = self.addImageView;
    [imageView alignCenter];
    imageView.imageName = @"cloud";



    [[[[[imageView layoutMaker] sizeEq:48 h:48] leftParent:self.padding.left] centerYParent:0] install];

    
    
    return self;
}

- (void)showNoResumeMode{
    
    titleLabel = self.addLabel;
    msgLabel = self.addLabel;
    
    [titleLabel textColorMain];
    titleLabel.font = [Fonts semiBold:14];
    
    [msgLabel textColorMain];
    msgLabel.font = [Fonts regular:12];
    msgLabel.numberOfLines = 0;
    
    
    titleLabel.text = @"Upload Resume";
    msgLabel.text = @"Your professional information will be imported automatically.";
    
    
    [[[[[[titleLabel layoutMaker] topParent:16] toRightOf:imageView offset:14] rightParent:-self.padding.right] heightEq:20] install];
    [[[[[[msgLabel layoutMaker] bottomParent:-16] toRightOf:imageView offset:14] rightParent:-self.padding.right] heightGe:24] install];
    
    
    [imageView onClick:self action:@selector(uploadResume)];
}

-(void)uploadResume{
    
    
        DenActionSheet *denSheet = [[DenActionSheet alloc] initWithDelegate:self title:@"Upload Resume" cancelButton:nil imageArr:nil otherTitle:@"Browse",@"OneDrive", nil];
        denSheet.linePaddingLeft = 18;
        [denSheet show:self.vc.view];
}

- (void)resetLayout {

    
}

#pragma mark ---MyActionSheetDelegate
- (void)myActionSheet:(DenActionSheet *)actionSheet parentView:(UIView *)parentView subLabel:(UILabel *)subLabel index:(NSInteger)index{
    
    switch (index) {
        case 1://---click the Browse button
        {
            
//            @"com.adobe.pdf",
//            @"com.microsoft.word.doc",
//            @"com.microsoft.word.docx"
            if (@available(iOS 11.0, *)) {
                UIDocumentPickerViewController *pickerVC = [[UIDocumentPickerViewController alloc]initWithDocumentTypes:@[
                                                                                                                          
                                                                                                                          @"com.microsoft.powerpoint.​ppt",
                                                                                                                          @"com.microsoft.word.doc",
                                                                                                                          @"com.microsoft.excel.xls",
                                                                                                                          @"com.microsoft.powerpoint.​pptx",
                                                                                                                          @"com.microsoft.word.docx",
                                                                                                                      @"com.microsoft.excel.xlsx",
                                                                                                                          @"public.avi",
                                                                                                                          @"public.3gpp",
                                                                                                                          @"public.mpeg-4",
                                                                                                                          @"com.compuserve.gif",
                                                                                                                          @"public.jpeg",
                                                                                                                          @"public.png",
                                                                                                                          @"public.plain-text",
                                                                                                                          @"com.adobe.pdf"               
                                                                                                                          ]
                                            inMode:UIDocumentPickerModeOpen];
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

#pragma mark ---MyActionSheetDelegate
- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentsAtURLs:(NSArray <NSURL *>*)urls{
    if(urls && urls.count>0){
        backTask(^{
            NSString *filePath =[[self decoderUrlEncodeStr:urls[0].absoluteString] substringFromIndex:7];
            NSString *resumeName = [Proto uploadResume:filePath progress:self];
            NSLog(@"--------%@",resumeName);
        });
    }
    
    
}

- (NSString *)decoderUrlEncodeStr: (NSString *) input{
    NSMutableString *outputStr = [NSMutableString stringWithString:input];
    [outputStr replaceOccurrencesOfString:@"+" withString:@"" options:NSLiteralSearch range:NSMakeRange(0,[outputStr length])];
    return [outputStr stringByRemovingPercentEncoding];
}



#pragma mark ---MyActionSheetDelegate
- (void)onHttpStart:(int)total{
     NSLog(@"---start------------");
}

- (void)onHttpProgress:(int)current total:(int)total percent:(int)percent{
     NSLog(@"%d---%d----%d",current,total,percent);
}


- (void)onHttpFinish:(BOOL)success{
     NSLog(@"---end----%d------------",success);
}


@end
