//
//  YHPopMenuView.m
//  PikeWay
//
//  Created by samuelandkevin on 16/10/25.
//  Copyright © 2016年 YHSoft. All rights reserved.
//

#import "YHPopMenuView.h"
#import "common.h"
#import "UIImage+customed.h"

#define KEYWINDOW [UIApplication sharedApplication].keyWindow
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface CellForMenuItem : UITableViewCell
@property (nonatomic,strong) UIImageView *imgvIcon;
@property (nonatomic,strong) UILabel *lbName;
@property (nonatomic,strong) UIView *viewBotLine;
@property (nonatomic,strong) NSDictionary *dictConfig;//cell的配置参数

@end

static const CGFloat kIconW = 16;       //图标宽(默认宽高相等)
static const CGFloat kFontSize = 14.0f; //字体大小

static const CGFloat kItemNameRightSpace = 15;//itemName又边距
static const CGFloat kIconRightSpace = 15;    //icon又边距离



@implementation CellForMenuItem

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier config:(NSDictionary *)config{
    if (self = [self initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
         self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setup{
    self.imgvIcon = [UIImageView new];
    [self.contentView addSubview:self.imgvIcon];
    
    self.lbName = [UILabel new];
    self.lbName.font = [UIFont systemFontOfSize:14.0f];
    self.lbName.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.lbName];
    
    self.viewBotLine = [UIView new];
    self.viewBotLine.backgroundColor = UIColor.lightGrayColor;
    [self.contentView addSubview:self.viewBotLine];
    
    [self layoutUI];
}

- (void)layoutUI{
    WeakSelf
    [_imgvIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.contentView.mas_right).offset(-10);
        make.centerY.equalTo(weakSelf.contentView.mas_centerY);
        make.width.height.mas_equalTo(21);

    }];
    
    [_lbName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.imgvIcon.mas_right).offset(-10);
        make.centerY.equalTo(weakSelf.contentView.mas_centerY);
        make.left.equalTo(weakSelf.contentView.mas_left).offset(10);
    }];
    
    [_viewBotLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(weakSelf.contentView);
        make.height.mas_equalTo(0.5);
    }];
    
}

- (void)setDictConfig:(NSDictionary *)dictConfig{
    _dictConfig = dictConfig;
  
    CGFloat fontSize =  [_dictConfig[@"fontSize"] floatValue];
    fontSize = fontSize?fontSize:kFontSize;
    self.lbName.font = [UIFont systemFontOfSize:fontSize];
    
    UIColor *itemBgColor = _dictConfig[@"itemBgColor"];
    itemBgColor = itemBgColor?itemBgColor:UIColor.whiteColor;
    self.backgroundColor = itemBgColor;
    
    UIColor *fontColor = _dictConfig[@"fontColor"];
    self.lbName.textColor = fontColor;
    CGFloat alpha=[_dictConfig[@"alpha"] floatValue];
    self.lbName.alpha=alpha;
    self.imgvIcon.alpha=alpha;
    
    [self updateUI];
}

- (void)updateUI{
    
    CGFloat iconW = [_dictConfig[@"iconW"] floatValue];
    iconW = iconW?iconW:kIconW;
    
    
    CGFloat iconRightSpace = [_dictConfig[@"iconRightSpace"] floatValue];
    iconRightSpace = iconRightSpace?iconRightSpace:kIconRightSpace;
    
    CGFloat itemNameRightSpace = [_dictConfig[@"itemNameRightSpace"] floatValue];
    itemNameRightSpace = itemNameRightSpace?itemNameRightSpace:kItemNameRightSpace;
    

    WeakSelf
    [_imgvIcon mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.contentView.mas_right).offset(-iconRightSpace);
        make.centerY.equalTo(weakSelf.contentView.mas_centerY);
        make.width.height.mas_equalTo(iconW);
    }];
    
    [_lbName mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.imgvIcon.mas_right).offset(-itemNameRightSpace);
        make.centerY.equalTo(weakSelf.contentView.mas_centerY);
        make.left.equalTo(weakSelf.contentView.mas_left).offset(itemNameRightSpace);
    }];
    
}

