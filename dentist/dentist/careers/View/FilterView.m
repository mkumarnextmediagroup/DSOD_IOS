//
//  FilterView.m
//  dentist
//
//  Created by Jacksun on 2018/11/29.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "FilterView.h"
#import "Common.h"
#import "UITextField+styled.h"

#define edge 20
#define Xleft 15
#define AliX  8
@implementation FilterView
{
    UIScrollView *mScroll;
    UITextField *skillField;
    UITextField *salaryField;
    UITextField *experField;
    UITextField *locationField;
    UITextField *jobField;
    UITextField *comField;
}

- (void)initWithSubView
{
    mScroll = self.addScrollView;
    [[[mScroll.layoutMaker sizeEq:SCREENWIDTH h:SCREENHEIGHT] topParent:0] install];
    
    self.backgroundColor = [UIColor whiteColor];
    [self createCloseBtn];
    [self createSkill];
    [self createSalary];
    [self createExperence];
    [self createLocation];
    [self createJobTitle];
    [self createCompany];
    [self createFunBtn];
    self.frame = CGRectMake(0, NAVHEIGHT, SCREENWIDTH, SCREENHEIGHT);
}

- (void)createCloseBtn
{
    UIButton *closeBtn = mScroll.addButton;
//    closeBtn.backgroundColor = [UIColor blueColor];
    [closeBtn setImage:[UIImage imageNamed:@"close_select"] forState:UIControlStateNormal];
    [[[[closeBtn.layoutMaker sizeEq:50 h:50] topParent:10] leftParent:SCREENWIDTH-60] install];

}

