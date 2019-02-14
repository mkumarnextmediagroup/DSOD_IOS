//
//  UniteDownloadingViewController.h
//  dentist
//
//  Created by wanglibo on 2018/11/2.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MagazineModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface UniteDownloadingViewController : UIViewController

@property (nonatomic,strong) MagazineModel *magazineModel;
@property (nonatomic,strong) NSArray *datas;//test property

-(void)downloadBtnAction;
-(void)cancelBtnAction;
-(void)loadData;
-(void)downloadData;
- (void)onBack:(UIButton *)btn;

@end

NS_ASSUME_NONNULL_END
