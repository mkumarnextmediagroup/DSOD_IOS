//
// Created by entaoyang on 2018/9/9.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "BaseItemView.h"
#import "Common.h"

@interface BaseItemView()
{
}
@property(readonly) UILabel *titleLabel;
@property(readonly) UIImageView *iconView;
@property(readonly) BOOL isCustom;
@end

@implementation BaseItemView {
}
- (instancetype)init {
	self = [super init];
	self.layoutParam.height = 76;
	return self;
}

- (void)resetLayout {
//    if(_isCustom){
//        CGSize sz = [_msgLabel sizeThatFits:makeSize(310, 1000)];
//        [[_msgLabel.layoutUpdate heightEq:sz.height] install];
//        self.layoutParam.height = 78 + (sz.height - 25);
//    }
}

- (UIImageView *)addArrowView {
	UIImageView *iconView = self.addImageView;
	iconView.imageName = @"arrow_small";
	[iconView alignCenter];
	return iconView;
}

-(void)addItemSubView:(UIView *)subview titleName:(NSString *)titleName imageName:(NSString *)imageName
{
    _isCustom=YES;
    Padding *p = self.padding;
    p.left = 16;
    p.right = 16;
    p.top = 16;
    p.bottom = 13;
    self.layoutParam.height = 78;
    
    self.backgroundColor = UIColor.whiteColor;
    _titleLabel = self.addLabel;
    _titleLabel.text=titleName;
    [_titleLabel itemTitleStyle];
    _iconView = self.addImageView;
    
    [[[[[_titleLabel.layoutMaker heightEq:14] leftParent:p.left] rightParent:-p.right] topParent:p.top] install];
    if (imageName) {
        _iconView.imageName = imageName;
        [[[[_iconView.layoutMaker sizeEq:16 h:16] rightParent:-p.right] bottomParent:-p.bottom - 5] install];
        [[[[[subview.layoutMaker heightEq:25] leftParent:p.left] bottomParent:-p.bottom] toLeftOf:_iconView offset:-20] install];
    }else{
        [[[[_iconView.layoutMaker sizeEq:0 h:0] rightParent:-p.right] bottomParent:-p.bottom - 5] install];
        [[[[[subview.layoutMaker heightEq:25] leftParent:p.left] bottomParent:-p.bottom] rightParent:-p.right] install];
    }
    
    
}

@end
