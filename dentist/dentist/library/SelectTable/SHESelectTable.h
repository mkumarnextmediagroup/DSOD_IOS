//
//  SHESelectTable.h
//  breeder
//
//

#import <UIKit/UIKit.h>
#import "SHESelectCell.h"
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
@interface SHESelectTable : UIView<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *datArray; /*title 数据源数组*/
    CGRect tFrame;/*table 的frame*/
    NSInteger selectIndex;
}
- (instancetype)initWithFrame:(CGRect)frame withDataArray:(NSArray *)dataArray;
@property(nonatomic,strong)UITableView       *selTable;
@property(nonatomic,copy)void(^returnBlock)(NSInteger index, NSString *str);


-(void)setSelectIndex:(NSInteger)index;
-(void)showWithFrame:(CGRect)tableFrame;



@end
