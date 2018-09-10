//
// Created by entaoyang on 2018/9/11.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "DatePickerPage.h"
#import "Common.h"

@implementation DatePickerPage {
	UIDatePicker *picker;
}

- (instancetype)init {
	self = [super init];
	_datePickerMode = UIDatePickerModeDate;
	self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	self.view.backgroundColor = rgba255(0, 0, 0, 100);

	picker = [UIDatePicker new];
	picker.backgroundColor = [UIColor whiteColor];
	picker.datePickerMode = self.datePickerMode;
	[self.view addSubview:picker];
	[[[[[picker.layoutMaker heightEq:216] leftParent:0] rightParent:0] bottomParent:0] install];


	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBackground)];
	[self.view addGestureRecognizer:tap];

	[picker addTarget:self action:@selector(onChange:) forControlEvents:UIControlEventValueChanged];
}

- (void)tapBackground {
	if (self.dateCallback) {
		self.dateCallback(self.date);
	}
	[UIView animateWithDuration:.2 animations:^{
		picker.frame = CGRectMake(0, SCREENHEIGHT, SCREENWIDTH, 216);
	}                completion:^(BOOL finished) {
		[self dismissViewControllerAnimated:YES completion:nil];
	}];
}

- (void)onChange:(id)sender {
	Log(picker.date);
	self.date = picker.date;
}

@end