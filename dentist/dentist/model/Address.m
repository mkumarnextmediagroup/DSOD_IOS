//
// Created by entaoyang on 2018/9/6.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "Address.h"
#import "Common.h"


@implementation Address {

}

-(NSString*) detailAddress {
    NSString *detailAddr = strBuild(self.address1, self.address2, self.city, @", ", self.stateLabel, @" ", self.zipCode);
    if ([detailAddr.trimed isEqualToString:@","])
    {
        detailAddr = @"";
    }
    return detailAddr;
}
@end