@end


@interface YHPopMenuView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIView *viewBG;
@property (nonatomic,strong) NSDictionary *config;
@property (nonatomic,strong) NSDictionary *grayconfig;
@property (nonatomic,assign) CGFloat menuViewX;
@property (nonatomic,assign) CGFloat menuViewY;
@property (nonatomic,assign) CGFloat menuViewW;
@property (nonatomic,assign) CGFloat menuViewH;

@property (nonatomic,copy)   DismissBlock dBlock;

@end

static const CGFloat kItemH = 44.0f;//item高度

@implementation YHPopMenuView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _menuViewX = frame.origin.x;
        _menuViewY = frame.origin.y;
        _menuViewW = frame.size.width;
        _menuViewH = frame.size.height;

        [self setup];
    }
    return self;
}

- (void)setup{
    
    UIView *viewBG = [UIView new];
    UITapGestureRecognizer *tapViewBG =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onViewBG:)];
    UISwipeGestureRecognizer *swipViewBG = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(onViewBG:)];
    UIPanGestureRecognizer *panViewBG = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onViewBG:)];
    
    [viewBG addGestureRecognizer:tapViewBG];
    [viewBG addGestureRecognizer:swipViewBG];
    [viewBG addGestureRecognizer:panViewBG];
    [self addSubview:viewBG];
    _viewBG = viewBG;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.delegate   = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.bounces = NO;
    [tableView registerClass:[CellForMenuItem class] forCellReuseIdentifier:NSStringFromClass([CellForMenuItem class])];
    [self addSubview:tableView];
    _tableView = tableView;
    
    [self layoutUI];
    
    [self addShadowToView:tableView withColor:UIColor.lightGrayColor];
}

/// 添加单边阴影效果
- (void)addShadowToView:(UIView *)theView withColor:(UIColor *)theColor {
    theView.layer.shadowColor = theColor.CGColor;
    theView.layer.shadowOffset = CGSizeMake(-1,1);
    theView.layer.shadowOpacity = 0.5;
    theView.layer.shadowRadius = 2;
    theView.layer.masksToBounds = NO;

}

- (void)layoutUI{
    WeakSelf
    _tableView.layer.anchorPoint = CGPointMake(1, 0);
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(weakSelf.menuViewX+(weakSelf.tableView.layer.anchorPoint.x-0.5)*weakSelf.menuViewW);
        make.top.equalTo(weakSelf).offset(weakSelf.menuViewY+(weakSelf.tableView.layer.anchorPoint.y-0.5)*weakSelf.menuViewH);
        make.width.mas_equalTo(0);
        make.height.mas_equalTo(0);
    }];
    
    [_viewBG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.right.equalTo(weakSelf);
    }];
}

#pragma mark - Lazy Load
- (NSArray *)itemNameArray{
    if (!_itemNameArray) {
        _itemNameArray = [NSArray new];
    }
    return _itemNameArray;
}

- (NSArray *)iconNameArray{
    if (!_iconNameArray) {
        _iconNameArray = [NSArray new];
    }
    return _iconNameArray;
}

-(void)updateIcon:(NSString *)iconname atIndex:(NSInteger)atindex
{
    if (_iconNameArray && _iconNameArray.count>atindex) {
        NSMutableArray *temparray=[NSMutableArray arrayWithArray:_iconNameArray];
        [temparray replaceObjectAtIndex:atindex withObject:iconname];
        _iconNameArray=[temparray copy];
        [self.tableView reloadData];
    }
}

- (NSDictionary *)config{
    if (!_config) {
        _itemBgColor = _itemBgColor?_itemBgColor:UIColor.whiteColor;
        _fontColor = _fontColor?_fontColor:[UIColor blackColor];
        _config = @{
                    @"iconW":@(_iconW),
                    @"fontSize":@(_fontSize),
                    @"fontColor":_fontColor,
                    @"itemBgColor":_itemBgColor,
                    @"itemNameLeftSpace":@(_itemNameRightSpace),
                    @"iconRightSpace":@(_iconRightSpace),
                    @"itemH":@(_itemH),
                    @"alpha":@(1.0)
                    };
        
        _itemH = _itemH? _itemH :kItemH;
        self.tableView.rowHeight = _itemH;
    }
    return _config;
}

