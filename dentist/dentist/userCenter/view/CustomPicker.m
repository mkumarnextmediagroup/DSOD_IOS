//
//  CustomPicker.m
//  dentist
//
//  Created by Jacksun on 2018/9/4.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "CustomPicker.h"
#import "Masonry.h"

@interface CustomPicker()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    UIPickerView *picker;
}
@end

@implementation CustomPicker

- (void)showPicker
{
    [UIView animateWithDuration:.4 animations:^{
        
    } completion:^(BOOL finished) {
        [self->picker mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.superview).offset(0);
        }];
    }];
}

- (void)hidePicker
{
    [UIView animateWithDuration:.4 animations:^{
        
    } completion:^(BOOL finished) {
        [self->picker mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.superview).offset(-216);
        }];
    }];
}

- (void)initPicker
{
    picker = [[UIPickerView alloc] init];
    picker.delegate = self;
    picker.dataSource = self;
    [self addSubview:picker];
    [[[[[picker.layoutMaker leftParent:0] rightParent:0] topParent:SCREENWIDTH-216] bottomParent:0] install];
}

#pragma mark UIPickerViewDelegate UIPickerViewDataSource

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _infoArr[row];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _infoArr.count;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
