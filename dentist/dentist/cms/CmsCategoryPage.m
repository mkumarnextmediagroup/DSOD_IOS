//
// Created by entaoyang on 2018/9/18.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "CmsCategoryPage.h"
#import "Common.h"
#import "ArticleGSkItemView.h"
#import "Proto.h"
#import "CMSDetailViewController.h"
#import "DenActionSheet.h"
#import <Social/Social.h>
#import "CMSModel.h"
#import "DentistPickerView.h"
#import "DetinstDownloadManager.h"
#import "IdName.h"
#import "DsoToast.h"

@interface CmsCategoryPage()<ArticleItemViewDelegate>
{
    NSInteger selectIndex;
    NSArray *dataArray;
    BOOL isdownrefresh;
}
@end
@implementation CmsCategoryPage {

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UINavigationItem *item = [self navigationItem];
    item.title = @"CATEGORY";
    self.table.rowHeight = UITableViewAutomaticDimension;
    self.table.estimatedRowHeight = 400;
    self.isRefresh=YES;
    //    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    //    [self addEmptyFilterViewWithImageName:@"nonBookmarks" title:@"Search by category" selectId:self->type filterAction:^(NSString *result,NSString *resultname) {
    //        self->type=result;
    //        [self showIndicator];
    //        [Proto queryAllContentsByCategoryType2:self->type skip:0 completed:^(NSArray<CMSModel *> *array,NSString *categoryType) {
    //            foreTask(^() {
    //                [self hideIndicator];
    //                if ([self->type isEqualToString:categoryType]) {
    //                   self.items=array;
    //                }
    //            });
    //        }];
    //    }];
    [self addEmptyFiledViewWithImageName:@"nonBookmarks" title:@"Search by category" textFiledBlock:^(UITextField *textFiled) {
        [self handleTextFieldBlock:textFiled];
    }];
    self.items = nil;
}

- (void) handleTextFieldBlock: (UITextField *) textField {
    __block NSInteger index;
    DentistPickerView *picker = [[DentistPickerView alloc]init];
    picker.leftTitle=localStr(@"Category");
    picker.righTtitle=localStr(@"Cancel");
    [picker show:^(NSString *result,NSString *resultname) {}
     rightAction:^(NSString *result,NSString *resultname) {}
    selectAction:^(NSString *result,NSString *resultname) {
        self->_type=result;
        if (picker.arrayDic) {
            [picker.arrayDic enumerateObjectsUsingBlock:^(IdName * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj.id isEqualToString:self->_type]) {
                    index=idx;
                    *stop = YES;
                }
            }];
            if (picker.arrayDic.count>index) {
                foreTask(^{
                    IdName *categorymodel=[picker.arrayDic objectAtIndex:index];
                    textField.text=categorymodel.name;
                });
            }
        }
        [self showIndicator];
        [Proto queryAllContentsByCategoryType2:self->_type skip:0 completed:^(NSArray<CMSModel *> *array,NSString *categoryType) {
            foreTask(^() {
                [self hideIndicator];
                if ([self->_type isEqualToString:categoryType]) { self.items=array; }
            });
        }];
    }];
    [Proto queryCategoryTypes:^(NSArray<IdName *> *array) {
        foreTask(^() {
            picker.arrayDic=array;
            picker.selectId=self->_type;
        });
    }];
}

- (Class)viewClassOfItem:(NSObject *)item {
    return ArticleGSkItemView.class;
}

- (CGFloat)heightOfItem:(NSObject *)item {
    //    return 430;
    return UITableViewAutomaticDimension;
}

- (void)onBindItem:(NSObject *)item view:(UIView *)view {
    //    Article *art = (id) item;
    //    ArticleItemView *itemView = (ArticleItemView *) view;
    //    itemView.delegate=self;
    //    itemView.moreButton.tag=art.id;
    //    [itemView.moreButton addTarget:self action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    //    [itemView bind:art];
    //    CMSModel *model = (id) item;
    //    ArticleItemView *itemView = (ArticleItemView *) view;
    //    itemView.delegate=self;
    ////    itemView.moreButton.tag=1;//;
    ////    [itemView.moreButton addTarget:self action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    //    [itemView bindCMS:model];
    
    CMSModel *model = (id) item;
    ArticleGSkItemView *itemView = (ArticleGSkItemView *) view;
    itemView.delegate=self;
    [itemView bindCMS:model];
}

