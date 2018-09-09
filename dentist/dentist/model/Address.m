//
// Created by entaoyang on 2018/9/6.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "Address.h"
#import "Common.h"


@implementation Address {

}

-(NSString*) detailAddress {
	return strBuild(self.address2, @",", self.address1, @",", self.city, @",", self.stateLabel, @"-", self.zipCode);
}
@end