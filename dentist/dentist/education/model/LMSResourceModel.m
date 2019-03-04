//
//  LMSResourceModel.m
//  dentist
//
//  Created by Shirley on 2019/2/28.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "LMSResourceModel.h"
#import "Proto.h"

@implementation LMSResourceModel


+(BOOL)propertyIsOptional:(NSString*)propertyName{
    return YES;
}

-(DentistDownloadModel*)downloadModel{
    if(_downloadModel==nil){
        _downloadModel = [[DentistDownloadModel alloc]init];
        _downloadModel.vid = self.id;
        _downloadModel.fileName = self.name;
        _downloadModel.url = [Proto getLMSDownloadUrlByObjectId: self.resource];
        
        //wanglibo todo delte
        _downloadModel.url = @"https://www.apple.com/105/media/cn/imac-pro/2018/d0b63f9b_f0de_4dea_a993_62b4cb35ca96/films/buck/imac-pro-buck-tpl-cn-20180223_1280x720h.mp4";
        
        if([_downloadModel.url rangeOfString:@"?"].location != NSNotFound){
            _downloadModel.url = [NSString stringWithFormat:@"%@&vid=%@",_downloadModel.url,_downloadModel.vid];
        }else{
            _downloadModel.url = [NSString stringWithFormat:@"%@?vid=%@",_downloadModel.url,_downloadModel.vid];
        }
        
    }
    return _downloadModel;
}

@end
