//
//  FAQSViewController.h
//  dentist
//
//  Created by Shirley on 2019/1/6.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FAQSCategoryModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FAQSViewController : UIViewController



/**
 Open FAQS page

 @param vc UIViewController
 @param categoryModel FAQSCategoryModel
 */
+(void)openBy:(UIViewController*)vc categoryModel:(FAQSCategoryModel*)categoryModel;

@end

NS_ASSUME_NONNULL_END
