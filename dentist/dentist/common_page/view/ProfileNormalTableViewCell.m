//
//  ProfileNormalTableViewCell.m
//  dentist
//
//  Created by wennan on 2018/9/1.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import "ProfileNormalTableViewCell.h"
#import "Fonts.h"
#import "Common.h"

@interface ProfileNormalTableViewCell () {
	NSInteger _lineType;
}

@end

@implementation ProfileNormalTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		_avatar = [UIImageView new];
		_avatar.frame = CGRectMake(18, 13, 48, 48);
		[self addSubview:_avatar];


		_name = [UILabel new];
		_name.frame = CGRectMake(78, 13, SCREENWIDTH - 78, 16);
		_name.font = [Fonts semiBold:14];
		_name.textColor = rgb255(0x4a, 0x4a, 0x4a);
		[self addSubview:_name];


		_specialityTitle = [UILabel new];
		_specialityTitle.frame = CGRectMake(78, 33, SCREENWIDTH - 78, 14);
		_specialityTitle.font = [Fonts regular:12];
		_specialityTitle.textColor = rgb255(0x4a, 0x4a, 0x4a);
		[self addSubview:_specialityTitle];


		_speciality = [UILabel new];
		_speciality.frame = CGRectMake(78, 51, SCREENWIDTH - 78, 14);
		_speciality.font = [Fonts regular:12];
		_speciality.textColor = rgb255(0x9b, 0x9b, 0x9b);
		[self addSubview:_speciality];

	}
	return self;
}

- (void)awakeFromNib {
	[super awakeFromNib];
	// Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	[super setSelected:selected animated:animated];

	// Configure the view for the selected state
}

- (void)setData:(Profile *)profile {
	_lineType = profile.lineType;
	_name.text = profile.name;
	_specialityTitle.text = profile.specialityTitle;
	_speciality.text = profile.speciality;
	[_avatar sd_setImageWithURL:[NSURL URLWithString:profile.avatatUrl]
	           placeholderImage:[UIImage imageNamed:profile.avataName]];

}

- (void)drawRect:(CGRect)rect {

	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
	CGContextFillRect(context, rect);

	//seperate line
	CGContextSetStrokeColorWithColor(context, rgb255(0xe9, 0xed, 0xf1).CGColor);
	if (_lineType == 0) {
		CGContextStrokeRect(context, CGRectMake(0, rect.size.height - 0.5, rect.size.width, 1));
	} else {
		CGContextStrokeRect(context, CGRectMake(79, rect.size.height - 0.5, rect.size.width, 1));
	}
}

@end
