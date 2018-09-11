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

#import <AssetsLibrary/ALAsset.h>

@interface ProfileEditPage () <UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
	NSString *selectImageName;
	UIImage *selectImage;
}
@end


@implementation ProfileEditPage {
	UserInfo *userInfo;
	EditUserView *userView;
	TitleEditView *nameView;
	TitleMsgArrowView *specView;
	IconTitleMsgCell *resumeView;

	NSMutableArray<IconTitleMsgDetailCell * > *expViews;
	NSMutableArray<IconTitleMsgDetailCell * > *residencyViews;
	NSMutableArray<IconTitleMsgDetailCell * > *eduViews;
	TitleEditView *phoneView;
	TitleEditView *emailView;
	TitleMsgArrowView *practiceAddressView;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	userInfo = [Proto lastUserInfo];

	UINavigationItem *item = self.navigationItem;
	item.title = localStr(@"editPractice");
	item.rightBarButtonItem = [self navBarText:@"SAVE" target:self action:@selector(onSave:)];
	item.leftBarButtonItem = [self navBarImage:@"back_arrow" target:self action:@selector(onBack:)];


	userInfo = [Proto lastUserInfo];
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
	userView.layoutParam.height = 200;
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

	resumeView = [IconTitleMsgCell new];
	resumeView.imageView.imageName = @"cloud";
	resumeView.titleLabel.text = @"Upload Resume";
	resumeView.msgLabel.text = @"Your professional information will be imported automatically.";
	[self.contentView addSubview:resumeView];

	[self addGrayLine:0 marginRight:0];

	if (![userInfo isStudent]) {
		GroupLabelView *expGroupView = [self addGroupTitle:@"Experience"];
		[expGroupView.button onClick:self action:@selector(clickAddExp:)];

		if (userInfo.experienceArray == nil || userInfo.experienceArray.count == 0) {
			userInfo.experienceArray = @[[Experience new]];
		}
		for (int i = 0; i < userInfo.experienceArray.count; ++i) {
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
			if (i == userInfo.experienceArray.count - 1) {
				[self addGrayLine:0 marginRight:0];
			} else {
				[self addGrayLine:78 marginRight:0];
			}
		}
	}
	GroupLabelView *residGroupView = [self addGroupTitle:@"Residency"];
	[residGroupView.button onClick:self action:@selector(clickAddResidency:)];

	if (userInfo.residencyArray == nil || userInfo.residencyArray.count == 0) {
		userInfo.residencyArray = @[[Residency new]];
	}
	for (int i = 0; i < userInfo.residencyArray.count; ++i) {
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
		if (i == userInfo.residencyArray.count - 1) {
			[self addGrayLine:0 marginRight:0];
		} else {
			[self addGrayLine:78 marginRight:0];
		}
	}


	GroupLabelView *eduGroupView = [self addGroupTitle:@"Education"];
	[eduGroupView.button onClick:self action:@selector(clickAddEducation:)];

	if (userInfo.educationArray == nil || userInfo.educationArray.count == 0) {
		userInfo.educationArray = @[[Education new]];
	}
	for (int i = 0; i < userInfo.educationArray.count; ++i) {
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
		if (i == userInfo.educationArray.count - 1) {
			[self addGrayLine:0 marginRight:0];
		} else {
			[self addGrayLine:78 marginRight:0];
		}
	}

	[self addGroupTitle:@"Contact Info"];

	practiceAddressView = [TitleMsgArrowView new];
	practiceAddressView.titleLabel.text = @"Practice address";
	practiceAddressView.msgLabel.text = @"-";
	[practiceAddressView onClickView:self action:@selector(clickPraticeAddress:)];
	[self.contentView addSubview:practiceAddressView];
	[self addGrayLine:0 marginRight:0];


	phoneView = [TitleEditView new];
	phoneView.label.text = @"Mobile number";
	phoneView.edit.delegate = self;
	[phoneView.edit returnDone];
	[self.contentView addSubview:phoneView];
	[self addGrayLine:0 marginRight:0];

	emailView = [TitleEditView new];
	emailView.label.text = @"Preferred email address";
	emailView.edit.delegate = self;
	[emailView.edit returnDone];
	[self.contentView addSubview:emailView];
	[self addGrayLine:0 marginRight:0];

	[self layoutLinearVertical];
}

- (GroupLabelView *)addGroupTitle:(NSString *)title {
	GroupLabelView *v = [GroupLabelView new];
	v.label.text = title;
	[self.contentView addSubview:v];
	v.layoutParam.marginTop = 24;
	return v;
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];

	[self bindData];
}


