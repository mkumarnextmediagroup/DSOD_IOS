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
    
    CGFloat selfWidth=self.frame.size.width-12;
    _leftLab=[[UILabel alloc]initWithFrame:CGRectMake(6, 0, selfWidth*3/4, self.frame.size.height)];
    _leftLab.textAlignment=NSTextAlignmentCenter;
    _leftLab.font=[UIFont systemFontOfSize:14];
    [self addSubview:_leftLab];
    
    _selectBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    [_selectBtn setImage:[UIImage imageNamed:@"icon_check_mark_small"] forState:UIControlStateNormal];
    _selectBtn.userInteractionEnabled=NO;
    _selectBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    [self addSubview:_selectBtn];
    
    
}

-(void)setItemText:(NSString*)text  isSelect:(BOOL)isSelect{
    CGSize size = [self sizeWithText:text font:[UIFont systemFontOfSize:14] maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    _leftLab.frame = CGRectMake((self.frame.size.width-size.width)/2, 0 , size.width, self.frame.size.height);
    _leftLab.text = text;
    _leftLab.textColor = isSelect ? rgbHex(0x879AA8) : rgbHex(0xB7B8B9);
    
    _selectBtn.frame = CGRectMake(self.frame.size.width-38, (self.frame.size.height-20)/2, 20, 20);
    _selectBtn.hidden = !isSelect;
    

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
