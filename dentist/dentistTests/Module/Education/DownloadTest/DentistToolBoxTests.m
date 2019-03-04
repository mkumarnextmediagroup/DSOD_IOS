//
//  DentistToolBoxTests.m
//  dentistTests
//
//  Created by Su Ho V. on 3/2/19.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "DentistToolBox.h"

SPEC_BEGIN(DentistToolBoxTests)
describe(@"Unit Test For DentistToolBox", ^{
    context(@"methods", ^{

        it(@"stringFromByteCount", ^{
            NSString *str = [DentistToolBox stringFromByteCount:10];
            [[str should] equal: @"10 bytes"];
        });

        it(@"getTimeStampWithDate", ^{
            NSInteger num = [DentistToolBox getTimeStampWithDate:[[NSDate alloc] initWithTimeIntervalSince1970:0]];
            [[theValue(num) should] equal:theValue(0)];
        });

        it(@"getDateWithTimeStamp", ^{
            NSDate *date = [DentistToolBox getDateWithTimeStamp:0];
            NSLog(@"%@", date);
            [[theValue([date timeIntervalSince1970]) should] equal:theValue(0)];
        });

        it(@"getIntervalsWithTimeStamp", ^{
            NSInteger num = [DentistToolBox getIntervalsWithTimeStamp:0];
            NSDate *date = [DentistToolBox getDateWithTimeStamp: 0];
            [[theValue(num) should] equal:theValue((NSInteger) [[NSDate date] timeIntervalSinceDate:date])];
        });

        it(@"getCurrentDeviceModel", ^{
            NSString *d = [DentistToolBox getCurrentDeviceModel];
            [[d should] equal:@"iPhone Simulator"];
        });

        it(@"findViewController", ^{
            UIViewController *controller = [DentistToolBox findViewController:[UIView new]];
            [[controller should] beNil];
        });

        it(@"getCurrentVC", ^{
            UIViewController *controller = [DentistToolBox getCurrentVC];
            [[controller should] beNil];
        });

        it(@"LibraryDirectory", ^{
            NSString *str = [DentistToolBox LibraryDirectory];
            [[str shouldNot] beNil];
        });

        it(@"DocumentDirectory", ^{
            NSString *str = [DentistToolBox DocumentDirectory];
            [[str shouldNot] beNil];
        });

        it(@"PreferencePanesDirectory", ^{
            NSString *str = [DentistToolBox PreferencePanesDirectory];
            [[str shouldNot] beNil];
        });

        it(@"CachesDirectory", ^{
            NSString *str = [DentistToolBox CachesDirectory];
            [[str shouldNot] beNil];
        });

        it(@"isAllNumber", ^{
            BOOL isAllNumber = [DentistToolBox isAllNumber:@"12345"];
            [[theValue(isAllNumber) should] equal:theValue(YES)];
        });

        it(@"isAllNumber", ^{
            BOOL isAllNumber = [DentistToolBox isAllNumber:@"12asd"];
            [[theValue(isAllNumber) should] equal:theValue(NO)];
        });

        it(@"isMobileNumber", ^{
            BOOL isMobileNumber = [DentistToolBox isMobileNumber:@""];
            [[theValue(isMobileNumber) should] equal:theValue(NO)];
        });

        it(@"isIdentityCardNumber", ^{
            BOOL  isIdentityCardNumber = [DentistToolBox isIdentityCardNumber: @"12344243322"];
            [[theValue(isIdentityCardNumber) should] equal:theValue(NO)];
        });

        it(@"isIdentityHKCardNumber", ^{
            BOOL isIdentityHKCardNumber = [DentistToolBox isIdentityHKCardNumber: @"1234"];
            [[theValue(isIdentityHKCardNumber) should] equal:theValue(NO)];
        });

        it(@"isConformSXPassword", ^{
            BOOL isConformSXPassword = [DentistToolBox isConformSXPassword: @"1234"];
            [[theValue(isConformSXPassword) should] equal:theValue(NO)];
        });

        it(@"isPassportNumber", ^{
            BOOL isPassportNumber = [DentistToolBox isPassportNumber: @"1234"];
            [[theValue(isPassportNumber) should] equal:theValue(NO)];
        });

        it(@"sizeWithText", ^{
            CGSize sizeWithText = [DentistToolBox sizeWithText:@"a" font:[UIFont systemFontOfSize:10] maxSize:CGSizeMake(100, 100)];
            [[theValue(sizeWithText) should] equal:theValue(CGSizeMake(5.634765625, 11.93359375))];
        });

        it(@"deleteFailureZero", ^{
            NSString *str = [DentistToolBox deleteFailureZero: @".1234"];
            [[str should] equal:@".1234"];
        });

        it(@"lengthForText", ^{
            int length = [DentistToolBox lengthForText:@"123"];
            [[theValue(length) should] equal:theValue(3)];
        });

        it(@"currentTimes", ^{
            NSDate *date = [NSDate date];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateStyle:NSDateFormatterMediumStyle];
            [formatter setTimeStyle:NSDateFormatterShortStyle];
            [formatter setDateFormat:@"YYYY-MM-dd"];
            NSString *DateTime = [formatter stringFromDate:date];
            NSString *time = [DentistToolBox currentTime];
            [[DateTime should] equal:time];
        });
    });
});
SPEC_END
