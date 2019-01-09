//
//  CareerMoreViewController.h
//  dentist
//
//  Created by Jacksun on 2018/11/27.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CareerMoreViewController : UIViewController {
    UIImageView *iCanImageView;
    UIImageView *menu_carImageView;
    UIImageView *menu_movieImageView;
    UIImageView *menu_setImageView;
    UIImageView *menu_photoImageView;
    BOOL isRonating;
    int count;
}

- (void)sigleTappedPickerView:(UIGestureRecognizer *)sender;
- (void)showFuntionBtn;
- (void)btnClick:(id)sender;
@end

NS_ASSUME_NONNULL_END
