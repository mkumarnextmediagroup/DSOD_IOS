//
//  SHESelectCell.m
//  breeder
//
//

#import "SHESelectCell.h"
#import "Common.h"

@implementation SHESelectCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        [self buildViews];
    }
    return self;
}

-(void)buildViews{
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    self.backgroundColor=[UIColor whiteColor];
    
    _leftLab=[[UILabel alloc]initWithFrame:CGRectMake(30, 0, self.frame.size.width - 70, self.frame.size.height)];
    _leftLab.textAlignment=NSTextAlignmentLeft;
    _leftLab.font=[UIFont systemFontOfSize:14];
    [self addSubview:_leftLab];
    
    _selectBtn=[[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width-40, (self.frame.size.height-20)/2, 20, 20)];
    [_selectBtn setImage:[UIImage imageNamed:@"icon_check_mark_small"] forState:UIControlStateNormal];
    _selectBtn.userInteractionEnabled=NO;
    _selectBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    [self addSubview:_selectBtn];
    
    
}

-(void)setItem:(NSDictionary*)dic cellType:(CellType)cellType isSelect:(BOOL)isSelect{
//    CGSize size = [self sizeWithText:text font:[UIFont systemFontOfSize:14] maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
//    _leftLab.frame = CGRectMake((self.frame.size.width-size.width)/2, 0 , size.width, self.frame.size.height);
    _leftLab.text = dic[@"text"];
    _leftLab.textColor = isSelect ? rgbHex(0x879AA8) : rgbHex(0xB7B8B9);
    
    if(cellType == CellTypeChecked){
        [_selectBtn setImage:[UIImage imageNamed:@"icon_check_mark_small"] forState:UIControlStateNormal];
        _selectBtn.hidden = !isSelect;
    }else if(cellType == CellTypeCustomIcon){
        [_selectBtn setImage:[UIImage imageNamed:dic[@"icon"]] forState:UIControlStateNormal];
        _selectBtn.hidden = NO;
    }
    
    

}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
