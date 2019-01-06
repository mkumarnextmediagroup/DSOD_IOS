//
//  CMSDetailViewControllerTests.m
//  dentistTests
//
//  Created by Su Ho V. on 12/28/18.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "CMSDetailViewController.h"
#import "DetailModel.h"
#import "DiscussInfo.h"

SPEC_BEGIN(CMSDetailViewControllerTests)
describe(@"Unit Test For CMSDetailViewController", ^{
    __block CMSDetailViewController *controller;

    beforeEach(^{
        controller = [CMSDetailViewController new];
    });

    context(@"methods", ^{
        it(@"view", ^{
            [controller viewWillAppear:TRUE];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"headerView", ^{
            UIView *view = [controller headerView];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"goToViewAllPage", ^{
            [controller goToViewAllPage];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"footerView", ^{
            UIView *view = [controller footerView];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"onBack", ^{
            [controller onBack:[UIButton new]];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"moreBtnClick", ^{
            [controller moreBtnClick:[UIButton new]];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"markBtnClick", ^{
            controller.articleInfo = [DetailModel new];
            controller.articleInfo.isBookmark = TRUE;
            [controller markBtnClick:[UIButton new]];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"markBtnClick", ^{
            controller.articleInfo = [DetailModel new];
            controller.articleInfo.isBookmark = NO;
            [controller markBtnClick:[UIButton new]];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"gotoReview", ^{
            [controller gotoReview];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"gskBtnClick", ^{
            [controller gskBtnClick];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"viewForHeader", ^{
            UIView *view = [controller tableView:NULL viewForHeaderInSection:0];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"viewForFooter", ^{
            UIView *view = [controller tableView:NULL viewForFooterInSection:0];
            [[theValue(view) shouldNot] beNil];
        });

        it(@"heightForHeader", ^{
            CGFloat height = [controller tableView:NULL heightForHeaderInSection:0];
            [[theValue(height) should] equal:theValue(78)];
        });

        it(@"heightForFooter", ^{
            CGFloat height = [controller tableView:NULL heightForFooterInSection:0];
            [[theValue(height) should] equal:theValue(75)];
        });

        it(@"numberOfRows", ^{
            DetailModel *model = [DetailModel new];
            id objects[] = {@"abc12"};
            NSUInteger count = sizeof(objects) / sizeof(id);
            NSArray *array = [NSArray arrayWithObjects:objects
                                                 count:count];
            model.discussInfos = array;
            controller.articleInfo = model;
            NSInteger rows = [controller tableView:NULL numberOfRowsInSection:0];
            [[theValue(rows) should] equal:theValue(1)];
        });

        it(@"heightForRow", ^{
            CGFloat height = [controller tableView:NULL heightForRowAtIndexPath:NULL];
            [[theValue(height) should] equal:theValue(110)];
        });

        it(@"cellForRowAtIndexPath", ^{
            DetailModel *model = [DetailModel new];
            id objects[] = {[DiscussInfo new]};
            NSUInteger count = sizeof(objects) / sizeof(id);
            NSArray *array = [NSArray arrayWithObjects:objects
                                                 count:count];
            model.discussInfos = array;
            controller.articleInfo = model;
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            UITableViewCell *cell = [controller tableView:[UITableView new] cellForRowAtIndexPath:indexPath];
            [[theValue(cell) shouldNot] beNil];
        });

        it(@"showTipView", ^{
            [controller showTipView:@"tip view"];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"openNewCmsDetail", ^{
            [controller openNewCmsDetail:@"open" index:0 withAnimation:kCATransitionFromBottom];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"onClickUp", ^{
            [controller onClickUp:[UIButton new]];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"onClickDown", ^{
            [controller onClickDown:[UIButton new]];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"myActionSheet", ^{
            DetailModel *model = [DetailModel new];
            controller.articleInfo = model;
            [controller myActionSheet:[DenActionSheet new] parentView:[UIView new] subLabel:[UILabel new] index:0];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"myActionSheet", ^{
            DetailModel *model = [DetailModel new];
            model.featuredMedia = @{@"type": @"1",
                                    @"code": @{@"thumbnailUrl": @"https://image.freepik.com/free-icon/test-quiz_318-86103.jpg"},
                                    };
            controller.articleInfo = model;
            [controller myActionSheet:[DenActionSheet new] parentView:[UIView new] subLabel:[UILabel new] index:1];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"myActionSheet", ^{
            DetailModel *model = [DetailModel new];
            controller.articleInfo = model;
            [controller myActionSheet:[DenActionSheet new] parentView:[UIView new] subLabel:[UILabel new] index:1];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"myActionSheet", ^{
            [controller myActionSheet:[DenActionSheet new] parentView:[UIView new] subLabel:[UILabel new] index:1];
            [[theValue(controller.view) shouldNot] beNil];
        });
    });
});
SPEC_END
