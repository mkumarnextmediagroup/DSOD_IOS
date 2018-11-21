//
//  UITextFieldExtTests.m
//  dentistTests
//
//  Created by Su Ho V. on 11/16/18.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "Common.h"
#import "UITextField+styled.h"
#import "MyStyle.h"

SPEC_BEGIN(UITextFieldExtTests)

describe(@"Unit Test For Text Field Extension", ^{
    __block UITextField *tf;

    beforeEach(^{
        tf = [UITextField new];
    });

    context(@"Methods", ^{
        it(@"styleRounded", ^{
            [tf styleRounded];
            [[theValue(tf.style.style) should] equal:theValue(EDIT_STYLE_ROUNDED)];
            [[theValue(tf.style.subStyle) should] equal:theValue(EDIT_SUBSTYLE_NONE)];
            [[theValue(tf.style.theme) should] equal:theValue(EDIT_THEME_NORMAL)];
        });

        it(@"styleRoundedGray", ^{
            [tf styleRoundedGray];
            [[theValue(tf.style.style) should] equal:theValue(EDIT_STYLE_ROUNDED)];
            [[theValue(tf.style.subStyle) should] equal:theValue(EDIT_SUBSTYLE_GRAY)];
            [[theValue(tf.style.theme) should] equal:theValue(EDIT_THEME_NORMAL)];
        });

        it(@"styleLined", ^{
            [tf styleLined];
            [[theValue(tf.style.style) should] equal:theValue(EDIT_STYLE_LINED)];
            [[theValue(tf.style.subStyle) should] equal:theValue(EDIT_SUBSTYLE_NONE)];
            [[theValue(tf.style.theme) should] equal:theValue(EDIT_THEME_NORMAL)];
        });

        it(@"styleLined without Layer", ^{
            tf.layer.sublayers = NULL;
            [tf styleLined];
            [[theValue(tf.style.style) should] equal:theValue(EDIT_STYLE_LINED)];
            [[theValue(tf.style.subStyle) should] equal:theValue(EDIT_SUBSTYLE_NONE)];
            [[theValue(tf.style.theme) should] equal:theValue(EDIT_THEME_NORMAL)];
        });

        it(@"stylePassword", ^{
            [tf stylePassword];
            [[theValue(tf.style.style) should] equal:theValue(EDIT_STYLE_ROUNDED)];
            [[theValue(tf.style.subStyle) should] equal:theValue(EDIT_SUBSTYLE_PWD)];
            [[theValue(tf.style.theme) should] equal:theValue(EDIT_THEME_NORMAL)];
        });

        it(@"styleSearch", ^{
            [tf styleSearch];
            [[theValue(tf.style.style) should] equal:theValue(EDIT_STYLE_ROUNDED)];
            [[theValue(tf.style.subStyle) should] equal:theValue(EDIT_SUBSTYLE_SEARCH)];
            [[theValue(tf.style.theme) should] equal:theValue(EDIT_THEME_NORMAL)];
            [[theValue(tf.font.pointSize) should] equal:theValue(15)];
            [[tf.placeholder should] equal:@"Search ..."];
        });

        it(@"themeSuccess", ^{
            [tf themeSuccess];
            [[theValue(tf.style.theme) should] equal:theValue(EDIT_THEME_SUCCESS)];
        });

        it(@"themeNormal", ^{
            [tf themeNormal];
            [[theValue(tf.style.theme) should] equal:theValue(EDIT_THEME_NORMAL)];
        });

        it(@"themeActive", ^{
            [tf themeActive];
            [[theValue(tf.style.theme) should] equal:theValue(EDIT_THEME_ACTIVE)];
        });

        it(@"themeError", ^{
            [tf themeError];
            [[theValue(tf.style.theme) should] equal:theValue(EDIT_THEME_ERROR)];
        });

        it(@"themeDisabled", ^{
            [tf themeDisabled];
            [[theValue(tf.style.theme) should] equal:theValue(EDIT_THEME_DISABLED)];
        });

        it(@"textColorBlack", ^{
            [tf textColorBlack];
            [[tf.textColor should] equal:UIColor.blackColor];
        });

        it(@"textColorWhite", ^{
            [tf textColorWhite];
            [[tf.textColor should] equal:UIColor.whiteColor];
        });

        it(@"textAlignCenter", ^{
            [tf textAlignCenter];
            [[theValue(tf.textAlignment) should] equal:theValue(NSTextAlignmentCenter)];
        });

        it(@"textAlignLeft", ^{
            [tf textAlignLeft];
            [[theValue(tf.textAlignment) should] equal:theValue(NSTextAlignmentLeft)];
        });

        it(@"textAlignRight", ^{
            [tf textAlignRight];
            [[theValue(tf.textAlignment) should] equal:theValue(NSTextAlignmentRight)];
        });

        it(@"textColorMain", ^{
            [tf textColorMain];
            [[tf.textColor should] equal:Colors.textMain];
        });

        it(@"textColorAlternate", ^{
            [tf textColorAlternate];
            [[tf.textColor should] equal:Colors.textAlternate];
        });

        it(@"returnDone", ^{
            [tf returnDone];
            [[theValue(tf.returnKeyType) should] equal:theValue(UIReturnKeyDone)];
        });

        it(@"returnNext", ^{
            [tf returnNext];
            [[theValue(tf.returnKeyType) should] equal:theValue(UIReturnKeyNext)];
        });

        it(@"returnGo", ^{
            [tf returnGo];
            [[theValue(tf.returnKeyType) should] equal:theValue(UIReturnKeyGo)];
        });

        it(@"returnSearch", ^{
            [tf returnSearch];
            [[theValue(tf.returnKeyType) should] equal:theValue(UIReturnKeySearch)];
        });

        it(@"returnJoin", ^{
            [tf returnJoin];
            [[theValue(tf.returnKeyType) should] equal:theValue(UIReturnKeyJoin)];
        });

        it(@"returnDefault", ^{
            [tf returnDefault];
            [[theValue(tf.returnKeyType) should] equal:theValue(UIReturnKeyDefault)];
        });

        it(@"returnSend", ^{
            [tf returnSend];
            [[theValue(tf.returnKeyType) should] equal:theValue(UIReturnKeySend)];
        });

        it(@"returnContinue", ^{
            [tf returnContinue];
            [[theValue(tf.returnKeyType) should] equal:theValue(UIReturnKeyContinue)];
        });

        it(@"keyboardDefault", ^{
            [tf keyboardDefault];
            [[theValue(tf.keyboardType) should] equal:theValue(UIKeyboardTypeDefault)];
        });

        it(@"keyboardPhone", ^{
            [tf keyboardPhone];
            [[theValue(tf.keyboardType) should] equal:theValue(UIKeyboardTypePhonePad)];
        });

        it(@"keyboardNumber", ^{
            [tf keyboardNumber];
            [[theValue(tf.keyboardType) should] equal:theValue(UIKeyboardTypeNumberPad)];
        });

        it(@"keyboardNumberAndPun", ^{
            [tf keyboardNumberAndPun];
            [[theValue(tf.keyboardType) should] equal:theValue(UIKeyboardTypeNumbersAndPunctuation)];
        });

        it(@"keyboardUrl", ^{
            [tf keyboardUrl];
            [[theValue(tf.keyboardType) should] equal:theValue(UIKeyboardTypeURL)];
        });

        it(@"keyboardEmail", ^{
            [tf keyboardEmail];
            [[theValue(tf.keyboardType) should] equal:theValue(UIKeyboardTypeEmailAddress)];
        });

        it(@"keyboardDecimal", ^{
            [tf keyboardDecimal];
            [[theValue(tf.keyboardType) should] equal:theValue(UIKeyboardTypeDecimalPad)];
        });

        it(@"applyStyleTheme", ^{
            tf.style.style = EDIT_THEME_ERROR;
            [tf applyStyleTheme];
            [[theValue(tf.style.style) should] equal:theValue(EDIT_THEME_ERROR)];
        });

        it(@"applyLineTheme with EDIT_THEME_ACTIVE", ^{
            tf.style.theme = EDIT_THEME_ACTIVE;
            [tf applyLineTheme];
            [[theValue(tf.style.theme) should] equal:theValue(EDIT_THEME_ACTIVE)];
        });

        it(@"applyLineTheme with EDIT_THEME_DISABLED", ^{
            tf.style.theme = EDIT_THEME_DISABLED;
            [tf applyLineTheme];
            [[theValue(tf.style.theme) should] equal:theValue(EDIT_THEME_DISABLED)];
        });

        it(@"applyLineTheme with EDIT_THEME_ERROR", ^{
            tf.style.theme = EDIT_THEME_ERROR;
            [tf applyLineTheme];
            [[theValue(tf.style.theme) should] equal:theValue(EDIT_THEME_ERROR)];
        });

        it(@"applyLineTheme with EDIT_THEME_SUCCESS", ^{
            tf.style.theme = EDIT_THEME_SUCCESS;
            [tf applyLineTheme];
            [[theValue(tf.style.theme) should] equal:theValue(EDIT_THEME_SUCCESS)];
        });

        it(@"applyRoundTheme", ^{
            tf.rightView = [UIImageView new];
            [tf applyRoundTheme];
            [[tf.rightView should] beNil];
        });

        it(@"applyRoundTheme with EDIT_THEME_NORMAL", ^{
            tf.style.theme = EDIT_THEME_NORMAL;
            [tf applyRoundTheme];
            [[tf.rightView should] beNil];
        });

        it(@"applyRoundTheme with EDIT_THEME_ACTIVE", ^{
            tf.style.theme = EDIT_THEME_ACTIVE;
            [tf applyRoundTheme];
            [[tf.rightView should] beNil];
        });

        it(@"applyRoundTheme with EDIT_THEME_DISABLED", ^{
            tf.style.theme = EDIT_THEME_DISABLED;
            [tf applyRoundTheme];
            [[tf.rightView should] beNil];
        });

        it(@"applyRoundTheme with EDIT_THEME_SUCCESS", ^{
            tf.style.theme = EDIT_THEME_SUCCESS;
            [tf applyRoundTheme];
            [[tf.rightView shouldNot] beNil];
        });

        it(@"applyRoundTheme with EDIT_THEME_ERROR", ^{
            tf.style.theme = EDIT_THEME_ERROR;
            [tf applyRoundTheme];
            [[tf.rightView shouldNot] beNil];
        });

        it(@"applyRoundTheme with EDIT_THEME_ERROR and substyle", ^{
            tf.style.theme = EDIT_THEME_ERROR;
            tf.style.subStyle = EDIT_SUBSTYLE_GRAY;
            [tf applyRoundTheme];
            [[tf.rightView shouldNot] beNil];
        });

        it(@"applyRoundTheme with EDIT_STYLE_ROUNDED and substyle", ^{
            tf.style.theme = EDIT_STYLE_ROUNDED;
            tf.style.subStyle = EDIT_SUBSTYLE_GRAY;
            [tf applyRoundTheme];
            [[tf.rightView should] beNil];
        });

        it(@"_onClickPasswordRightButton with selected", ^{
            UIButton *bt = [UIButton new];
            bt.selected = TRUE;
            [tf _onClickPasswordRightButton:bt];
            [[tf.text should] equal:@""];
        });

        it(@"_onClickPasswordRightButton without selected", ^{
            UIButton *bt = [UIButton new];
            bt.selected = FALSE;
            [tf _onClickPasswordRightButton:bt];
            [[tf.text should] equal:@""];
        });
    });

    context(@"Properties", ^{
        it(@"maxLength without setter", ^{
            [[theValue(tf.maxLength) should] equal:theValue(0)];
        });

        it(@"maxLength with setter", ^{
            tf.maxLength = 10;
            [[theValue(tf.maxLength) should] equal:theValue(10)];
        });

        it(@"hint without placeholder", ^{
            [tf.hint shouldBeNil];
        });

        it(@"hint with placeholder", ^{
            NSString *string = @"Hello world";
            NSAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:string];
            tf.attributedPlaceholder = attrString;
            [[tf.hint should] equal:@"Hello world"];
        });

        it(@"setter of hint", ^{
            tf.hint = @"Hello world";
            [[tf.attributedPlaceholder.string should] equal:@"Hello world"];
        });

        it(@"textTrimed", ^{
            tf.text = @"Hello   ";
            [[tf.textTrimed should] equal:@"Hello"];
        });

        it(@"textReplace", ^{
            tf.text = @"-H-ello-";
            [[tf.textReplace should] equal:@"Hello"];
        });
    });
});

SPEC_END
