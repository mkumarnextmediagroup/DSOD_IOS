//
//  CustomPicker.m
//  dentist
//
//  Created by Jacksun on 2018/9/4.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "CustomPicker.h"

@interface CustomPicker()<UIPickerViewDelegate,UIPickerViewDataSource>
@end

@implementation CustomPicker

- (void)initPicker
{
    UIPickerView *picker = [[UIPickerView alloc] init];
    picker.delegate = self;
    picker.dataSource = self;
    [self addSubview:picker];
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
