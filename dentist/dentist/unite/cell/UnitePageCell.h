//
//  UnitePageCell.h
//  dentist
//
//  Created by wanglibo on 2018/10/31.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MagazineModel.h"

typedef NS_ENUM(NSInteger, UnitePageDownloadStatus) {
    UPageNoDownload,
    UPageDownloading,
    UPageDownloaded
};


typedef void(^OptonBtnOnClickListener)(UnitePageDownloadStatus,MagazineModel*);

typedef void(^OptonBtnOnClickDownload)(NSInteger status,MagazineModel*);

@interface UnitePageCell : UITableViewCell

@property (strong, nonatomic)MagazineModel *magazineModel;
@property (strong, nonatomic)OptonBtnOnClickListener optonBtnOnClickListener;
@property (strong, nonatomic)OptonBtnOnClickDownload optonBtnOnClickDownload;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
- (void)setMagazineModel:(MagazineModel *)magazineModel;
-(void)optionBtnDownloadStyle;
-(void)optionBtnDownloadingStyle;
-(void)optionBtnReadStyle;
-(UnitePageDownloadStatus)getUnitePageDownloadStatus;
-(void)optionBtnAction:(UIButton *)sender;

@end
