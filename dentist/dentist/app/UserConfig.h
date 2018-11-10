//
// Created by entaoyang on 2018/8/31.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>


extern NSUserDefaults *globalConfig(void);

extern NSUserDefaults *userConfig(NSString *userAccount);


extern void putLastAccount(NSString *account);

extern NSString *getLastAccount(void);

extern NSString *getUserToken(NSString *account);

extern void putUserToken(NSString *account, NSString *token);

extern void keychainPutPwd(NSString *account, NSString *pwd);

extern NSString *keychainGetPwd(NSString *account);

extern void putServerDomain(NSInteger value);
extern NSInteger getServerDomain(void);

extern void putIsActicleArchive(NSInteger value);
extern NSInteger getIsActicleArchive(void);

extern void putLoginType(NSInteger value);
extern NSInteger getLoginType(void);
extern NSString *getShareUrl(NSString *modulename,NSString*someid);

