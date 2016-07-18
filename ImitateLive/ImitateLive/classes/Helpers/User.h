//
//  User.h
//  DouBanProject
//
//  Created by 李泽 on 14-9-16.
//  Copyright (c) 2016年 蓝鸥科技. All rights reserved.
//
/**
 *  用户模型类
 *  
 *  用户名
 *  密码
 *  邮箱
 *  电话号码
 */

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic, copy) NSString *userId;               //用户id
@property (nonatomic, copy) NSString *userName;             //用户昵称
@property (nonatomic, copy) NSString *password;             //用户密码
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *emailAddress;         //用户邮箱
@property (nonatomic, copy) NSString *phoneNumber;          //手机号

@property (nonatomic, assign, getter = isLogin) BOOL login;

@end
