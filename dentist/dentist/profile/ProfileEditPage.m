//
// Created by entaoyang on 2018/9/9.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import "ProfileEditPage.h"
#import "EditUserView.h"
#import "Common.h"
#import "UserInfo.h"
#import "Proto.h"
#import "TitleEditView.h"
#import "TitleMsgArrowView.h"
#import "IconTitleMsgCell.h"
#import "IconTitleMsgDetailCell.h"
#import "GroupLabelView.h"
#import "EditPracticeAddressViewController.h"
#import "EditResidencyViewController.h"
#import "EditEduViewController.h"
#import "SearchPage.h"
#import "EditExperiencePage.h"
#import "IdName.h"
#import "NSDate+myextend.h"
#import "UploadResumeItemView.h"

#import <AssetsLibrary/ALAsset.h>

@interface ProfileEditPage () <UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
}
@end


@implementation ProfileEditPage {
	EditUserView *userView;
	TitleEditView *nameView;
	TitleMsgArrowView *specView;
	UploadResumeItemView *resumeView;

	NSMutableArray<IconTitleMsgDetailCell * > *expViews;
	NSMutableArray<IconTitleMsgDetailCell * > *residencyViews;
	NSMutableArray<IconTitleMsgDetailCell * > *eduViews;
	TitleEditView *emailView;
	TitleMsgArrowView *practiceAddressView;

	NSString *uploadPortraitResult;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	_userInfo = [Proto lastUserInfo];
	uploadPortraitResult = nil;

	UINavigationItem *item = self.navigationItem;
	item.title = @"EDIT PROFILE";
	item.rightBarButtonItem = [self navBarText:@"Save" target:self action:@selector(onSave:)];
	item.leftBarButtonItem = [self navBarBack:self action:@selector(onBack:)];


	_userInfo = [Proto lastUserInfo];
	expViews = [NSMutableArray arrayWithCapacity:4];
	residencyViews = [NSMutableArray arrayWithCapacity:4];
	eduViews = [NSMutableArray arrayWithCapacity:4];

	[self buildViews];
	[self bindData];
}

