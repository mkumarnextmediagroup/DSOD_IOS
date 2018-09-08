//
// Created by entaoyang on 2018/9/8.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "TestPage.h"


@implementation TestPage {

}
- (void)viewDidLoad {
	[super viewDidLoad];
	self.listDelegate = self;
	self.items = @[@"Yang", @"Entao"];


}

-(void)onClickItem:(NSObject *)item {
	NSLog(@"click %@", item );
}

- (Class)viewClassOfItem:(NSObject *)item {
	return [UILabel class];
}

- (CGFloat)heightOfItem:(NSObject *)item {
	return 80;
}

- (void)onBindItem:(NSObject *)item view:(UIView *)view {
	UILabel *lb = (UILabel *) view;
	NSString *v = (NSString *) item;
	lb.text = v;
	NSLog(@"Bind %@", v);
}

- (void)onConfigCell:(NSObject *)item cell:(UITableViewCell *)cell {
	NSString *v = (NSString *) item;
	if ([v isEqualToString:@"Yang"]) {
		cell.indentationLevel = 8;
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
	cell.selectionStyle = UITableViewCellSelectionStyleNone;

}

@end