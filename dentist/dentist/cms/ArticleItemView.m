//
// Created by entaoyang on 2018/9/18.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "ArticleItemView.h"
#import "Common.h"
#import "Article.h"


@implementation ArticleItemView {
	UILabel *typeLabel;
	UILabel *dateLabel;
	UILabel *titleLabel;
	UILabel *contentLabel;
	UIImageView *imageView;
	UIButton *markButton;
	UIButton *moreButton;
}

- (instancetype)init {
	self = [super init];


	contentLabel = [self addLabel];
	contentLabel.font = [Fonts regular:15];
	[contentLabel textColorMain];
	[[[[[contentLabel.layoutMaker centerXParent:0] leftParent:0] rightParent:0] heightEq:60] install];


	return self;
}


-(void) bind:(Article*)item {
	contentLabel.text = item.content;
}
@end