- (void)createSkill
{
    UIButton *skillBtn = mScroll.addButton;
    [skillBtn setImage:[UIImage imageNamed:@"skills_career"] forState:UIControlStateNormal];
    [skillBtn setTitle:@"  Skills" forState:UIControlStateNormal];
    skillBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [skillBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    skillBtn.titleLabel.font = [Fonts bold:15];
    [[[[skillBtn.layoutMaker sizeEq:180 h:25] topParent:50] leftParent:edge] install];
    
    skillField = mScroll.addEditLined;
    skillField.layer.borderColor= rgb255(216, 216, 216).CGColor;
    skillField.layer.borderWidth= 1.0f;
    skillField.layer.masksToBounds = YES;
    skillField.layer.cornerRadius = 4;
    [[[[skillField.layoutMaker sizeEq:SCREENWIDTH-edge*2 h:30] leftParent:edge] below:skillBtn offset:AliX] install];
}

- (void)createSalary
{
    UIButton *salaryBtn = mScroll.addButton;
    [salaryBtn setImage:[UIImage imageNamed:@"salary_career"] forState:UIControlStateNormal];
    [salaryBtn setTitle:@"  Salary" forState:UIControlStateNormal];
    salaryBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [salaryBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    salaryBtn.titleLabel.font = [Fonts bold:15];
    [[[[salaryBtn.layoutMaker sizeEq:180 h:25] leftParent:edge] below:skillField offset:Xleft] install];
    
    salaryField = mScroll.addEditLined;
    salaryField.layer.borderColor= rgb255(216, 216, 216).CGColor;
    salaryField.layer.borderWidth= 1.0f;
    [salaryField setRightViewWithTextField:salaryField imageName:@"down_list"];
    salaryField.layer.masksToBounds = YES;
    salaryField.layer.cornerRadius = 4;
    [[[[salaryField.layoutMaker sizeEq:SCREENWIDTH-edge*2 h:30] leftParent:edge] below:salaryBtn offset:AliX] install];
}

- (void)createExperence
{
    UIButton *experBtn = mScroll.addButton;
    [experBtn setImage:[UIImage imageNamed:@"experence_career"] forState:UIControlStateNormal];
    [experBtn setTitle:@"  Experence" forState:UIControlStateNormal];
    experBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [experBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    experBtn.titleLabel.font = [Fonts bold:15];
    [[[[experBtn.layoutMaker sizeEq:180 h:25] leftParent:edge] below:salaryField offset:Xleft] install];
    
    experField = mScroll.addEditLined;
    experField.layer.borderColor= rgb255(216, 216, 216).CGColor;
    experField.layer.borderWidth= 1.0f;
    [experField setRightViewWithTextField:experField imageName:@"down_list"];
    experField.layer.masksToBounds = YES;
    experField.layer.cornerRadius = 4;
    [[[[experField.layoutMaker sizeEq:SCREENWIDTH-edge*2 h:30] leftParent:edge] below:experBtn offset:AliX] install];
}

- (void)createLocation
{
    UIButton *locationBtn = mScroll.addButton;
    [locationBtn setImage:[UIImage imageNamed:@"location_career"] forState:UIControlStateNormal];
    [locationBtn setTitle:@"  Location" forState:UIControlStateNormal];
    locationBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [locationBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    locationBtn.titleLabel.font = [Fonts bold:15];
    [[[[locationBtn.layoutMaker sizeEq:180 h:25] leftParent:edge] below:experField offset:Xleft] install];
    
    locationField = mScroll.addEditLined;
    locationField.layer.borderColor= rgb255(216, 216, 216).CGColor;
    locationField.layer.borderWidth= 1.0f;
    locationField.layer.masksToBounds = YES;
    locationField.layer.cornerRadius = 4;
    [[[[locationField.layoutMaker sizeEq:SCREENWIDTH-edge*2 h:30] leftParent:edge] below:locationBtn offset:AliX] install];
}

- (void)createJobTitle
{
    UIButton *jobBtn = mScroll.addButton;
    [jobBtn setImage:[UIImage imageNamed:@"job_career"] forState:UIControlStateNormal];
    [jobBtn setTitle:@"  Job title" forState:UIControlStateNormal];
    jobBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [jobBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    jobBtn.titleLabel.font = [Fonts bold:15];
    [[[[jobBtn.layoutMaker sizeEq:180 h:25] leftParent:edge] below:locationField offset:Xleft] install];
    
    jobField = mScroll.addEditLined;
    jobField.layer.borderColor= rgb255(216, 216, 216).CGColor;
    jobField.layer.borderWidth= 1.0f;
    jobField.placeholder = @"Type here...";
    jobField.layer.masksToBounds = YES;
    jobField.layer.cornerRadius = 4;
    [[[[jobField.layoutMaker sizeEq:SCREENWIDTH-edge*2 h:30] leftParent:edge] below:jobBtn offset:AliX] install];
}

- (void)createCompany
{
    UIButton *comBtn = mScroll.addButton;
    [comBtn setImage:[UIImage imageNamed:@"job_career"] forState:UIControlStateNormal];
    [comBtn setTitle:@"  Job title" forState:UIControlStateNormal];
    comBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [comBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    comBtn.titleLabel.font = [Fonts bold:15];
    [[[[comBtn.layoutMaker sizeEq:180 h:25] leftParent:edge] below:jobField offset:Xleft] install];
    
    comField = mScroll.addEditLined;
    comField.layer.borderColor= rgb255(216, 216, 216).CGColor;
    comField.layer.borderWidth= 1.0f;
    comField.placeholder = @"Type here...";
    comField.layer.masksToBounds = YES;
    comField.layer.cornerRadius = 4;
    [[[[comField.layoutMaker sizeEq:SCREENWIDTH-edge*2 h:30] leftParent:edge] below:comBtn offset:AliX] install];
}

- (void)createFunBtn
{
    UIButton *clearBtn = mScroll.addButton;
    [clearBtn setTitle:@"Clear All" forState:UIControlStateNormal];
    [clearBtn setTitleColor:[Colors primary] forState:UIControlStateNormal];
    clearBtn.titleLabel.font = [Fonts bold:15];
    [[[[clearBtn.layoutMaker sizeEq:SCREENWIDTH-edge*2 h:30] leftParent:edge] below:comField offset:25] install];

    UIButton *updateBtn = mScroll.addButton;
    [updateBtn setTitle:@"Update" forState:UIControlStateNormal];
    [updateBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    updateBtn.titleLabel.font = [Fonts bold:15];
    [updateBtn setBackgroundColor:[Colors primary]];
    [[[[updateBtn.layoutMaker sizeEq:SCREENWIDTH-edge*2 h:44] leftParent:edge] below:clearBtn offset:25] install];

    [mScroll layoutIfNeeded];
    [self layoutIfNeeded];
    mScroll.contentSize = CGSizeMake(SCREENWIDTH, CGRectGetMaxY(updateBtn.frame)+160);
    //NSLog(@"%f",CGRectGetMaxY(updateBtn.frame)+200);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
