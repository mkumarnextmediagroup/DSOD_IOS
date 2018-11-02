//
// Created by entaoyang on 2018/9/8.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "ListPage.h"
#import "Common.h"
#import "DentistPickerView.h"
#import "Proto.h"
#import "IdName.h"

@interface ListPage () <UITableViewDataSource, UITableViewDelegate,UITextFieldDelegate> {
    BOOL isHasEmtyView;
}
@property (nonatomic,strong) UIView *emtyView;
@property (nonatomic,strong) NSArray<IdName *> *categoryArray;
@property (nonatomic,strong) UIActivityIndicatorView *iv;
@end

@implementation ListPage {
	NSArray *_items;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	

	self.automaticallyAdjustsScrollViewInsets = NO;

    _table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
	if (@available(iOS 11.0, *)) {
		_table.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
	}
	[self.view addSubview:_table];

	_table.dataSource = self;
	_table.delegate = self;
	_table.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self setTableViewFrame];
    UINavigationItem *item = [self navigationItem];
    if (self.iv == nil) {
        self.iv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        self.iv.tag = 998;
        self.iv.backgroundColor = [UIColor clearColor];
        self.iv.center = item.rightBarButtonItem.customView.center;
    }
    item.rightBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:self.iv];
    self.iv.hidden=YES;
    
    

}

-(void)setTableViewFrame
{
    CGFloat _topBarH = 0;
    CGFloat _bottomBarH = 0;
    if (self.navigationController != nil) {
        _topBarH = NAVHEIGHT;
    }
    if (self.tabBarController != nil) {
        _bottomBarH = TABLEBAR_HEIGHT;
    }
    [[[[[[_table layoutMaker] leftParent:0] rightParent:0] topParent: self.topOffset + _topBarH] bottomParent:-(self.bottomOffset + _bottomBarH)] install];
}

-(void)setIsRefresh:(BOOL)isRefresh
{
    _isRefresh=isRefresh;
    if (_isRefresh) {
        [self setupRefresh];
    }
}

//MARK: 下拉刷新
- (void)setupRefresh {
    NSLog(@"setupRefresh -- 下拉刷新");
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refreshClick:) forControlEvents:UIControlEventValueChanged];
    [self.table addSubview:refreshControl];
    [refreshControl beginRefreshing];
    [self refreshClick:refreshControl];
}

//MARK: 下拉刷新触发,在此获取数据
- (void)refreshClick:(UIRefreshControl *)refreshControl {
    NSLog(@"refreshClick: -- 刷新触发");
    [self refreshData];
    [refreshControl endRefreshing];
}

- (void)showIndicator {
    [self.iv stopAnimating];
    self.iv.hidden = NO;
    [self.iv startAnimating];
}

- (void)hideIndicator {
    self.iv.hidden = YES;
    [self.iv stopAnimating];
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
    CGFloat _topBarH = 0;
    CGFloat _bottomBarH = 0;
    if (self.navigationController != nil) {
        _topBarH = NAVHEIGHT;
    }
    if (self.tabBarController != nil) {
        _bottomBarH = TABLEBAR_HEIGHT;
    }
    UIImage* image = [UIImage imageNamed:imageName];
    NSString* text = title;
    
    _emtyView = [UIView new];
    _emtyView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_emtyView];
    _emtyView.hidden=YES;
    [[[[[[_emtyView layoutMaker] leftParent:0] rightParent:0] topParent:self.topOffset + _topBarH] bottomParent:-(self.bottomOffset + _bottomBarH)] install];
    CGFloat imageh=80;
    CGFloat spaceh=30;
    if (imageName) {
        CGFloat imagew=(image.size.width/image.size.height)*imageh;
        UIImageView *carImageView =[UIImageView new];
        [carImageView setImage:image];
        [_emtyView addSubview:carImageView];
        [[[[[carImageView layoutMaker] centerXOf:_emtyView offset:0] centerYOf:_emtyView offset:-imageh] sizeEq:imagew h:imageh] install];
        
    }
    
    if (title) {
        UILabel *noLabel = [UILabel new];
        noLabel.textAlignment = NSTextAlignmentCenter;
        [noLabel textColorMain];
        noLabel.font = [Fonts regular:15];
        noLabel.textColor=Colors.textMain;
        noLabel.text = text;
        noLabel.backgroundColor = [UIColor clearColor];
        noLabel.numberOfLines=0;
        [_emtyView addSubview:noLabel];
         [[[[[[noLabel layoutMaker] leftParent:0] rightParent:0] centerYOf:_emtyView offset:spaceh*2] heightEq:80] install];
    }
    
    
}

