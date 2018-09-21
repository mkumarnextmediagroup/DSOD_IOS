//
// Created by entaoyang on 2018/9/18.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "CmsSearchPage.h"
#import "Common.h"

@implementation CmsSearchPage {

}

- (void)viewDidLoad {
	[super viewDidLoad];

    UITextField *searchEdit = [self.navigationController.view addEditSearch];
    searchEdit.delegate = self;
    [[[[searchEdit.layoutMaker leftParent:16] topParent:22] sizeEq:SCREENWIDTH - 95 h:EDIT_HEIGHT] install];

	UINavigationItem *item = [self navigationItem];
    item.rightBarButtonItem = [self navBarText:@"Cancel" target:self action:@selector(cancelBtnClick:)];
    item.leftBarButtonItem = [self navBarText:@"" target:self action:@selector(cancelBtnClick:)];

//    [self buildView];
}

- (void)buildView
{
    UIView *bgVi = [UIView new];
    bgVi.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgVi];
    [[[[[bgVi.layoutMaker topParent:260] leftParent:0] rightParent:0] heightEq:250] install];
    
    
    UIImageView *img = [bgVi addImageView];
    img.image = [UIImage imageNamed:@"nonSearch"];
    [[[img.layoutMaker topParent:0] leftParent:SCREENWIDTH/2-41] sizeEq:82 h:92];
    
    UILabel *noticeLab = [bgVi addLabel];
    noticeLab.numberOfLines = 0;
    noticeLab.textColor = rgb255(74, 74, 74);
    noticeLab.font = [Fonts semiBold:16];
    noticeLab.text = localStr(@"searchBy");
    [[[[noticeLab.layoutMaker sizeEq:186 h:70] leftParent:SCREENWIDTH/2 - 93] topParent:250-70] install];
    

}

- (void)cancelBtnClick:(UIButton *)btn
{
    
}

@end
