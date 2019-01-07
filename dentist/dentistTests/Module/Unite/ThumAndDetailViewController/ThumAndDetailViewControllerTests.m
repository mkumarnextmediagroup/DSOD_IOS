//
//  ThumAndDetailViewControllerTests.m
//  dentistTests
//
//  Created by Su Ho V. on 1/6/19.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "ThumAndDetailViewController.h"
#import "DetailModel.h"
#import "UniteThumCollectionViewCell.h"

SPEC_BEGIN(ThumAndDetailViewControllerTests)
describe(@"Unit Test For ThumAndDetailViewController", ^{
    __block ThumAndDetailViewController *controller;

    beforeEach(^{
        controller = [ThumAndDetailViewController new];
    });

    context(@"methods", ^{
        it(@"setupNavigation", ^{
            [controller setupNavigation];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"setModelarr", ^{
            id objects[] = { [DetailModel new] };
            NSUInteger count = sizeof(objects) / sizeof(id);
            NSArray *array = [NSArray arrayWithObjects:objects
                                                 count:count];
            [controller setModelarr:array];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"onBack", ^{
            [controller onBack:[UIButton new]];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"openMenu", ^{
            [controller openMenu:[UIButton new]];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"numberOfSectionsInCollectionView", ^{
            NSInteger num = [controller numberOfSectionsInCollectionView:NULL];
            [[theValue(num) should] equal:theValue(1)];
        });

        it(@"cellForItemAtIndexPath", ^{
            UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
            UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
            [collectionView registerClass:[UniteThumCollectionViewCell class] forCellWithReuseIdentifier:@"UniteThumCellID"];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            UICollectionViewCell *cell = [controller collectionView:collectionView cellForItemAtIndexPath:indexPath];
            [[theValue(cell) shouldNot] beNil];
        });

        it(@"UniteThumCollectionViewCellScroview", ^{
            [controller UniteThumCollectionViewCellScroview:0];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"hideNavBar", ^{
            [controller hideNavBar:TRUE];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"scrollViewDidEndDecelerating", ^{
            [controller scrollViewDidEndDecelerating: [UIScrollView new]];
            [[theValue(controller.view) shouldNot] beNil];
        });
    });
});
SPEC_END

