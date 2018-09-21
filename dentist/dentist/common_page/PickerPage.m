//
// Created by entaoyang on 2018/9/11.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "PickerPage.h"
#import "Common.h"
#import "NSDate+myextend.h"


@interface PickerPage () <UIPickerViewDataSource, UIPickerViewDelegate> {
}
@end

@implementation PickerPage {
	UIPickerView *picker;
	NSMutableArray *result;
    NSInteger yearNow;
    NSInteger monthNow;
}
- (instancetype)init {
	self = [super init];
	self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	self.view.backgroundColor = rgba255(0, 0, 0, 100);

    yearNow = [[NSDate date] year];
    monthNow = [[NSDate date] month];
    
	picker = [UIPickerView new];
	picker.backgroundColor = [UIColor whiteColor];
	[self.view addSubview:picker];
	[[[[[picker.layoutMaker heightEq:216] leftParent:0] rightParent:0] bottomParent:0] install];

	picker.delegate = self;
	picker.dataSource = self;
    
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBackground)];
	[self.view addGestureRecognizer:tap];

	result = [NSMutableArray arrayWithCapacity:self.data.count];
	for (NSArray *item in self.data) {
		[result addObject:item[0]];
	}
	if (self.preSelectData != nil) {
		NSUInteger size = self.preSelectData.count;
		if (size > result.count) {
			size = result.count;
		}
		for (NSUInteger i = 0; i < size; ++i) {
			NSObject *v = self.preSelectData[i];
			if ([self.data[i] containsObject:v]) {
				result[i] = v;
			}
		}
	}
	for (NSUInteger i = 0; i < result.count; ++i) {
		NSInteger r = [self.data[i] indexOfObject:result[i]];
		if (r != NSNotFound) {
			[picker selectRow:r inComponent:i animated:NO];
		} else {
			result[i] = self.data[i][0];
			[picker selectRow:0 inComponent:i animated:NO];
		}
	}

}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];

}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return self.data.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	return self.data[(NSUInteger) component].count;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	NSObject *item = self.showArr[(NSUInteger) component][(NSUInteger) row];
	if (self.displayBlock) {
		return self.displayBlock(item);
	}
	return [item description];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    NSInteger selYear = 0;
    NSInteger selMonth = 0;
    NSInteger yearIndex = 0;

    for (int i = 0; i < self.data[1].count; i++) {
        if ([self.data[1][i] integerValue] == yearNow) {
            yearIndex = i;
        }
    }
	result[(NSUInteger) component] = self.data[(NSUInteger) component][(NSUInteger) row];
    for (int i = 0; i < result.count; i++) {
        selMonth = [result[0] integerValue];
        selYear = [result[1] integerValue];
    }
    if (component == 0) {
        if (selMonth >= monthNow && selYear >= yearNow) {
            [picker selectRow:monthNow - 1 inComponent:0 animated:YES];
            result[(NSUInteger) component] = self.data[0][(NSUInteger) monthNow - 1];
        }
    }
    if (component == 1) {
        if (selYear >= yearNow) {
            [picker selectRow:yearIndex inComponent:1 animated:YES];
            result[(NSUInteger) component] = self.data[1][(NSUInteger) yearIndex];
        }
    }
    
}


- (void)tapBackground {
	if (self.resultCallback) {
		self.resultCallback(result);
	}
	[UIView animateWithDuration:.2 animations:^{
        self->picker.frame = CGRectMake(0, SCREENHEIGHT, SCREENWIDTH, 216);
	}                completion:^(BOOL finished) {
		[self dismissViewControllerAnimated:YES completion:nil];
	}];
}


+ (PickerPage *)pickYearMonth:(NSInteger)yearFrom yearTo:(NSInteger)yearTo {
	PickerPage *p = [PickerPage new];
	NSArray *mArr = @[@1, @2, @3, @4, @5, @6, @7, @8, @9, @10, @11, @12];
    NSArray *monthArr = [NSArray arrayWithObjects:@"Jaunary",@"February",@"March",@"April",@"May",@"June",@"July",@"August",@"September",@"October",@"November",@"December", nil];

	NSMutableArray *yearArr = [NSMutableArray arrayWithCapacity:60];
	for (NSInteger n = yearFrom; n <= yearTo; ++n) {
		[yearArr addObject:@(n)];
	}
	p.data = @[mArr, yearArr];
    p.showArr = @[monthArr,yearArr];
	return p;
}

+ (PickerPage *)pickYearMonthFromNowDownTo:(NSInteger)yearTo {
	PickerPage *p = [PickerPage new];
	NSArray *mArr = @[@1, @2, @3, @4, @5, @6, @7, @8, @9, @10, @11, @12];
    NSArray *monthArr = [NSArray arrayWithObjects:@"Jaunary",@"February",@"March",@"April",@"May",@"June",@"July",@"August",@"September",@"October",@"November",@"December", nil];
	NSMutableArray *yearArr = [NSMutableArray arrayWithCapacity:60];

    NSInteger yearNow = [[NSDate date] year];
	for (NSInteger n = yearNow; n >= yearTo; --n) {
		[yearArr addObject:@(n)];
	}
	p.data = @[mArr, yearArr];
    p.showArr = @[monthArr,yearArr];
	return p;
}

@end
