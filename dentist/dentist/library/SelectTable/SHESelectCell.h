//
//  SHESelectCell.h
//  breeder
//
//

#import <UIKit/UIKit.h>

@interface SHESelectCell : UITableViewCell
@property(nonatomic,strong)UILabel *leftLab;
@property(nonatomic,strong)UIButton *selectBtn;

-(void)setItemText:(NSString*)text isSelect:(BOOL)isSelect;
@end
