//
//  AuthorModel.h
//  dentist
//
//  Created by Shirley on 2019/2/14.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "JSONAPI.h"

NS_ASSUME_NONNULL_BEGIN

@interface AuthorModel : JSONModel
@property NSString <Optional>*id;
@property NSString <Optional>*firstName;
@property NSString <Optional>*lastName;
@property NSString <Optional>*fullName;
@property NSString <Optional>*authorDetails;
@property NSString <Optional>*email;
@property NSString <Optional>*cellPhone;
@property NSString <Optional>*objectId;
@property NSString <Optional>*specialty;
@property NSString <Optional>*location;

@end

NS_ASSUME_NONNULL_END