- (void)buildViews {
	NSArray *allSubView = self.contentView.subviews;
	if (allSubView != nil) {
		for (UIView *v in allSubView) {
			[v removeFromSuperview];
		}
	}
	[expViews removeAllObjects];
	[residencyViews removeAllObjects];
	[eduViews removeAllObjects];

	userView = [EditUserView new];
	userView.layoutParam.height = 240;
	[userView.headerImg loadUrl:_userInfo.portraitUrlFull placeholderImage:@"default_avatar"];
	userView.percent = 0.13;
	[userView.editBtn onClick:self action:@selector(editPortrait:)];
	[self.contentView addSubview:userView];

	[self addGrayLine:0 marginRight:0];

	[self addGroupTitle:@"Personal Info"];

	nameView = [TitleEditView new];
	nameView.label.text = @"Full name";
	nameView.edit.delegate = self;
	[nameView.edit returnDone];
	[self.contentView addSubview:nameView];

	[self addGrayLine:0 marginRight:0];

	specView = [TitleMsgArrowView new];
	specView.titleLabel.text = @"Speciality";
	[specView onClickView:self action:@selector(clickSpec:)];
	[self.contentView addSubview:specView];

	[self addGrayLine:0 marginRight:0];

	[self addGroupTitle:@"Upload resume or import data"];

	resumeView = [UploadResumeItemView new];
    resumeView.vc = self;
    [resumeView showNoResumeMode];
	[self.contentView addSubview:resumeView];

	[self addGrayLine:0 marginRight:0];

	if (!_userInfo.isStudent) {
		GroupLabelView *expGroupView = [self addGroupTitle:@"Experience"];
		[expGroupView.button onClick:self action:@selector(clickAddExp:)];

		if (_userInfo.experienceArray == nil || _userInfo.experienceArray.count == 0) {
			_userInfo.experienceArray = @[[Experience new]];
		}
		for (int i = 0; i < _userInfo.experienceArray.count; ++i) {
			IconTitleMsgDetailCell *expView = [IconTitleMsgDetailCell new];
			expView.imageView.imageName = @"exp";
			expView.titleLabel.text = @"-";
			expView.msgLabel.text = @"-";
			expView.detailLabel.text = @"-";
			expView.hasArrow = YES;
			expView.argN = i;
			[expView onClickView:self action:@selector(clickExp:)];

			[self.contentView addSubview:expView];
			[expViews addObject:expView];
			if (i == _userInfo.experienceArray.count - 1) {
				[self addGrayLine:0 marginRight:0];
			} else {
				[self addGrayLine:78 marginRight:0];
			}
		}
	}
	GroupLabelView *residGroupView = [self addGroupTitle:@"Residency"];
	[residGroupView.button onClick:self action:@selector(clickAddResidency:)];

	if (_userInfo.residencyArray == nil || _userInfo.residencyArray.count == 0) {
		_userInfo.residencyArray = @[[Residency new]];
	}
	for (int i = 0; i < _userInfo.residencyArray.count; ++i) {
		IconTitleMsgDetailCell *residView = [IconTitleMsgDetailCell new];
		residView.imageView.imageName = @"residency";
		residView.titleLabel.text = @"Residency";
		residView.msgLabel.text = @"-";
		residView.detailLabel.text = @"-";

		residView.hasArrow = YES;

		residView.argN = i;
		[residView onClickView:self action:@selector(clickResidency:)];

		[self.contentView addSubview:residView];
		[residencyViews addObject:residView];
		if (i == _userInfo.residencyArray.count - 1) {
			[self addGrayLine:0 marginRight:0];
		} else {
			[self addGrayLine:78 marginRight:0];
		}
	}


	GroupLabelView *eduGroupView = [self addGroupTitle:@"Education"];
	[eduGroupView.button onClick:self action:@selector(clickAddEducation:)];

	if (_userInfo.educationArray == nil || _userInfo.educationArray.count == 0) {
		_userInfo.educationArray = @[[Education new]];
	}
	for (int i = 0; i < _userInfo.educationArray.count; ++i) {
		IconTitleMsgDetailCell *v = [IconTitleMsgDetailCell new];
		v.imageView.imageName = @"edu";
		v.titleLabel.text = @"-";
		v.msgLabel.text = @"-";
		v.detailLabel.text = @"-";
		v.hasArrow = YES;
		v.argN = i;
		[v onClickView:self action:@selector(clickEdu:)];

		[self.contentView addSubview:v];
		[eduViews addObject:v];
		if (i == _userInfo.educationArray.count - 1) {
			[self addGrayLine:0 marginRight:0];
		} else {
			[self addGrayLine:78 marginRight:0];
		}
	}

	[self addGroupTitle:@"Contact Info"];

	practiceAddressView = [TitleMsgArrowView new];
	practiceAddressView.titleLabel.text = @"Practice address";
//    practiceAddressView.msgLabel.text = @"-";
	[practiceAddressView onClickView:self action:@selector(clickPraticeAddress:)];
	[self.contentView addSubview:practiceAddressView];
	[self addGrayLine:0 marginRight:0];

	_phoneView = [TitleEditView new];
	_phoneView.label.text = @"Mobile number";
    [_phoneView.edit addTarget:self action:@selector(textFieldDidEditing:) forControlEvents:UIControlEventEditingChanged];
    _num = 0;
    [_phoneView.edit keyboardPhone];
	[_phoneView.edit returnDone];
	_phoneView.edit.maxLength = 10;
	[self.contentView addSubview:_phoneView];
	[self addGrayLine:0 marginRight:0];
    _phoneView.edit.tag = PHONEFIELDTag;

	emailView = [TitleEditView new];
	emailView.label.text = @"Preferred email address";
	emailView.edit.delegate = self;
	[emailView.edit returnDone];
    emailView.edit.tag = EMAILFIELDTag;
	[self.contentView addSubview:emailView];
	[self addGrayLine:0 marginRight:0];

	[self layoutLinearVertical];
}


