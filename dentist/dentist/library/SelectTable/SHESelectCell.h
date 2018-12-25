//
//  SHESelectCell.h
//  breeder
//
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,CellType){
    CellTypeChecked,
    CellTypeCustomIcon,
};

@interface SHESelectCell : UITableViewCell
@property(nonatomic,strong)UILabel *leftLab;
@property(nonatomic,strong)UIButton *selectBtn;

-(void)setItem:(NSDictionary*)dic cellType:(CellType)cellType isSelect:(BOOL)isSelect;

@end