- (NSDictionary *)grayconfig{
    if (!_grayconfig) {
        _itemBgColor = _itemBgColor?_itemBgColor:UIColor.whiteColor;
        _fontColor = _fontColor?_fontColor:[UIColor blackColor];
        _grayconfig = @{
                    @"iconW":@(_iconW),
                    @"fontSize":@(_fontSize),
                    @"fontColor":_fontColor,
                    @"itemBgColor":_itemBgColor,
                    @"itemNameLeftSpace":@(_itemNameRightSpace),
                    @"iconRightSpace":@(_iconRightSpace),
                    @"itemH":@(_itemH),
                    @"alpha":@(0.4)
                    };
        
        _itemH = _itemH? _itemH :kItemH;
        self.tableView.rowHeight = _itemH;
    }
    return _grayconfig;
}

-(void)setNonEnableArray:(NSArray *)NonEnableArray
{
    _NonEnableArray=NonEnableArray;
    [self.tableView reloadData];
}


#pragma mark - Public
- (void)dismissHandler:(DismissBlock)handler{
    _dBlock = handler;
}

- (void)show{
    
    CGFloat viewBGH = _canTouchTabbar? SCREEN_HEIGHT-64-44:SCREEN_HEIGHT-64;
    self.frame = CGRectMake(0, 64, SCREEN_WIDTH, viewBGH);
    [KEYWINDOW addSubview:self];
    
    //显示PopView动画
    self.tableView.alpha = 1;
    self.tableView.contentOffset = CGPointZero;
    WeakSelf
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [weakSelf.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(weakSelf.menuViewW);
            make.height.mas_equalTo(weakSelf.menuViewH);
        }];
       
      
        weakSelf.tableView.transform = CGAffineTransformMakeScale(0.01, 0.01);
        [UIView animateWithDuration:0.2f animations:^{
            weakSelf.tableView.alpha = 1.0f;
            weakSelf.tableView.transform = CGAffineTransformMakeScale(1, 1);
        } completion:^(BOOL finished) {
            weakSelf.isShowing = YES;
        }];
        
    });


   
}

- (void)hide{
    
    self.tableView.contentOffset = CGPointZero;
    WeakSelf
    [UIView animateWithDuration:0.2 animations:^{
        weakSelf.tableView.alpha = 0;
        weakSelf.tableView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    } completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
         weakSelf.isShowing = NO;
    }];
    
}

- (void)reloadData{
    [self.tableView reloadData];
}

#pragma mark - Life
- (void)dealloc{
//    NSLog(@"%s 销毁",__func__);
}

#pragma mark - Gesture
- (void)onViewBG:(id)sender{
    if (_dBlock) {
        _dBlock(YES,-1);
    }
    [self hide];
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CellForMenuItem *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CellForMenuItem class])];

    if (indexPath.row < self.iconNameArray.count) {
        NSString *iconName = self.iconNameArray[indexPath.row];
        cell.imgvIcon.image = [UIImage imageNamed:iconName];
    }
    
    if (indexPath.row < self.itemNameArray.count) {
        cell.lbName.text = self.itemNameArray[indexPath.row];
    }
    
    if (indexPath.row == self.itemNameArray.count - 1) {
        cell.viewBotLine.hidden = YES;
    }else{
        cell.viewBotLine.hidden = NO;
    }
    if (_NonEnableArray && [_NonEnableArray containsObject:@(indexPath.row)]) {
        cell.dictConfig = self.grayconfig;
    }else{
        cell.dictConfig = self.config;
    }
    
    return cell;

}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.itemNameArray.count;
}


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_NonEnableArray && [_NonEnableArray containsObject:@(indexPath.row)]) {
        
    }else{
        if (_dBlock) {
            _dBlock(NO,indexPath.row);
        }
        [self hide];
    }
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