- (void)bindData {
	nameView.edit.text = userInfo.fullName;
	specView.msgLabel.text = userInfo.specialityLabel;
	if (userInfo.experienceArray != nil) {
		for (int i = 0; i < userInfo.experienceArray.count; ++i) {
			Experience *r = userInfo.experienceArray[i];
			IconTitleMsgDetailCell *v = expViews[i];
			if ([r isOwnerDentist]) {
				v.imageView.imageName = @"dental-blue";
			} else {
				v.imageView.imageName = @"exp";
			}
			v.titleLabel.text = r.praticeType;
			v.msgLabel.text = r.dentalName;
			v.detailLabel.text = strBuild(r.dateFrom, @"-", r.dateTo);
			if (r.dentalName == nil || r.dentalName.length == 0) {
				v.imageView.imageName = @"exp";
				[v showEmpty:@"No experience added yet."];
			}
		}
	}
	if (userInfo.residencyArray != nil) {
		for (int i = 0; i < userInfo.residencyArray.count; ++i) {
			Residency *r = userInfo.residencyArray[i];
			IconTitleMsgDetailCell *v = residencyViews[i];
			v.msgLabel.text = r.place;
			v.detailLabel.text = strBuild(r.dateFrom, @"-", r.dateTo);
		}
	}
	if (userInfo.educationArray != nil) {
		for (int i = 0; i < userInfo.educationArray.count; ++i) {
			Education *edu = userInfo.educationArray[i];
			IconTitleMsgDetailCell *v = eduViews[(NSUInteger) i];
			v.titleLabel.text = edu.schoolName;
			v.msgLabel.text = edu.certificate;
			v.detailLabel.text = strBuild(edu.dateFrom, @"-", edu.dateTo);
		}
	}
	phoneView.edit.text = userInfo.phone;
	emailView.edit.text = userInfo.email;
	practiceAddressView.msgLabel.text = userInfo.practiceAddress.detailAddress;
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
	NSArray *ls = [Proto listSpeciality];
	[self selectText:@"SPECIALITY" value:userInfo.specialityLabel array:ls result:^(NSString *spec) {
		userInfo.specialityLabel = spec;
		[self bindData];
	}];

}

- (void)clickAddExp:(id)sender {
	EditExperiencePage *p = [EditExperiencePage new];
	p.isAdd = YES;
	p.userInfo = userInfo;
	p.exp = [Experience new];
	p.saveCallback = ^(Experience *ex) {
		[self saveExp:ex];
	};
	[self pushPage:p];

}

- (void)clickExp:(IconTitleMsgDetailCell *)sender {
	int n = sender.argN;
	Experience *r = userInfo.experienceArray[n];
	EditExperiencePage *p = [EditExperiencePage new];
	p.isAdd = r.dentalName == nil || r.dentalName.length == 0;
	p.exp = r;
	p.userInfo = userInfo;
	p.deleteCallback = ^(Experience *ex) {
		[self deleteExp:ex];
	};
	p.saveCallback = ^(Experience *ex) {
		[self saveExp:ex];
	};

	[self pushPage:p];
}

- (void)saveExp:(Experience *)e {
	NSMutableArray *a = [NSMutableArray arrayWithArray:userInfo.experienceArray];
	if (![a containsObject:e]) {
		[a addObject:e];
	}
	userInfo.experienceArray = a;
	[self buildViews];
	[self bindData];
}

- (void)deleteExp:(Experience *)e {
	NSMutableArray *a = [NSMutableArray arrayWithArray:userInfo.experienceArray];
	[a removeObject:e];
	if (a.count == 0) {
		[a addObject:[Experience new]];
	}
	userInfo.experienceArray = a;
	[self buildViews];
	[self bindData];

}

- (void)clickAddResidency:(id)sender {
	NSLog(@"click add residency");

	EditResidencyViewController *editRes = [EditResidencyViewController new];
	editRes.addOrEdit = @"add";
//    editRes.residency = r;
	[self pushPage:editRes];

}

- (void)clickAddEducation:(id)sender {
	NSLog(@"click add education");
	EditEduViewController *editRes = [EditEduViewController new];
	editRes.addOrEdit = @"add";
	[self pushPage:editRes];
}

- (void)clickPraticeAddress:(id)sender {
	EditPracticeAddressViewController *p = [EditPracticeAddressViewController new];
	p.address = userInfo.practiceAddress;
	[self pushPage:p];
}


- (void)clickResidency:(IconTitleMsgDetailCell *)sender {
	int n = sender.argN;
	Residency *r = userInfo.residencyArray[n];
	EditResidencyViewController *editRes = [EditResidencyViewController new];
	editRes.addOrEdit = @"edit";
	editRes.updateIndex = n;
	editRes.residency = r;
	[self pushPage:editRes];
}

- (void)clickEdu:(IconTitleMsgDetailCell *)sender {
	NSInteger n = sender.argN;
	EditEduViewController *editRes = [EditEduViewController new];
	editRes.addOrEdit = @"edit";
	editRes.education = userInfo.educationArray[n];
	[self pushPage:editRes];
}

- (void)onBack:(id)sender {
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)onSave:(id)sender {
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
		image = info[@"UIImagePickerControllerOriginalImage"];
		UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);

		NSString *imageName = [info valueForKey:UIImagePickerControllerMediaType];
		NSLog(@"imageName1:%@", imageName);
		selectImageName = imageName;
		selectImage = image;

	} else {
		image = info[UIImagePickerControllerOriginalImage];

		NSURL *imageURL = [info valueForKey:UIImagePickerControllerReferenceURL];

		ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
		//根据url获取asset信息, 并通过block进行回调
		[assetsLibrary assetForURL:imageURL resultBlock:^(ALAsset *asset) {
			ALAssetRepresentation *representation = [asset defaultRepresentation];
//			NSString *imageName = representation.filename;
//			NSLog(@"imageName:%@", imageName);
//			self->selectImageName = imageName;
			selectImage = image;

		}             failureBlock:^(NSError *error) {
			NSLog(@"%@", [error localizedDescription]);
		}];
	}
	[self dismissViewControllerAnimated:NO completion:nil];


}

@end
