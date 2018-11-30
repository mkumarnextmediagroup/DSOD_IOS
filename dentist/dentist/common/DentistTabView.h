//
//  DentistTabView.h
//  dentist
//
//  Created by fengzhenrong on 2018/10/19.
//  Copyright © 2018年 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IdName;
@protocol DentistTabViewDelegate <NSObject>

@optional
- (void)didDentistSelectItemAtIndex:(NSInteger)index;
@end
NS_ASSUME_NONNULL_BEGIN

@interface DentistTabView : UIView
@property (nonatomic,weak) id<DentistTabViewDelegate>delegate;
@property (nonatomic,assign) BOOL isScrollEnable;
@property (nonatomic,assign) NSInteger itemCount;
@property (nonatomic,strong) NSMutableArray *titleArr;
@property (nonatomic,strong) NSMutableArray<IdName *> *modelArr;
@end

NS_ASSUME_NONNULL_END
