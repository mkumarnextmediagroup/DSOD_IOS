//
//  FAQSModel.h
//  dentist
//
//  Created by Shirley on 2019/1/13.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "JSONModel.h"
#import "FAQSSubDescModel.h"

NS_ASSUME_NONNULL_BEGIN


@interface FAQSModel : JSONModel

@property NSString *_id;
@property NSString <Optional>*moduleType;
@property NSString <Optional>*function;
@property NSString <Optional>*desc;
@property NSArray <FAQSSubDescModel>*subDescription;


@end

NS_ASSUME_NONNULL_END