-(void)addEmptyFilterViewWithImageName:(NSString*)imageName title:(NSString*)title filterAction:(EmptyFilterViewActionBlock)filterActionBlock
{
    isHasEmtyView=YES;
    self.filterBlock = filterActionBlock;
    CGFloat _topBarH = 0;
    CGFloat _bottomBarH = 0;
    if (self.navigationController != nil) {
        _topBarH = NAVHEIGHT;
    }
    if (self.tabBarController != nil) {
        _bottomBarH = TABLEBAR_HEIGHT;
    }
    UIImage* image = [UIImage imageNamed:imageName];
    NSString* text = title;
    
    _emtyView = [UIView new];
    _emtyView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_emtyView];
    _emtyView.hidden=YES;
    [[[[[[_emtyView layoutMaker] leftParent:0] rightParent:0] topParent:self.topOffset + _topBarH] bottomParent:-(self.bottomOffset + _bottomBarH)] install];
    
    //category
    UILabel *categoryLabel=[_emtyView addLabel];
    categoryLabel.font = [Fonts regular:12];
    categoryLabel.textColor=Colors.textAlternate;
    categoryLabel.text=localStr(@"Select a Category");
    [[[[[categoryLabel.layoutMaker leftParent:20] topParent:20] rightParent:-10] heightEq:20] install];
    UITextField *categoryTextField=_emtyView.addEditRounded;
    categoryTextField.delegate = self;
    categoryTextField.hint = localStr(@"DSOs");
    categoryTextField.tag=1;
    [categoryTextField returnNext];
    categoryTextField.font = [Fonts regular:15];
    categoryTextField.textColor=rgb255(0, 0, 0);
    [categoryTextField setValue:rgb255(0, 0, 0) forKeyPath:@"_placeholderLabel.textColor"];
    [[[[[categoryTextField.layoutMaker leftParent:20] below:categoryLabel offset:10] rightParent:-20] heightEq:44] install];
    UIImage *img=[UIImage imageNamed:@"arrow"];
    UIImageView *selectimageview=[UIImageView new];
    [categoryTextField addSubview:selectimageview];
    selectimageview.image=[UIImage imageWithCGImage:img.CGImage scale:1.0 orientation:UIImageOrientationRight];
    [[[[[selectimageview.layoutMaker rightParent:-14] topParent:14] heightEq:16] widthEq:16] install];
    
    CGFloat imageh=80;
    //CGFloat spaceh=30;
    CGFloat imagew=(image.size.width/image.size.height)*imageh;
    UIImageView *carImageView =[UIImageView new];
    [carImageView setImage:image];
    [_emtyView addSubview:carImageView];
    [[[[[carImageView layoutMaker] centerXOf:_emtyView offset:0] below:categoryTextField offset:30] sizeEq:imagew h:imageh] install];
    
    if (title) {
        UILabel *noLabel = [UILabel new];
        noLabel.textAlignment = NSTextAlignmentCenter;
        [noLabel textColorMain];
        noLabel.font = [Fonts regular:15];
        noLabel.textColor=Colors.textMain;
        noLabel.text = text;
        noLabel.backgroundColor = [UIColor clearColor];
        noLabel.numberOfLines=0;
        [_emtyView addSubview:noLabel];
        [[[[[[noLabel layoutMaker] leftParent:0] rightParent:0] below:carImageView offset:40] heightEq:80] install];
    }
    
    
}

#pragma mark textfielddelegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField.tag==1) {
        DentistPickerView *picker = [[DentistPickerView alloc]init];
        picker.arrayDic=self.categoryArray;
        picker.leftTitle=localStr(@"Category");
        picker.righTtitle=localStr(@"Cancel");
        [picker show:^(NSString *result,NSString *resultname) {
            
        } rightAction:^(NSString *result,NSString *resultname) {
            
        } selectAction:^(NSString *result,NSString *resultname) {
            textField.text=resultname;
            if (self.filterBlock) {
                self.filterBlock(result,resultname);
            }
        }];
        [picker showIndicator];
        [Proto queryCategoryTypes:^(NSArray<IdName *> *array) {
            if (!self.categoryArray) {
                self.categoryArray = array;
            }
            foreTask(^() {
                [picker hideIndicator];
                picker.arrayDic=self.categoryArray;
            });
        }];
        
        
       
    }
    return NO;
}

@end