-(void)refreshData
{
    if (_type) {
        [self showIndicator];
        [Proto queryAllContentsByCategoryType:self->_type skip:0 completed:^(NSArray<CMSModel *> *array) {
            foreTask(^() {
                [self hideIndicator];
                self.items=array;
            });
        }];
    }
    
}

//click more button
//- (void)moreBtnClick:(UIButton *)btn
//{
//    NSArray *imgArr = [NSArray arrayWithObjects:@"downLoadIcon",@"shareIcon", nil];
//    DenActionSheet *denSheet = [[DenActionSheet alloc] initWithDelegate:self title:nil cancelButton:nil imageArr:imgArr otherTitle:@"Download",@"Share", nil];
//    [denSheet show];
//}

-(void)ArticleMoreActionModel:(CMSModel *)model
{
    _selectModel=model;
    NSLog(@"ArticleMoreAction=%@",model.id);
    NSArray *imgArr = [NSArray arrayWithObjects:@"downLoadIcon",@"shareIcon", nil];
    DenActionSheet *denSheet = [[DenActionSheet alloc] initWithDelegate:self title:nil cancelButton:nil imageArr:imgArr otherTitle:@"Download",@"Share", nil];
    [denSheet show];
    [[DentistDataBaseManager shareManager] CheckIsDowned:model completed:^(NSInteger isdown) {
        foreTask(^{
            if (isdown) {
                [denSheet updateActionTitle:@[@"Update",@"Share"]];
            }
        });
    }];
}

#pragma mark ---MyActionSheetDelegate
- (void)myActionSheet:(DenActionSheet *)actionSheet parentView:(UIView *)parentView subLabel:(UILabel *)subLabel index:(NSInteger)index
{
    switch (index) {
            case 0://---click the Download button
        {
            NSLog(@"download click");
            if (_selectModel) {
                UIView *dsontoastview=[DsoToast toastViewForMessage:@"Download is Add…" ishowActivity:YES];
                [self.navigationController.view showToast:dsontoastview duration:1.0 position:CSToastPositionBottom completion:nil];
                [[DetinstDownloadManager shareManager] startDownLoadCMSModel:_selectModel addCompletion:^(BOOL result) {
                } completed:^(BOOL result) {
                }];
            }
        }
            break;
            case 1://---click the Share button
        {
            NSLog(@"Share click");
            if (_selectModel) {
                NSString *urlstr=@"";
                NSString *title=[NSString stringWithFormat:@"%@",_selectModel.title];
                NSString* type = _selectModel.featuredMedia[@"type"];
                if([type isEqualToString:@"1"] ){
                    //pic
                    NSDictionary *codeDic = _selectModel.featuredMedia[@"code"];
                    urlstr = codeDic[@"thumbnailUrl"];
                }else{
                    urlstr = _selectModel.featuredMedia[@"code"];
                }
                NSString *someid=_selectModel.id;
                if (![NSString isBlankString:urlstr]) {
                    dispatch_async(dispatch_get_global_queue(0, 0), ^{
                        NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlstr]];
                        UIImage *image = [UIImage imageWithData:data];
                        if (image) {
                            NSURL *shareurl = [NSURL URLWithString:getShareUrl(@"content", someid)];
                            NSArray *activityItems = @[shareurl,title,image];
                            
                            UIActivityViewController *avc = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];
                            [self presentViewController:avc animated:YES completion:nil];
                        }
                    });
                }else{
                    NSURL *shareurl = [NSURL URLWithString:getShareUrl(@"content", someid)];
                    NSArray *activityItems = @[shareurl,title];
                    
                    UIActivityViewController *avc = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];
                    [self presentViewController:avc animated:YES completion:nil];
                }
                
            }else{
                NSString *msg=@"";
                msg=@"error";
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:msg preferredStyle:UIAlertControllerStyleAlert];
                
                [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                    NSLog(@"点击取消");
                }]];
                [self presentViewController:alertController animated:YES completion:nil];
            }
        }
            break;
        default:
            break;
    }
}

- (void)onClickItem:(NSObject *)item {
    //    CMSDetailViewController *newVC = [[CMSDetailViewController alloc] init];
    //    newVC.articleInfo = (Article *) item;
    //    if ([newVC.articleInfo.category isEqualToString:@"VIDEOS"]) {
    //        newVC.toWhichPage = @"mo";
    //    }else
    //    {
    //        newVC.toWhichPage = @"pic";
    //    }
    //    [self.navigationController pushViewController:newVC animated:YES];
    UIViewController *viewController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    CMSDetailViewController *newVC = [[CMSDetailViewController alloc] init];
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:newVC];
    CMSModel *article = (CMSModel *) item;
    newVC.contentId = article.id;
    if ([article.categoryName isEqualToString:@"VIDEOS"]) {
        newVC.toWhichPage = @"mo";
    }else
    {
        newVC.toWhichPage = @"pic";
    }
    newVC.cmsmodelsArray=self.items;
    [viewController presentViewController:navVC animated:YES completion:NULL];
}


