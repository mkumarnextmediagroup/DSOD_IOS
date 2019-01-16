//
//  FAQSSubDescModel.h
//  dentist
//
//  Created by Shirley on 2019/1/14.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol FAQSSubDescModel <NSObject>


@end

@interface FAQSSubDescModel : JSONModel

@property NSString <Optional>*name;
@property NSArray <NSString*>*steps;


@end

NS_ASSUME_NONNULL_END
