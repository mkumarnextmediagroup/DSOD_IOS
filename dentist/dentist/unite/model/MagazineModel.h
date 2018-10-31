//
//  MagazineModel.h
//  dentist
//
//  Created by Wanglibo on 2018/10/31.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MagazineModel : JSONModel

@property NSString <Optional>*serial;
@property NSString <Optional>*cover;
@property NSString <Optional>*vol;
@property NSString <Optional>*issue;
@property NSString <Optional>*publishDate;
@property NSArray <Optional>*articles;

@end

NS_ASSUME_NONNULL_END