-(void)textFieldDidEditing:(UITextField *)textField
{
    if (textField.tag == PHONEFIELDTag) {
        
        if (textField.text.length > _num) {
            
            if (textField.text.length == 4 || textField.text.length == 8 ) {//输入
                NSMutableString * str = [[NSMutableString alloc ] initWithString:textField.text];
                [str insertString:@"-" atIndex:(textField.text.length-1)];
                textField.text = str;
            }if (textField.text.length >= 12 ) {//输入完成
                textField.text = [textField.text substringToIndex:12];
                [textField resignFirstResponder];
            }
            
            _num = textField.text.length;

        }else if (textField.text.length < _num){//删除
            if (textField.text.length == 4 || textField.text.length == 8) {
                textField.text = [NSString stringWithFormat:@"%@",textField.text];
                textField.text = [textField.text substringToIndex:(textField.text.length-1)];
            }
            _num = textField.text.length;
        }
        
    }
}

- (GroupLabelView *)addGroupTitle:(NSString *)title {
	GroupLabelView *v = [GroupLabelView new];
	v.label.text = title;
	[self.contentView addSubview:v];
	v.layoutParam.marginTop = 24;
	return v;
}

- (void)viewWillAppear:(BOOL)animated {
    [[UINavigationBar appearance] setTintColor:UIColor.whiteColor];
	[super viewWillAppear:animated];

	[self bindData];
}


- (void)bindData {
    
    
	if (_selectImage) {
		[userView.headerImg setImage:_selectImage];
	} else {
		[userView.headerImg loadUrl:_userInfo.portraitUrlFull placeholderImage:@"default_avatar"];
	}
	nameView.edit.text = _userInfo.fullName;
	specView.msgLabel.text = _userInfo.speciality.name;
	if (_userInfo.experienceArray != nil) {
		for (int i = 0; i < _userInfo.experienceArray.count; ++i) {
			Experience *r = _userInfo.experienceArray[i];
			IconTitleMsgDetailCell *v = expViews[i];
			if ([r isOwnerDentist]) {
				v.imageView.imageName = @"dental-blue";
			} else {
				v.imageView.imageName = @"exp";
			}
			v.titleLabel.text = r.praticeType;
			if (r.useDSO) {
				v.msgLabel.text = r.dsoName;
			} else {
				v.msgLabel.text = r.pracName;
			}
			v.detailLabel.text = strBuild(r.dateFrom, @"-", r.dateTo);
			if (r.praticeTypeId == nil || r.praticeTypeId.length == 0) {
				v.imageView.imageName = @"exp";
				[v showEmpty:@"No experience added yet."];
			} else {
				[v hideEmpty];
			}
		}
	}
	if (_userInfo.residencyArray != nil) {
		for (int i = 0; i < _userInfo.residencyArray.count; ++i) {
			Residency *r = _userInfo.residencyArray[i];
			IconTitleMsgDetailCell *v = residencyViews[i];
			v.msgLabel.text = r.schoolName;
            v.detailLabel.text = [NSString stringWithFormat:@"%@",@(r.toYear)];//strBuild(r.dateFrom, @"-", r.dateTo);
			if (r.schoolId == nil || r.schoolId.length == 0) {
				[v showEmpty:@"No residency added yet"];
			} else {
				[v hideEmpty];
			}
		}
	}
	if (_userInfo.educationArray != nil) {
		for (int i = 0; i < _userInfo.educationArray.count; ++i) {
			Education *edu = _userInfo.educationArray[i];
			IconTitleMsgDetailCell *v = eduViews[(NSUInteger) i];
			v.titleLabel.text = edu.schoolName;
			v.msgLabel.text = edu.major;
			if ([v.msgLabel.text isEqualToString:@"-"]) {
				v.msgLabel.text = @"";
			}
			v.detailLabel.text = [NSString stringWithFormat:@"%@",@(edu.toYear)];//strBuild(edu.dateFrom, @"-", edu.dateTo);
			if (edu.schoolName == nil || edu.schoolName.length == 0) {
				[v showEmpty:@"No education added yet"];
			} else {
				[v hideEmpty];
			}
		}
	}
	_phoneView.edit.text = _userInfo.phone.textAddPhoneNor;
	emailView.edit.text = _userInfo.emailContact;
	practiceAddressView.msgLabel.text = _userInfo.practiceAddress.detailAddress;
	[practiceAddressView resetLayout];


	/**
	 For students, there are 6 sections: Name, Specialty, Residency, Education, Mobile number and Email address.
	 Percentage value for section is 100/6 = 16.7. We can round this up to 17. So, if two sections have been completed (for example, Name and Email address), then the percentage completion is 34%.
	 For non-students, there are 8 sections: Name, Specialty, Experience, Residency, Education, Practice address, Mobile number and Email address.
	 Percentage value for each section is 100/8 = 12.5. We can round this up to a round number. If three sections have been completed, then the value will be 37.5 - this can be rounded up to 38.
	 */

	[userView reset:[self getProfilePercent]];


	[self layoutLinearVertical];

}

