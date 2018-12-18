//
//  CareerMeViewController.m
//  dentist
//
//  Created by feng zhenrong on 2018/12/18.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "CareerMeViewController.h"
#import "Proto.h"
#import "CareerMeTableViewCell.h"
#import "UIViewController+myextend.h"

@interface CareerMeViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *myTable;
    UIImageView *headerImg;
    UIButton *editBtn;
}
@end

@implementation CareerMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = rgb255(246, 245, 245);
    UINavigationItem *item = self.navigationItem;
    item.title = @"ME";
    item.leftBarButtonItem = [self navBarImage:@"back_arrow" target:self action:@selector(onBack)];
    // Do any additional setup after loading the view.
    
    CGFloat _topBarH = 0;
    CGFloat _bottomBarH = 0;
    if (self.navigationController != nil) {
        _topBarH = NAVHEIGHT;
    }
    if (self.tabBarController != nil) {
        _bottomBarH = TABLEBAR_HEIGHT;
    }
    
    myTable = [UITableView new];
    myTable.backgroundColor=[UIColor clearColor];
    [self.view addSubview:myTable];
    myTable.separatorStyle=UITableViewCellSeparatorStyleNone;
    myTable.dataSource = self;
    myTable.delegate = self;
    myTable.tableHeaderView=[self makeHeaderView];
    [[[[myTable.layoutMaker widthEq:SCREENWIDTH] topParent:_topBarH] bottomParent:-_bottomBarH] install];
//    [myTable registerClass:[CareerMeTableViewCell class] forCellReuseIdentifier:NSStringFromClass([CareerMeTableViewCell class])];
}

- (void)onBack
{
    NSArray *viewcontrollers=self.navigationController.viewControllers;
    if (viewcontrollers.count>1) {
        if ([viewcontrollers objectAtIndex:viewcontrollers.count-1]==self) {
            //push方式
            [self.navigationController popViewControllerAnimated:NO];
        }
    }
    else{
        //present方式
        [self dismissViewControllerAnimated:NO completion:nil];
    }
    
}

- (UIView *)makeHeaderView {
    UIView *panel = [UIView new];
    panel.frame = makeRect(0, 0, SCREENWIDTH, 200);
    panel.backgroundColor=[UIColor clearColor];
    headerImg = [UIImageView new];
    
    headerImg.imageName = @"default_avatar";
    [panel addSubview:headerImg];
    [[[[headerImg.layoutMaker sizeEq:100 h:100] topParent:44] centerXParent:0] install];
    
    editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [editBtn setImage:[UIImage imageNamed:@"edit_photo"] forState:UIControlStateNormal];
    [panel addSubview:editBtn];
    [[[[editBtn.layoutMaker sizeEq:38 h:38] toRightOf:headerImg offset:-19] below:headerImg offset:-19] install];
    return panel;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = @"careermetablecell";
    CareerMeTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.backgroundColor=[UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (!cell) {
        cell = [[CareerMeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
//    CareerMeTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CareerMeTableViewCell class]) forIndexPath:indexPath];
    if (indexPath.row==0) {
        cell.headerView.image=[UIImage imageNamed:@"user_img"];
        cell.titleLabel.text=@"Dr.Stephen Wood";
        cell.desLabel.text=@"Profile";
    }else if (indexPath.row==1) {
        cell.headerView.image=[UIImage imageNamed:@"icons8-submit_resume"];
        cell.titleLabel.text=@"Resume";
        cell.desLabel.text=@"No uploaded resume";
        cell.lineLabel.hidden=YES;
    }
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
