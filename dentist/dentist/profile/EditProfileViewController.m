//
//  EditProfileViewController.m
//  dentist
//
//  Created by Jacksun on 2018/9/5.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "EditProfileViewController.h"
#import "EditHederTableViewCell.h"
#import "CommSelectTableViewCell.h"
#import "ProfileNormalTableViewCell.h"
#import "EditWriteTableViewCell.h"

@interface EditProfileViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *myTable;
}
@end

@implementation EditProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINavigationItem *item = self.navigationItem;
    item.title = localStr(@"editProfile");
    item.rightBarButtonItem = [self navBarText:@"SAVE" target:self  action:@selector(saveBtnClick:)];
    item.leftBarButtonItem = [self navBarImage:@"back_arrow"  target:self  action:@selector(back)];
    
    
    myTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    myTable.delegate = self;
    myTable.dataSource = self;
    [self.view addSubview:myTable];
    myTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [[[[[myTable.layoutMaker leftParent:0] rightParent:0] topParent:0] bottomParent:0] install];
    // Do any additional setup after loading the view.
}

#pragma mark UITableViewDelegate UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            return 200;
            break;
        case 1:
            return 76;
            break;
        case 2:
            return 78;
            break;
        case 3:
            return 78;
            break;
        case 4:
            return 78;
            break;
        case 5:
            return 72;
            break;
        default:
            break;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 2;
            break;
        case 2:
            return 1;
            break;
        case 3:
            return 1;
            break;
        case 4:
            return 2;
            break;
        case 5:
            return 2;
            break;
        default:
            break;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            {
                static NSString *edit_header_Cell = @"userCell";
                
                EditHederTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:edit_header_Cell];
                
                if (cell == nil) {
                    cell = [[EditHederTableViewCell alloc]
                            initWithStyle:UITableViewCellStyleDefault
                            reuseIdentifier:edit_header_Cell];
                }
                
                [cell.editBtn addTarget:self action:@selector(editHeaderImg) forControlEvents:UIControlEventTouchUpInside];
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }
            break;
        case 1:
        {
            static NSString *edit_header_Cell = @"userCell";
            
            CommSelectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:edit_header_Cell];
            
            if (cell == nil) {
                cell = [[CommSelectTableViewCell alloc]
                        initWithStyle:UITableViewCellStyleDefault
                        reuseIdentifier:edit_header_Cell];
            }
            if (indexPath.row == 0) {
                cell.contentLab.hidden = YES;
                cell.contentField.hidden = NO;
                [cell.imageBtn setImage:[UIImage imageNamed:@"write"] forState:UIControlStateNormal];
                cell.titleLab.text = @"Full name";

            }else
            {
                cell.titleLab.text = @"Speciality";
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            break;
        case 2:
        {
            static NSString *edit_header_Cell = @"userCell";
            
            ProfileNormalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:edit_header_Cell];
            
            if (cell == nil) {
                cell = [[ProfileNormalTableViewCell alloc]
                        initWithStyle:UITableViewCellStyleDefault
                        reuseIdentifier:edit_header_Cell];
            }
            cell.avatar.image = [UIImage imageNamed:@"cloud"];
            cell.name.text = localStr(@"upResume");
            cell.specialityTitle.text = localStr(@"professional");
            cell.specialityTitle.frame = CGRectMake(78, 33, SCREENWIDTH - 130, 34);
            cell.specialityTitle.numberOfLines = 0;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            break;
        case 3:
        {
            static NSString *edit_header_Cell = @"userCell";
            
            ProfileNormalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:edit_header_Cell];
            
            if (cell == nil) {
                cell = [[ProfileNormalTableViewCell alloc]
                        initWithStyle:UITableViewCellStyleDefault
                        reuseIdentifier:edit_header_Cell];
            }
            
            cell.avatar.image = [UIImage imageNamed:@"residency"];
            cell.name.text = @"Residency";
            cell.specialityTitle.text = @"Boston Hospital";
            cell.speciality.text = @"September 2015 - Present";
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            break;
        case 4:
        {
            static NSString *edit_header_Cell = @"userCell";
            
            ProfileNormalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:edit_header_Cell];
            
            if (cell == nil) {
                cell = [[ProfileNormalTableViewCell alloc]
                        initWithStyle:UITableViewCellStyleDefault
                        reuseIdentifier:edit_header_Cell];
            }
            
            if (indexPath.row == 0) {
                cell.avatar.image = [UIImage imageNamed:@"edu"];
                cell.name.text = @"California Dental School";
                cell.specialityTitle.text = @"Certificate, Advanced Periodontology";
                cell.speciality.text = @"September 2014 - March 2015";

            }else
            {
                cell.avatar.image = [UIImage imageNamed:@"school"];
                cell.name.text = @"Arizona Dental School";
                cell.specialityTitle.text = @"Doctorate of Dental Medicine (DMD)";
                cell.speciality.text = @"September 2010 - August 2014";

            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            break;
        case 5:
        {
            static NSString *edit_header_Cell = @"phoneCell";
            
            EditWriteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:edit_header_Cell];
            
            if (cell == nil) {
                cell = [[EditWriteTableViewCell alloc]
                        initWithStyle:UITableViewCellStyleDefault
                        reuseIdentifier:edit_header_Cell];
            }
            
            if (indexPath.row == 0) {
                cell.titleLab.text = @"Mobile Number";
            }else
            {
                cell.titleLab.text = @"Preferred email address";
            }
            
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            break;
        default:
            break;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.1;
    }
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section != 0) {
        UIView *vi = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 40)];
        vi.backgroundColor = UIColor.whiteColor;
        
        UILabel *label = [[UILabel alloc] init];
        label.font = [Fonts regular:12];
        label.textColor = Colors.textAlternate;
        label.backgroundColor = UIColor.whiteColor;
        [vi addSubview:label];
        [[[[label.layoutMaker sizeEq:SCREENWIDTH - 16 h:25] topParent:15] leftParent:16] install];
        
        UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [addBtn setImage:[UIImage imageNamed:@"add_light"] forState:UIControlStateNormal];
        addBtn.tag = section + 10;
        [addBtn addTarget:self action:@selector(addExperience:) forControlEvents:UIControlEventTouchUpInside];
        [vi addSubview:addBtn];
        addBtn.hidden = YES;
        [[[[addBtn.layoutMaker sizeEq:80 h:30] topParent:10] rightParent:0] install];
        
        switch (section) {
            case 1:
                label.text = localStr(@"personal");
                break;
            case 2:
                label.text = localStr(@"uploadResu");
                break;
            case 3:
                label.text = @"Residency";
                addBtn.hidden = NO;
                break;
            case 4:
                label.text = @"Education";
                addBtn.hidden = NO;
                break;
            case 5:
                label.text = @"Contact info";
                break;
            default:
                break;
        }
        
        return vi;
    }
    return nil;
}

//edit header image button click
- (void)editHeaderImg
{
    [self Den_showAlertWithTitle:localStr(@"userCamera") message:localStr(@"usePhoto") appearanceProcess:^(DenAlertController * _Nonnull alertMaker) {
        alertMaker.
        addActionCancelTitle(@"Dont't Allow").
        addActionDefaultTitle(@"OK");
    } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, DenAlertController * _Nonnull alertSelf) {
        if ([action.title isEqualToString:@"Dont't Allow"]) {
            NSLog(@"Dont't Allow");
        } else if ([action.title isEqualToString:@"OK"]) {
            NSLog(@"OK");
        }

    }];
}

- (void)addExperience:(UIButton *)btn
{
    switch (btn.tag) {
        case 13://click the add Residency button
        {
            NSLog(@"Residency button click");
        }
            break;
        case 14://click the add Education button
        {
            NSLog(@"Education button click");
        }
            break;
        default:
            break;
    }
}

//user tap the back button
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

//user tap the save button
- (void)saveBtnClick:(UIButton *)btn
{
    NSLog(@"save");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
