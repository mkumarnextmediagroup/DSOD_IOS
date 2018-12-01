//
//  DescriptionOfDSODetailTableViewCell.m
//  dentist
//
//  Created by Shirley on 2018/12/1.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "DescriptionOfDSODetailTableViewCell.h"

@implementation DescriptionOfDSODetailTableViewCell


-(void)setData:(CompanyModel*)model{
    if(model.description){
        [self showContent:model.description];
    }
}

@end
