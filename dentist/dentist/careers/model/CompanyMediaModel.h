//
//  CompanyMediaModel.h
//  dentist
//
//  Created by Shirley on 2018/12/3.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CompanyMediaModel : JSONModel

@property NSInteger media_type;
@property NSArray <Optional>*media;
@property NSArray <Optional>*mediaURL;

@end

NS_ASSUME_NONNULL_END
