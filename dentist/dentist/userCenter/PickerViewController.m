//
//  PickerViewController.m
//  dentist
//
//  Created by Jacksun on 2018/9/5.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "PickerViewController.h"

@interface PickerViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>
{
    UIPickerView *picker;
}
@end

@implementation PickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    UIView *alphaView = [[UIView alloc] initWithFrame:self.view.frame];
    UIView *baseView = [[UIView alloc] initWithFrame:self.view.frame];
    alphaView.backgroundColor = [UIColor clearColor];
    baseView.backgroundColor = [UIColor blackColor];
    baseView.alpha = 0.4;
    [self.view addSubview:baseView];
    [self.view addSubview:alphaView];
    
    [self initPicker];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBackground)];
    [self.view addGestureRecognizer:tap];
    
    // Do any additional setup after loading the view.
}

- (void)tapBackground
{
    [self hidePicker];
}

- (void)showPicker
{
    [UIView animateWithDuration:.6 animations:^{
        
        self->picker.frame = CGRectMake(0, SCREENHEIGHT - 216, SCREENWIDTH, 216);
        
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hidePicker
{
    [UIView animateWithDuration:.3 animations:^{
        
        self->picker.frame = CGRectMake(0, SCREENHEIGHT, SCREENWIDTH, 216);
        
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

- (void)initPicker
{
    picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT, SCREENWIDTH, 216)];
    picker.backgroundColor = [UIColor whiteColor];
    picker.delegate = self;
    picker.dataSource = self;
    [self.view addSubview:picker];
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

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSLog(@"%@",_infoArr[row]);
    self.pickerSelectBlock(_infoArr[row]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
