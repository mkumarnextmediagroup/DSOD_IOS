//
//  CompanyOfJobDetailTableViewCell.m
//  dentist
//
//  Created by Shirley on 2018/11/29.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "CompanyOfJobDetailTableViewCell.h"
#import "common.h"
#import "CompanyModel.h"


@implementation CompanyOfJobDetailTableViewCell {
    UILabel *websiteValueLabel;
    UILabel *yearOfFoundationValueLabel;
    UILabel *numOfEmployeesValueLabel;
    UILabel *stageValueLabel;
    UILabel *contactPersonValueLabel;
    UILabel *detailValueLabel;

    int edge;
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        edge = 18;
        [self buildView];
    }
    return self;
}


-(void)buildView{
    
    //Website
    UILabel *websiteLabel = self.addLabel;
    websiteLabel.text = @"Website";
    websiteLabel.font = [Fonts regular:16];
    websiteLabel.numberOfLines = 1;
    [[[[websiteLabel.layoutMaker leftParent:edge]topParent:0] sizeEq:70 h:50]install];
    
    
    websiteValueLabel = self.addLabel;
    websiteValueLabel.textColor = Colors.textDisabled;
    websiteValueLabel.font = [Fonts regular:16];
    websiteValueLabel.textAlignment = NSTextAlignmentRight;
    websiteValueLabel.lineBreakMode = NSLineBreakByCharWrapping;
    websiteValueLabel.numberOfLines = 3;
    [[[[websiteValueLabel.layoutMaker toRightOf:websiteLabel offset:0]rightParent:-edge]  centerYOf:websiteLabel offset:0] install];
    
    
    
    //Year of Foundation
    UILabel *yearOfFoundationLabel = self.addLabel;
    yearOfFoundationLabel.text = @"Year of Foundation";
    yearOfFoundationLabel.font = [Fonts regular:16];
    [[[[yearOfFoundationLabel.layoutMaker leftParent:edge]below:websiteLabel offset:0]heightEq:50]install];
    
    yearOfFoundationValueLabel = self.addLabel;
    yearOfFoundationValueLabel.textColor = Colors.textDisabled;
    yearOfFoundationValueLabel.font = [Fonts regular:16];
    yearOfFoundationValueLabel.textAlignment = NSTextAlignmentRight;
    [[[[[yearOfFoundationValueLabel.layoutMaker toRightOf:yearOfFoundationLabel offset:edge]below:websiteLabel offset:0]rightParent:-edge] heightEq:50]install];
    
    //No. of Employees
    UILabel *numOfEmployeesLabel = self.addLabel;
    numOfEmployeesLabel.text = @"No. of Employees";
    numOfEmployeesLabel.font = [Fonts regular:16];
    [[[[numOfEmployeesLabel.layoutMaker leftParent:edge]below:yearOfFoundationLabel offset:0]heightEq:50]install];
    
    numOfEmployeesValueLabel = self.addLabel;
    numOfEmployeesValueLabel.textColor = Colors.textDisabled;
    numOfEmployeesValueLabel.font = [Fonts regular:16];
    numOfEmployeesValueLabel.textAlignment = NSTextAlignmentRight;
    [[[[[numOfEmployeesValueLabel.layoutMaker toRightOf:numOfEmployeesLabel offset:edge]below:yearOfFoundationLabel offset:0]rightParent:-edge] heightEq:50]install];
    
    //Stage
    UILabel *stageLabel = self.addLabel;
    stageLabel.text = @"Stage";
    stageLabel.font = [Fonts regular:16];
    [[[[stageLabel.layoutMaker leftParent:edge]below:numOfEmployeesLabel offset:0]heightEq:50]install];
    
    stageValueLabel = self.addLabel;
    stageValueLabel.textColor = Colors.textDisabled;
    stageValueLabel.font = [Fonts regular:16];
    stageValueLabel.textAlignment = NSTextAlignmentRight;
    [[[[[stageValueLabel.layoutMaker toRightOf:stageLabel offset:edge]below:numOfEmployeesLabel offset:0]rightParent:-edge] heightEq:50]install];
    
    //Contact Person
    UILabel *contactPersonLabel = self.addLabel;
    contactPersonLabel.text = @"Contact Person";
    contactPersonLabel.font = [Fonts regular:16];
    [[[[contactPersonLabel.layoutMaker leftParent:edge]below:stageLabel offset:0]heightEq:50]install];
    
    contactPersonValueLabel = self.addLabel;
    contactPersonValueLabel.textColor = Colors.textDisabled;
    contactPersonValueLabel.font = [Fonts regular:16];
    contactPersonValueLabel.textAlignment = NSTextAlignmentRight;
    [[[[[contactPersonValueLabel.layoutMaker toRightOf:contactPersonLabel offset:edge]below:stageLabel offset:0]rightParent:-edge] heightEq:50]install];
    
    
    //Details
    UILabel *detailLabel = self.addLabel;
    detailLabel.text = @"Details";
    detailLabel.font = [Fonts regular:16];
    detailLabel.textColor = rgbHex(0xb3b9bd);
    [[[[detailLabel.layoutMaker leftParent:edge]rightParent:-edge] below:contactPersonLabel offset:0]install];
    
    detailValueLabel = self.addLabel;
    detailValueLabel.font = [Fonts regular:16];
    [[[[[detailValueLabel.layoutMaker leftParent:edge] rightParent:-edge] below:detailLabel offset:0]bottomParent:-edge] install];
    
}


- (void)setData:(CompanyModel *)model{
    
    
    websiteValueLabel.text = model.webSiteUrl;
    yearOfFoundationValueLabel.text =  model.foundingTime;
    numOfEmployeesValueLabel.text = model.employees;
    stageValueLabel.text = model.stage;
    contactPersonValueLabel.text = model.contactPerson;
    detailValueLabel.text = model.companyDesc;
    
}


@end
