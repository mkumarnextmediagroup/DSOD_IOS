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

	NSInteger edge = 16;

	UIView *topView = self.addView;
	topView.backgroundColor = rgb255(250, 251, 253);
	[[[[[topView.layoutMaker topParent:0] leftParent:0] rightParent:0] heightEq:40] install];
	typeLabel = [topView addLabel];
	typeLabel.font = [Fonts semiBold:12];
	[typeLabel textColorMain];
	[[[[[typeLabel.layoutMaker centerYParent:0] leftParent:edge] heightEq:24] rightParent:-90] install];

	dateLabel = [topView addLabel];
	[dateLabel textAlignRight];
	dateLabel.font = [Fonts regular:12];
	[dateLabel textColorAlternate];
	[[[[[dateLabel.layoutMaker centerYParent:0] rightParent:-edge] heightEq:24] widthEq:74] install];

	imageView = self.addImageView;
	[imageView scaleFillAspect];
	[[[[[imageView.layoutMaker leftParent:0] rightParent:0] below:topView offset:0] heightEq:187] install];

	moreButton = [self addButton];
	[moreButton setImage:[UIImage imageNamed:@"dot3.png"] forState:UIControlStateNormal];
	[[[[moreButton.layoutMaker rightParent:-edge] below:imageView offset:edge] sizeEq:20 h:20] install];

	markButton = [self addButton];
	[markButton setImage:[UIImage imageNamed:@"book9"] forState:UIControlStateNormal];
	[[[[markButton.layoutMaker toLeftOf:moreButton offset:-8] below:imageView offset:edge] sizeEq:20 h:20] install];

	titleLabel = [self addLabel];
	titleLabel.font = [Fonts semiBold:20];
	[titleLabel textColorMain];
	titleLabel.numberOfLines = 0;
//	[[[[[titleLabel.layoutMaker leftParent:edge] rightParent:-64] below:imageView offset:10] heightEq:24] install];
	[[[[[titleLabel.layoutMaker leftParent:edge] rightParent:-64] below:imageView offset:10] bottomParent:-107] install];

	contentLabel = [self addLabel];
	contentLabel.font = [Fonts regular:15];
	[contentLabel textColorMain];
	[[[[[contentLabel.layoutMaker leftParent:edge] rightParent:-edge] heightEq:80] bottomParent:-12] install];

	return self;
}


- (void)bind:(Article *)item {
	typeLabel.text = [item.type uppercaseString];
	dateLabel.text = item.publishDate;
	titleLabel.text = item.title;
	contentLabel.text = item.content;
	[imageView loadUrl:item.resImage placeholderImage:@"art-img"];
}
@end