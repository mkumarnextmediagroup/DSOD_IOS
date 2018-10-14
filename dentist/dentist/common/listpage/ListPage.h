//
// Created by entaoyang on 2018/9/8.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^EmptyFilterViewActionBlock) (NSString *result);
@interface ListPage : UIViewController

//table offset top
@property CGFloat topOffset;
//table offset bottom
@property CGFloat bottomOffset;

@property(readonly) UITableView *table;
@property NSArray<NSObject *> *items;
/** Filterblock */
@property (copy, nonatomic) EmptyFilterViewActionBlock filterBlock;


- (Class)viewClassOfItem:(NSObject *)item;

- (CGFloat)heightOfItem:(NSObject *)item;

- (void)onBindItem:(NSObject *)item view:(UIView *)view;

- (void)onClickItem:(NSObject *)item;

- (void)onClickItem3:(NSObject *)item cell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath;


- (void)onConfigCell:(NSObject *)item cell:(UITableViewCell *)cell;

- (void)onBindItem3:(NSObject *)item view:(UIView *)view cell:(UITableViewCell *)cell;

-(void)addEmptyViewWithImageName:(NSString*)imageName title:(NSString*)title;
-(void)addEmptyFilterViewWithImageName:(NSString*)imageName title:(NSString*)title filterAction:(EmptyFilterViewActionBlock)filterActionBlock;
@end
