//
//  FAQSCCtegorieModel.h
//  dentist
//
//  Created by Shirley on 2019/1/13.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "JSONModel.h"
#import "FAQSModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FAQSCategoryModel : JSONModel

@property NSString <Optional>*moduleType;
@property NSMutableArray <FAQSModel*>*faqsModelArray;

@end

NS_ASSUME_NONNULL_END
