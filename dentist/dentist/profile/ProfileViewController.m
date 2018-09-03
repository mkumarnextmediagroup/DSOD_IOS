//
//  ProfileViewController.m
//  dentist
//
//  Created by wennan on 2018/9/1.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "ProfileViewController.h"
#import "ProfileHeaderTableViewCell.h"
#import "ProfileNormalTableViewCell.h"
#import "ProfileTailTableViewCell.h"
#import "Profile.h"
#import "ProfileGroup.h"


@interface ProfileViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *myTable;
    NSMutableArray *_profileArray;
    
}

@end


@implementation ProfileViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *leftImg = [UIImage imageNamed:@"menu"];
    UIImage *rightImg = [UIImage imageNamed:@"edit"];
    [self setTopTitle:localStr(@"profile") leftImageName:leftImg rightImageName:rightImg rightTitle:localStr(@"edit")];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    myTable = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    myTable.delegate = self;
    myTable.dataSource = self;
    [self.view addSubview:myTable];
    [self initData];
    // Do any additional setup after loading the view.
}

-(void)initData{
    Profile *p1 = [Profile  new];
    p1.name=@"Edward Norton";
    p1.specialityTitle=@"Speciality";
    p1.speciality=@"Orthodontics";
    
    ProfileGroup *pGroup1 = [ProfileGroup new];
    pGroup1.groupName=@"";
    pGroup1.profiles=[NSMutableArray arrayWithObjects:p1, nil];
    
    Profile *p2 = [Profile  new];
    p2.name=@"Residency";
    p2.specialityTitle=@"Boston Hospital";
    p2.speciality=@"September 2015 - Present";
    
    ProfileGroup *pGroup2 = [ProfileGroup new];
    pGroup2.groupName=@"Residency";
    pGroup2.profiles=[NSMutableArray arrayWithObjects:p2, nil];
    
    
    Profile *p3 = [Profile  new];
    p3.name=@"California Dental School";
    p3.specialityTitle=@"Certificate, Advanced Periodontology";
    p3.speciality=@"September 2014 - March 2015";
    
    
    Profile *p4 = [Profile  new];
    p4.name=@"Arizona Dental School";
    p4.specialityTitle=@"Doctorate of Dental Medicine (DMD)";
    p4.speciality=@"September 2010 - August 2014";
    
    ProfileGroup *pGroup3 = [ProfileGroup new];
    pGroup3.groupName=@"Education";
    pGroup3.profiles=[NSMutableArray arrayWithObjects:p3,p4, nil];
    
    
    Profile *p5 = [Profile  new];
    p5.specialityTitle=@"Mobile Number";
    p5.speciality=@"207-782-8410";
    
    
    Profile *p6 = [Profile  new];
    p6.specialityTitle=@"Preferred Email Address";
    p6.speciality=@"edward.norton@cads.edu";
    
    ProfileGroup *pGroup4 = [ProfileGroup new];
    pGroup4.groupName=@"Contact";
    pGroup4.profiles=[NSMutableArray arrayWithObjects:p5,p6, nil];
    
    _profileArray=[NSMutableArray arrayWithObjects:pGroup1,pGroup2,pGroup3,pGroup4, nil];
    
    
}

#pragma mark UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _profileArray.count;
}

#pragma mark UITableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    ProfileGroup *pGroup  =_profileArray[section];
    return pGroup.profiles.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0){
        return 95;
    }else{
        return 78;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section==0){
        return 0;
    }
    return 24;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    ProfileGroup *pGroup  =_profileArray[section];
    return pGroup.groupName;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section  = indexPath.section;
    ProfileGroup *pGroup  =_profileArray[section];
    if (section == 0) {
        static NSString *brand_region_Cell = @"MyCell";
        
        ProfileHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:brand_region_Cell];
        
        if (cell == nil){
            cell = [[ProfileHeaderTableViewCell alloc]
                    initWithStyle:UITableViewCellStyleDefault
                    reuseIdentifier:brand_region_Cell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setData:[pGroup.profiles objectAtIndex:indexPath.row]];
        return cell;
        
    }else if (section == pGroup.profiles.count-1) {
        static NSString *brand_region_Cell = @"MyCell";
        
        ProfileTailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:brand_region_Cell];
        
        if (cell == nil){
            cell = [[ProfileTailTableViewCell alloc]
                    initWithStyle:UITableViewCellStyleDefault
                    reuseIdentifier:brand_region_Cell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setData:[pGroup.profiles objectAtIndex:indexPath.row]];
        return cell;
        
    }else{
        static NSString *brand_region_Cell = @"MyCell";
        
        ProfileNormalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:brand_region_Cell];
        
        if (cell == nil){
            cell = [[ProfileNormalTableViewCell alloc]
                    initWithStyle:UITableViewCellStyleDefault
                    reuseIdentifier:brand_region_Cell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setData:[pGroup.profiles objectAtIndex:indexPath.row]];
        return cell;
    }
}

@end
