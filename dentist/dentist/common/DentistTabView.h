//
//  DentistTabView.h
//  dentist
//
//  Created by fengzhenrong on 2018/10/19.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DentistTabViewDelegate <NSObject>

@optional
- (void)didDentistSelectItemAtIndex:(NSInteger)index;
@end
NS_ASSUME_NONNULL_BEGIN

@interface DentistTabView : UIView
@property (nonatomic,weak) id<DentistTabViewDelegate>delegate;
@property (nonatomic,strong) NSMutableArray *titleArr;
@end

NS_ASSUME_NONNULL_END
