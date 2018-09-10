//
// Created by entaoyang on 2018/9/10.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupItem.h"
#import "BaseController.h"


typedef NSString *(^DisplayBlock)(NSObject *);

typedef BOOL (^FilterBlock)(NSObject *, NSString *);

@interface GroupListPage : BaseController {

}


//table offset top
@property CGFloat topOffset;
//table offset bottom
@property CGFloat bottomOffset;

@property BOOL withIndexBar;
@property BOOL withGroupLabel;
@property(readonly) UITableView *table;
@property NSArray<GroupItem *> *items;

@property FilterBlock filterBlock;
@property DisplayBlock displayBlock;


- (void)setItemsPlain:(NSArray *)arr displayBlock:(DisplayBlock)displayBlock;

- (void)filterBy:(NSString *)text;

- (Class)viewClassOfItem:(NSObject *)item;

- (CGFloat)heightOfItem:(NSObject *)item;

- (void)onBindItem:(NSObject *)item view:(UIView *)view;

- (void)onClickItem:(NSObject *)item;

- (void)onClickItem3:(NSObject *)item cell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath;


- (void)onConfigCell:(NSObject *)item cell:(UITableViewCell *)cell;

- (void)onBindItem3:(NSObject *)item view:(UIView *)view cell:(UITableViewCell *)cell;


@end