- (void)textFieldDidEndEditing:(UITextField *)textField {
	[super textFieldDidEndEditing:textField];
	_userInfo.fullName = nameView.edit.textTrimed;
	_userInfo.phone = _phoneView.edit.textReplace;
	_userInfo.emailContact = emailView.edit.textTrimed;
	[userView reset:[self getProfilePercent]];
}


- (float)getProfilePercent {

	int count = 0;
	int countParent = 0;
	if (_userInfo.isStudent) {
		countParent = 6;
	} else {
		countParent = 8;
	}
	if (nameView.edit.text != nil && nameView.edit.text.length > 0) {
		count = count + 1;
	}
	if (_phoneView.edit.text != nil && _phoneView.edit.text.length > 0) {
		count = count + 1;
	}
	if (emailView.edit.text != nil && emailView.edit.text.length > 0) {
		count = count + 1;
	}

	if (specView.msgLabel.text != nil && specView.msgLabel.text.length > 0) {
		count = count + 1;
	}

	if (practiceAddressView.msgLabel.text != nil && practiceAddressView.msgLabel.text.length > 0 && !_userInfo.isStudent) {
		count = count + 1;
	}

	if (_userInfo.experienceArray != nil && _userInfo.experienceArray.count > 0  && _userInfo.isStudent) {
		if (_userInfo.experienceArray.count == 1) {
			Experience *r = _userInfo.experienceArray[0];
			if (r.praticeTypeId != nil && r.praticeTypeId.length > 0) {
				count = count + 1;
			}
		} else if (_userInfo.experienceArray.count > 1) {
			count = count + 1;
		}
	}


	if (_userInfo.residencyArray != nil && _userInfo.residencyArray.count > 0) {
		if (_userInfo.residencyArray.count == 1) {
			Residency *r = _userInfo.residencyArray[0];
			if (r.schoolId != nil && r.schoolId.length > 0) {
				count = count + 1;
			}
		} else if (_userInfo.residencyArray.count > 1) {
			count = count + 1;
		}

	}
	if (_userInfo.educationArray != nil && _userInfo.educationArray.count > 0) {
		if (_userInfo.educationArray.count == 1) {
			Education *r = _userInfo.educationArray[0];
			if (r.schoolName != nil && r.schoolName.length > 0) {
				count = count + 1;
			}
		} else if (_userInfo.educationArray.count > 1) {
			count = count + 1;
		}
	}
	return (float) count / countParent;
}


- (void)selectText:(NSString *)title value:(NSString *)value array:(NSArray *)array result:(void (^)(NSString *))result {
	SearchPage *c = [SearchPage new];
	c.titleText = @"SPECIALITY";
	c.withIndexBar = YES;
	[c setItemsPlain:array displayBlock:^(NSObject *item) {
		NSString *s = (NSString *) item;
		return s;
	}];
	c.checkedItem = value;
	c.onResult = ^(NSObject *item) {
		result((NSString *) item);
	};
	[self pushPage:c];
}

- (void)clickSpec:(id)sender {
	[self.view endEditing:YES];
	[self showIndicator];
	backTask(^() {
		NSArray *ls = [Proto querySpecialty];
		foreTask(^() {
			[self hideIndicator];
			[self selectIdName:@"SPECIALITY" array:ls selectedId:self->_userInfo.speciality.id result:^(IdName *item) {
				self->_userInfo.speciality = item;
				self->specView.msgLabel.text = self->_userInfo.speciality.name;
			}];
		});
	});
}

