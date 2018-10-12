//
// Created by entaoyang on 2018/9/8.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "ListPage.h"
#import "Common.h"


@interface ListPage () <UITableViewDataSource, UITableViewDelegate> {
    BOOL isHasEmtyView;
}
@property (nonatomic,strong) UIView *emtyView;
@end

@implementation ListPage {
	NSArray *_items;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	CGFloat _topBarH = 0;
	CGFloat _bottomBarH = 0;
	if (self.navigationController != nil) {
		_topBarH = NAVHEIGHT;
	}
	if (self.tabBarController != nil) {
		_bottomBarH = TABLEBAR_HEIGHT;
	}

	self.automaticallyAdjustsScrollViewInsets = NO;


	_table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
	if (@available(iOS 11.0, *)) {
		_table.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
	}
	[self.view addSubview:_table];

	_table.dataSource = self;
	_table.delegate = self;
	_table.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
	[[[[[[_table layoutMaker] leftParent:0] rightParent:0] topParent:self.topOffset + _topBarH] bottomParent:-(self.bottomOffset + _bottomBarH)] install];

}


- (NSArray *)items {
	return _items;
}

- (void)setItems:(NSArray *)items {
	_items = items;
    if (isHasEmtyView) {
        if (_items && _items.count>0) {
            _emtyView.hidden=YES;
        }else{
            _emtyView.hidden=NO;
        }
    }else{
        _emtyView.hidden=YES;
    }
    
	if (_table != nil) {
		[_table reloadData];
	}
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 0.01f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSObject *item = _items[(NSUInteger) indexPath.row];
	UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
	[self onClickItem3:item cell:cell indexPath:indexPath];
	[self onClickItem:item];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSObject *item = _items[(NSUInteger) indexPath.row];
	return [self heightOfItem:item];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if (_items == nil) {
		return 0;
	}
	return _items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSObject *item = _items[(NSUInteger) indexPath.row];
	Class viewCls = [self viewClassOfItem:item];
	NSString *viewClsName = NSStringFromClass(viewCls);
	UITableViewCell *cell = [_table dequeueReusableCellWithIdentifier:viewClsName];
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:viewClsName];
		UIView *v = (UIView *) [[viewCls alloc] init];
		[cell.contentView addSubview:v];
		[[[[[[v layoutMaker] leftParent:0] rightParent:0] topParent:0] bottomParent:0] install];
		[self onConfigCell:item cell:cell];
	}
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
	UIView *itemView = cell.contentView.subviews[0];
	[self onBindItem3:item view:itemView cell:cell];
	[self onBindItem:item view:itemView];
	return cell;
}


- (Class)viewClassOfItem:(NSObject *)item {
	return UILabel.class;
}

- (CGFloat)heightOfItem:(NSObject *)item {
	return 48;
}

- (void)onBindItem:(NSObject *)item view:(UIView *)view {
	if ([view isKindOfClass:UILabel.class]) {
		((UILabel *) view).text = [item description];
	}
}

- (void)onBindItem3:(NSObject *)item view:(UIView *)view cell:(UITableViewCell *)cell {

}


- (void)onConfigCell:(NSObject *)item cell:(UITableViewCell *)cell {

}

- (void)onClickItem:(NSObject *)item {
}

- (void)onClickItem3:(NSObject *)item cell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath {

}

#pragma mark --添加空页面
-(void)addEmptyViewWithImageName:(NSString*)imageName title:(NSString*)title
{
    isHasEmtyView=YES;
    CGRect frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    UIImage* image = [UIImage imageNamed:imageName];
    NSString* text = title;
    
    _emtyView = [[UIView alloc] initWithFrame:frame];
    _emtyView.backgroundColor = [UIColor whiteColor];
    CGFloat imageh=80;
    CGFloat spaceh=30;
    if (imageName) {
        CGFloat imagew=(image.size.width/image.size.height)*imageh;
        UIImageView *carImageView = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width-imagew)/2, frame.size.height/2-imageh-spaceh, imagew, imageh)];
        [carImageView setImage:image];
        [_emtyView addSubview:carImageView];
    }
    
    if (title) {
        UILabel *noLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height/2+spaceh, self.view.frame.size.width, 80)];
        noLabel.textAlignment = NSTextAlignmentCenter;
        [noLabel textColorMain];
        noLabel.font = [Fonts regular:15];
        noLabel.textColor=Colors.textMain;
        noLabel.text = text;
        noLabel.backgroundColor = [UIColor clearColor];
        noLabel.numberOfLines=0;
        [_emtyView addSubview:noLabel];
    }
    
    [self.view addSubview:_emtyView];
    _emtyView.hidden=YES;
    
}
@end
