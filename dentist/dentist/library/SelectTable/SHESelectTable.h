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
    NSArray<NSDictionary*> *datArray; /*数据源数组字典 key：text icon*/
    CGRect tFrame;/*table 的frame*/
    NSInteger selectIndex;
}
- (instancetype)initWithFrame:(CGRect)frame withDataArray:(NSArray *)dataArray;
@property(nonatomic,strong)UITableView       *selTable;
@property(nonatomic,copy)void(^returnBlock)(NSInteger index, NSString *str);
@property(nonatomic) CellType cellType;

-(void)setSelectIndex:(NSInteger)index;
-(void)showWithFrame:(CGRect)tableFrame;



@end
