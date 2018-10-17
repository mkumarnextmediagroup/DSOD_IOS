//
//  BookMarkItemView.m
//  dentist
//
//  Created by cstLBY on 2018/9/19.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "BookMarkItemView.h"
#import "Common.h"
#import "Article.h"

@implementation BookMarkItemView{
    UILabel *titleLabel;
    UILabel *contentLabel;
    UIImageView *imageView;
    UIButton *markButton;
}

- (instancetype)init {
    self = [super init];
    
    NSInteger edge = 16;
    imageView = self.addImageView;
    [[[[imageView.layoutMaker leftParent:edge]topParent:20] sizeEq:110 h:110] install];
    
    markButton = [self addButton];
    [markButton setImage:[UIImage imageNamed:@"book9-light"] forState:UIControlStateNormal];
    [markButton addTarget:self action:@selector(markAction:) forControlEvents:UIControlEventTouchUpInside];
    [[[[markButton.layoutMaker rightParent:-edge] topParent:20] sizeEq:20 h:20] install];
    
    titleLabel = [self addLabel];
    titleLabel.font = [Fonts semiBold:12];
    titleLabel.textColor=Colors.textMain;
    titleLabel.numberOfLines = 0;
    [[[[[titleLabel.layoutMaker toRightOf:imageView offset:15] topOf:imageView offset:5] toLeftOf:markButton offset:-20] heightEq:20] install];

    contentLabel = [self addLabel];
    contentLabel.font = [Fonts semiBold:15];
    contentLabel.textColor=Colors.textContent;
    contentLabel.numberOfLines = 0;

    [[[[[contentLabel.layoutMaker toRightOf:imageView offset:15] below:titleLabel offset:10] toLeftOf:markButton offset:-20] bottomOf:imageView offset:0] install];
    
    return self;
}

- (void)bind:(Article *)item {
    _model=item;
    titleLabel.text = item.title;
    contentLabel.text = item.content;
    [imageView loadUrl:item.resImage placeholderImage:@"art-img"];
    [imageView scaleFillAspect];
    imageView.clipsToBounds=YES;
}

-(void)markAction:(UIButton *)sender
{
    if (_model.isBookmark) {
        [markButton setImage:[UIImage imageNamed:@"book9"] forState:UIControlStateNormal];
    }else{
        [markButton setImage:[UIImage imageNamed:@"book9-light"] forState:UIControlStateNormal];
    }
    if(self.delegate && [self.delegate respondsToSelector:@selector(BookMarkAction:)]){
        [self.delegate BookMarkAction:_model.id];
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