- (void)clickAddExp:(id)sender {
	[self.view endEditing:YES];
	EditExperiencePage *p = [EditExperiencePage new];
	p.isAdd = YES;
	p.userInfo = _userInfo;
	p.exp = [Experience new];
	p.saveCallback = ^(Experience *ex) {
		[self addExp:ex];
	};
	[self pushPage:p];
}

- (void)clickExp:(IconTitleMsgDetailCell *)sender {
	[self.view endEditing:YES];
	int n = sender.argN;
	Experience *r = _userInfo.experienceArray[n];
	EditExperiencePage *p = [EditExperiencePage new];
	p.isAdd = r.praticeTypeId == nil || r.praticeTypeId.length == 0;
	p.exp = r;
	p.userInfo = _userInfo;
	p.deleteCallback = ^(Experience *ex) {
		[self deleteExp:ex];
	};
	p.saveCallback = ^(Experience *ex) {
		[self buildViews];
		[self bindData];
	};

	[self pushPage:p];
}

- (void)addExp:(Experience *)e {
	Log(@"Add Exp: ", @(e.useDSO), e.pracName, e.dsoName);
	NSMutableArray *a = [NSMutableArray arrayWithArray:_userInfo.experienceArray];

	if (a.count > 0) {
		Experience *e = a[0];
		if (e.praticeTypeId == nil || e.praticeTypeId.length == 0) {
			[a removeObjectAtIndex:0];
		}
	}


	if (![a containsObject:e]) {
		[a addObject:e];
	}
	_userInfo.experienceArray = [self sortArrayByTime:a];
	[self buildViews];
	[self bindData];
}

- (void)deleteExp:(Experience *)e {
	NSMutableArray *a = [NSMutableArray arrayWithArray:_userInfo.experienceArray];
	[a removeObject:e];
	if (a.count == 0) {
		[a addObject:[Experience new]];
	}
	_userInfo.experienceArray = [self sortArrayByTime:a];
	[self buildViews];
	[self bindData];

}

- (void)clickResidency:(IconTitleMsgDetailCell *)sender {
	[self.view endEditing:YES];
	NSInteger n = sender.argN;
	Residency *r = _userInfo.residencyArray[n];
	EditResidencyViewController *editRes = [EditResidencyViewController new];
	editRes.isAdd = NO;
	editRes.residency = r;

	editRes.saveCallback = ^(Residency *r) {
		Log(r.schoolId, r.schoolName, @(r.fromYear), @(r.toYear));
		[self buildViews];
		[self bindData];
	};

	editRes.deleteCallback = ^(Residency *r) {
		[self deleteResidency:r];
	};

	[self pushPage:editRes];
}

- (void)clickAddResidency:(id)sender {
	[self.view endEditing:YES];

	EditResidencyViewController *editRes = [EditResidencyViewController new];
	editRes.isAdd = YES;
	editRes.saveCallback = ^(Residency *r) {
		[self addResidency:r];
	};

	[self pushPage:editRes];
}

- (void)deleteResidency:(Residency *)r {
	NSMutableArray *a = [NSMutableArray arrayWithArray:_userInfo.residencyArray];
	[a removeObject:r];
	if (a.count == 0) {
		[a addObject:[Residency new]];
	}
	_userInfo.residencyArray = [self sortArrayByTime:a];
	[self buildViews];
	[self bindData];
}

- (void)addResidency:(Residency *)r {
	NSMutableArray *ar = [NSMutableArray arrayWithArray:_userInfo.residencyArray];

	if (ar.count > 0) {
		Residency *e = ar[0];
		if (e.schoolId == nil || e.schoolId.length == 0) {
			[ar removeObjectAtIndex:0];
		}
	}


	if (![ar containsObject:r]) {
		[ar addObject:r];
	}
	_userInfo.residencyArray = [self sortArrayByTime:ar];
	[self buildViews];
	[self bindData];
}

