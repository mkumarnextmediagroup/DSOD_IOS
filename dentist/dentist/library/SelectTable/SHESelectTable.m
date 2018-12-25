//
//  SHESelectTable.m
//  breeder
//
//

#import "SHESelectTable.h"
#import "SHESelectCell.h"

@implementation SHESelectTable{
    UIView *bottomLine;
    UIView *leftLine;
    UIView *rightLine;
    UIView *tableViewBgView;
}

-(instancetype)initWithFrame:(CGRect)frame withDataArray:(NSArray *)dataArray
{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        [self creatView];
        datArray=dataArray;

        self.cellType = CellTypeChecked;
        selectIndex = 0;
    }
    return self;
}
/*点击任意一处 消失*/
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismiss];
}
- (void)dismiss{
    [UIView animateWithDuration:0.2 animations:^{
        self->tableViewBgView.alpha=0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

-(void)show{
    
    [self.selTable reloadData];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:0.2 animations:^{
        self->tableViewBgView.alpha=1;
    }];
}


-(void)setSelectIndex:(NSInteger)index{
    selectIndex = index;
}

-(void)showWithFrame:(CGRect)tableFrame{
    self.selTable.frame = CGRectMake(0, 0, tableFrame.size.width, tableFrame.size.height);

    tableViewBgView.frame = tableFrame;
    bottomLine.frame =  CGRectMake(0,tableFrame.size.height, tableFrame.size.width, 1);
    leftLine.frame = CGRectMake(0,0, 1, tableFrame.size.height);
    rightLine.frame = CGRectMake(tableFrame.size.width,0, 1, tableFrame.size.height);
    
    [self show];
}


-(void)addShadowToView:(UIView *)theView withSize:(CGSize)size{
    [self addShadowToView:theView withSize:size withColor:UIColor.blackColor];
}

-(void)addShadowToView:(UIView *)theView withSize:(CGSize)size withColor:(UIColor *)theColor {
    theView.layer.shadowColor = theColor.CGColor;
    theView.layer.shadowOffset = size;
    theView.layer.shadowOpacity = 0.9;
    theView.layer.shadowRadius = 5;
}



-(void)creatView
{
    tableViewBgView = [UIView new];
    tableViewBgView.clipsToBounds = NO;
    [self addSubview:tableViewBgView];
    
    bottomLine = [[UIView alloc]initWithFrame:CGRectZero];
    bottomLine.backgroundColor = UIColor.whiteColor;
    [tableViewBgView addSubview:bottomLine];
    [self addShadowToView:bottomLine withSize:CGSizeMake(0, 3)];
    
    leftLine = [[UIView alloc]initWithFrame:CGRectZero];
    leftLine.backgroundColor = UIColor.whiteColor;
    [tableViewBgView addSubview:leftLine];
    [self addShadowToView:leftLine withSize:CGSizeMake(-3, 0)];
    
    
    rightLine = [[UIView alloc]initWithFrame:CGRectZero];
    rightLine.backgroundColor = UIColor.whiteColor;
    [tableViewBgView addSubview:rightLine];
    [self addShadowToView:rightLine withSize:CGSizeMake(3, 0)];
    
    _selTable=[self creatTableViewWithCGRect:CGRectZero withView:tableViewBgView];
    _selTable.delegate=self;
    _selTable.dataSource=self;
    _selTable.bounces=NO;
    _selTable.clipsToBounds = NO;
    _selTable.backgroundColor=[UIColor clearColor];
    [_selTable registerClass:[SHESelectCell class] forCellReuseIdentifier:@"SHESelectCell"];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return datArray.count;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    return tableView.frame.size.height/datArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = [self tableView:tableView heightForRowAtIndexPath:indexPath];
    
    SHESelectCell *cell=[[SHESelectCell alloc]initWithFrame:CGRectMake(0, 0, self.selTable.frame.size.width, height)];
    [cell setItem:datArray[indexPath.row] cellType:self.cellType isSelect:selectIndex==indexPath.row];
    
    if (indexPath.row!=0) {
        [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
       
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectIndex = indexPath.row;
    if (_returnBlock) {
        _returnBlock(indexPath.row, datArray[indexPath.row][@"text"]);
        [self dismiss];
    }
}
-(UITableView *)creatTableViewWithCGRect:(CGRect)rect withView:(UIView *)view
{
    
    UITableView *tableView=[[UITableView alloc]initWithFrame:rect style:UITableViewStylePlain];
    tableView.backgroundColor=[UIColor whiteColor];
    tableView.showsVerticalScrollIndicator=NO;
    tableView.separatorColor=[UIColor clearColor];
    tableView.keyboardDismissMode=UIScrollViewKeyboardDismissModeOnDrag;
    tableView.estimatedRowHeight = 0;
    tableView.estimatedSectionFooterHeight = 0;
    tableView.estimatedSectionHeaderHeight = 0;
    [view addSubview:tableView];
    
    return tableView;
}



@end
