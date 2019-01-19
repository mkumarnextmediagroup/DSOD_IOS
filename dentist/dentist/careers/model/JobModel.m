//
//  JobModel.m
//  dentist
//
//  Created by feng zhenrong on 2018/11/28.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "JobModel.h"
#import "NSString+myextend.h"

@implementation JobModel

-(NSString*)location{
    NSString *location=@"";
    if (![NSString isBlankString:self.city] && ![NSString isBlankString:self.state]) {
        location = [NSString stringWithFormat:@"%@,%@",self.city , self.state];
    }else if(![NSString isBlankString:self.city]){
        location = self.city;
    }else if (![NSString isBlankString:self.state]) {
        location = self.state;
    }
    return location;
}

-(NSString*)salaryRange{
    NSInteger startsalary=ceilf(self.salaryStartingValue/1000.0);
    NSInteger endsalary=ceilf(self.salaryEndValue/1000.0);
    return [NSString stringWithFormat:@"Est. Salary: $%@k-$%@k",@(startsalary),@(endsalary)];
}

@end