- (void)addEducation:(Education *)e {
	NSMutableArray *ar = [NSMutableArray arrayWithArray:_userInfo.educationArray];
	if (ar.count > 0) {
		Education *e = ar[0];
		if (e.schoolId == nil || e.schoolId.length == 0) {
			[ar removeObjectAtIndex:0];
		}
	}
	if (![ar containsObject:e]) {
		[ar addObject:e];
	}
	_userInfo.educationArray = [self sortArrayByTime:ar];
	[self buildViews];
	[self bindData];
}

- (void)deleteEducation:(Education *)e {
	NSMutableArray *a = [NSMutableArray arrayWithArray:_userInfo.educationArray];
	[a removeObject:e];
	if (a.count == 0) {
		[a addObject:[Education new]];
	}
	_userInfo.educationArray = [self sortArrayByTime:a];
	[self buildViews];
	[self bindData];
}

- (NSMutableArray *)sortArrayByTime:(NSMutableArray *)compArr {
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"toYear" ascending:NO];
	NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];

	return [compArr sortedArrayUsingDescriptors:sortDescriptors];
}

- (void)clickAddEducation:(id)sender {
	[self.view endEditing:YES];
	EditEduViewController *p = [EditEduViewController new];
	p.isAdd = YES;
	p.saveCallback = ^(Education *e) {
		[self addEducation:e];
	};
	[self pushPage:p];
}

- (void)clickEdu:(IconTitleMsgDetailCell *)sender {
	[self.view endEditing:YES];
	NSInteger n = sender.argN;
	Education *education = _userInfo.educationArray[n];
	EditEduViewController *p = [EditEduViewController new];
	p.education = education;
	p.isAdd = NO;
	p.saveCallback = ^(Education *e) {
		[self buildViews];
		[self bindData];
	};
	p.deleteCallback = ^(Education *e) {
		[self deleteEducation:e];
	};
	[self pushPage:p];
}

- (void)clickPraticeAddress:(id)sender {
	[self.view endEditing:YES];
//    HttpResult *result = [Proto getStateAndCity];
//    NSLog(@"%@",result);

	EditPracticeAddressViewController *p = [EditPracticeAddressViewController new];
	p.address = _userInfo.practiceAddress;
	p.saveCallback = ^(Address *addr) {
		self->_userInfo.practiceAddress = addr;
		[self bindData];
	};
	[self pushPage:p];
}


