//
//  ContentPageTests.m
//  dentistTests
//
//  Created by Su Ho V. on 12/21/18.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "ContentPage.h"

SPEC_BEGIN(ContentPageTests)
describe(@"Unit Test For ContentPage", ^{
    __block ContentPage *page;

    beforeEach(^{
        page = [ContentPage new];
    });

    context(@"methods", ^{
        it(@"viewDidLoad", ^{
            UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:page];
            UITabBarController *tabbar = [[UITabBarController alloc] init];
            tabbar.viewControllers = [NSArray arrayWithObjects:navi, nil];
            [page viewDidLoad];
            [[theValue(page.view) shouldNot] beNil];
        });
    });
});
SPEC_END