-(void)CategoryPickerSelectAction:(NSString *)categoryId categoryName:(nonnull NSString *)categoryName
{
    DentistPickerView *picker = [[DentistPickerView alloc]init];
    
    picker.leftTitle=localStr(@"Category");
    picker.righTtitle=localStr(@"Cancel");
    [picker show:^(NSString *result,NSString *resultname) {
    } rightAction:^(NSString *result,NSString *resultname) {
    } selectAction:^(NSString *result,NSString *resultname) {
        self->_type=result;
        [self showIndicator];
        [Proto queryAllContentsByCategoryType:result skip:0 completed:^(NSArray<CMSModel *> *array) {
            foreTask(^() {
                [self hideIndicator];
                self.items=array;
            });
        }];
    }];
    [Proto queryCategoryTypes:^(NSArray<IdName *> *array) {
        foreTask(^() {
            picker.arrayDic=array;
            picker.selectId=self->_type;
        });
    }];
}

-(void)ArticleMarkActionView:(NSObject *)item view:(UIView *)view
{
    CMSModel *model = (id) item;
    if(model.isBookmark){
        //删除
        UIView *dsontoastview=[DsoToast toastViewForMessage:@"Remove from bookmarks……" ishowActivity:YES];
        [self.navigationController.view showToast:dsontoastview duration:30.0 position:CSToastPositionBottom completion:nil];
        [Proto deleteBookmarkByEmailAndContentId:getLastAccount() contentId:model.id completed:^(HttpResult *result) {
            foreTask(^() {
                [self.navigationController.view hideToast];
                if (result.OK) {
                    //
                    model.isBookmark=NO;
                    ArticleGSkItemView *itemView = (ArticleGSkItemView *) view;
                    [itemView updateBookmarkStatus:NO];
                }else{
                    NSString *message=result.msg;
                    if([NSString isBlankString:message]){
                        message=@"Failed";
                    }
                    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
                    [window makeToast:message
                             duration:1.0
                             position:CSToastPositionBottom];
                    [self.navigationController popViewControllerAnimated:YES];
                }
            });
        }];
    }else{
        //添加
        UIView *dsontoastview=[DsoToast toastViewForMessage:@"Saving to bookmarks…" ishowActivity:YES];
        [self.navigationController.view showToast:dsontoastview duration:30.0 position:CSToastPositionBottom completion:nil];
        [Proto addBookmark:getLastAccount() cmsmodel:model completed:^(HttpResult *result) {
            foreTask(^() {
                [self.navigationController.view hideToast];
                if (result.OK) {
                    //
                    model.isBookmark=YES;
                    ArticleGSkItemView *itemView = (ArticleGSkItemView *) view;
                    [itemView updateBookmarkStatus:YES];
                }else{
                    if(result.code==2033){
                        model.isBookmark=YES;
                        ArticleGSkItemView *itemView = (ArticleGSkItemView *) view;
                        [itemView updateBookmarkStatus:YES];
                    }else{
                        NSString *message=result.msg;
                        if([NSString isBlankString:message]){
                            message=@"Failed";
                        }
                        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
                        [window makeToast:message
                                 duration:1.0
                                 position:CSToastPositionBottom];
                        [self.navigationController popViewControllerAnimated:YES];
                    }
                    
                }
            });
        }];
    }
    
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat height = scrollView.frame.size.height;
    CGFloat contentOffsetY = scrollView.contentOffset.y;
    CGFloat bottomOffset = scrollView.contentSize.height - contentOffsetY;
    if (bottomOffset <= height-50)
    {
        if (!isdownrefresh) {
            isdownrefresh=YES;
            //在最底部
            [self showIndicator];
            [Proto queryAllContentsByCategoryType:self->_type skip:self.items.count completed:^(NSArray<CMSModel *> *array) {
                self->isdownrefresh=NO;
                foreTask(^() {
                    [self hideIndicator];
                    if(array && array.count>0){
                        NSMutableArray *newarray=[NSMutableArray arrayWithArray:self.items];
                        [newarray addObjectsFromArray:array];
                        self.items=[newarray copy];
                    }
                });
            }];
        }
        
    }
}

@end