- (void)onBack:(id)sender {
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)onSave:(id)sender {

	[self.view endEditing:YES];

	//save the edit content
	_userInfo.fullName = nameView.edit.text;
	_userInfo.phone = _phoneView.edit.textReplace;
	_userInfo.emailContact = emailView.edit.text;
//     _userInfo.practiceAddress.detailAddress = practiceAddressView.msgLabel.text;

	if (_userInfo.practiceAddress.address1 == nil) {
		_userInfo.practiceAddress.address1 = @"";
	}
	if (_userInfo.practiceAddress.address2 == nil) {
		_userInfo.practiceAddress.address2 = @"";
	}
	if (_userInfo.practiceAddress.city == nil) {
		_userInfo.practiceAddress.city = @"";
	}
	if (_userInfo.practiceAddress.stateLabel == nil) {
		_userInfo.practiceAddress.stateLabel = @"";
	}
	if (_userInfo.practiceAddress.zipCode == nil) {
		_userInfo.practiceAddress.zipCode = @"";
	}

	NSDictionary *d = @{
			@"full_name": nameView.edit.textTrimed,
			@"email": getLastAccount(),
			@"contact_email": emailView.edit.textTrimed,
			@"phone": _phoneView.edit.textReplace,
			@"is_student": _userInfo.isStudent ? @"1" : @"0",
			@"is_linkedin": _userInfo.isLinkedin ? @"1" : @"0",
			@"sex": @"",
			@"status": @"1",
			@"document_library": @{
					@"document_name": @"",
			},
			@"create_time": @"2018-09-12T06:16:53.603Z",
			@"educations": NSNull.null,
			@"experiences": NSNull.null,
			@"profileResidency": NSNull.null,
			@"document_library": NSNull.null,
			@"practiceAddress": @{
					@"address1": _userInfo.practiceAddress.address1,
					@"address2": _userInfo.practiceAddress.address2,
					@"city": _userInfo.practiceAddress.city,
					@"states": _userInfo.practiceAddress.stateLabel,
					@"zipCode": _userInfo.practiceAddress.zipCode,
			},
	};


	NSMutableDictionary *md = [NSMutableDictionary dictionaryWithDictionary:d];
	if (uploadPortraitResult != nil) {
		md[@"photo_album"] = @{@"photo_name": uploadPortraitResult};
	} else {
		md[@"photo_album"] = @{@"photo_name": @""};
	}
	if (_userInfo.speciality.id != nil) {
		md[@"specialty"] = @{@"id": _userInfo.speciality.id};
	} else {
		md[@"specialty"] = @{@"id": @""};
	}

	if (_userInfo.residencyArray.count > 0) {
		NSMutableArray *arr = [NSMutableArray arrayWithCapacity:5];
		md[@"profileResidency"] = arr;

		for (Residency *r in _userInfo.residencyArray) {
			if (r.schoolId != nil) {
				NSMutableDictionary *d = [NSMutableDictionary dictionaryWithCapacity:8];
				d[@"residency_school"] = @{
						@"id": r.schoolId,
				};

				d[@"start_time"] = [[NSDate dateBy:r.fromYear month:r.fromMonth day:0] format:DATE_FORMAT];
				d[@"end_time"] = [[NSDate dateBy:r.toYear month:r.toMonth day:0] format:DATE_FORMAT];
				d[@"email"] = [Proto lastAccount];
				[arr addObject:d];
			}
		}
	}
	if (_userInfo.educationArray.count > 0) {
		NSMutableArray *arr = [NSMutableArray arrayWithCapacity:5];
		md[@"educations"] = arr;
		for (Education *edu in _userInfo.educationArray) {
			if (edu.schoolName && edu.schoolName.length > 0) {
				NSMutableDictionary *d = [NSMutableDictionary dictionaryWithCapacity:8];
				[arr addObject:d];
				if (edu.schoolInUS) {
					d[@"types"] = @"1";
					d[@"school_name"] = edu.schoolName;
					d[@"dental_school"] = @{@"id": edu.schoolId};
				} else {
					d[@"types"] = @"0";
					d[@"school_name"] = edu.schoolName;
					d[@"dental_school"] = @{@"id": @""};
				}
				d[@"email"] = [Proto lastAccount];
				d[@"start_time"] = [[NSDate dateBy:edu.fromYear month:edu.fromMonth day:0] format:DATE_FORMAT];
				d[@"end_time"] = [[NSDate dateBy:edu.toYear month:edu.toMonth day:0] format:DATE_FORMAT];
				d[@"major"] = @"";
			}
		}
	}

	if (_userInfo.experienceArray.count > 0) {
		NSMutableArray *arr = [NSMutableArray arrayWithCapacity:8];
		md[@"experiences"] = arr;
		for (Experience *ex in _userInfo.experienceArray) {
			if (ex.praticeTypeId != nil && ex.praticeTypeId.length > 0) {
				NSMutableDictionary *d = [NSMutableDictionary dictionaryWithCapacity:8];
				[arr addObject:d];
				d[@"start_time"] = [[NSDate dateBy:ex.fromYear month:ex.fromMonth day:0] format:DATE_FORMAT];
				d[@"end_time"] = [[NSDate dateBy:ex.toYear month:ex.toMonth day:0] format:DATE_FORMAT];
				if (ex.useDSO) {
					d[@"practice_DSO"] = @{@"id": ex.dsoId};
					d[@"practice_name"] = @"";
				} else {
					d[@"practice_DSO"] = @{};
					d[@"practice_name"] = ex.pracName;
				}
				d[@"practice_Role"] = @{@"id": ex.roleAtPraticeId};
				d[@"practice_Type"] = @{@"id": ex.praticeTypeId};
			}
		}
	}

	[self showIndicator];
	backTask(^() {
		HttpResult *saveInfo = [Proto saveProfileInfo:md];
		foreTask(^() {
			[self hideIndicator];
			if (saveInfo.OK) {
				[self alertMsg:@"Saved successfully" onOK:^() {
					[self popPage];
				}];
			} else if (saveInfo.error.code == -1001) {
				[self alertMsg:@"Failed, please try again." onOK:^() {
				}];
			} else {
				[self alertMsg:saveInfo.msg onOK:^() {
				}];
			}

		});
	});
}

- (void)editPortrait:(id)sender {

	Confirm *cf = [Confirm new];
	cf.title = localStr(@"userCamera");
	cf.msg = localStr(@"usePhoto");
	cf.cancelText = localStr(@"notallow");
	[cf show:self onOK:^() {
		Log(@"click OK ");
		[self callActionSheetFunc];
	}];


}

- (void)callActionSheetFunc {
	if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {

		[self Den_showActionSheetWithTitle:nil message:nil appearanceProcess:^(DenAlertController *_Nonnull alertMaker) {
			alertMaker.
					addActionCancelTitle(@"cancel").
					addActionDefaultTitle(@"Camera").
					addActionDefaultTitle(@"Gallery");
		}                     actionsBlock:^(NSInteger buttonIndex, UIAlertAction *_Nonnull action, DenAlertController *_Nonnull alertSelf) {
			if ([action.title isEqualToString:@"cancel"]) {
				NSLog(@"cancel");
			} else if ([action.title isEqualToString:@"Camera"]) {
				NSLog(@"Camera");
				[self clickTheBtnWithSourceType:UIImagePickerControllerSourceTypeCamera];
			} else if ([action.title isEqualToString:@"Gallery"]) {
				NSLog(@"Gallery");
				[self clickTheBtnWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
			}
		}];

	} else {
		[self Den_showActionSheetWithTitle:nil message:nil appearanceProcess:^(DenAlertController *_Nonnull alertMaker) {
			alertMaker.
					addActionCancelTitle(@"cancel").
					addActionDefaultTitle(@"Gallery");
		}                     actionsBlock:^(NSInteger buttonIndex, UIAlertAction *_Nonnull action, DenAlertController *_Nonnull alertSelf) {
			if ([action.title isEqualToString:@"cancel"]) {
				NSLog(@"cancel");
			} else if ([action.title isEqualToString:@"Gallery"]) {
				NSLog(@"Gallery");
				[self clickTheBtnWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
			}
		}];
	}
}

- (void)clickTheBtnWithSourceType:(UIImagePickerControllerSourceType)sourceType {
	UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
	imagePickerController.delegate = self;
	imagePickerController.allowsEditing = YES;
	imagePickerController.sourceType = sourceType;
	[self presentViewController:imagePickerController animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
	UIImage *image = nil;
	if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
		picker.cameraDevice = UIImagePickerControllerCameraDeviceFront;
		image = info[@"UIImagePickerControllerEditedImage"];

        [self afterSelectDo:image];

	} else {
		image = info[UIImagePickerControllerEditedImage];

        [self afterSelectDo:image];
    }
	[self dismissViewControllerAnimated:NO completion:nil];

}

- (void)afterSelectDo:(UIImage *)image
{
    _selectImage = image;
    [self saveImageDocuments:_selectImage];
    [self bindData];
    
    NSString *localFile = [self getDocumentImage];
    if (localFile != nil) {
        Log(@"Image File: ", localFile);
        [self uploadHeaderImage:localFile];
    }
}

- (NSString *)getDocumentImage {
	// 读取沙盒路径图片
	NSString *aPath3 = [NSString stringWithFormat:@"%@/Documents/%@.png", NSHomeDirectory(), @"test"];
	return aPath3;
}

- (void)saveImageDocuments:(UIImage *)image {

    CGFloat f = 300.0f / image.size.width;
    //拿到图片
    UIImage *imagesave = [image scaledBy:f];
	NSString *path_sandox = NSHomeDirectory();
	//设置一个图片的存储路径
	NSString *imagePath = [path_sandox stringByAppendingString:@"/Documents/test.png"];
    
	[UIImagePNGRepresentation(imagesave) writeToFile:imagePath atomically:YES];
}

- (void)uploadHeaderImage:(NSString *)url {
	[self showIndicator];
	backTask(^() {
		self->uploadPortraitResult = [Proto uploadHeaderImage:url];
		foreTask(^() {
			[self hideIndicator];
		});
	});

}

@end
