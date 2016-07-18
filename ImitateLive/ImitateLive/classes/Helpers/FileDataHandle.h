//
//  FileDataHandle.h
//  DouBanProject
//
//  Created by 李泽 on 14-9-16.
//  Copyright (c) 2016年 蓝鸥科技. All rights reserved.
//
/**
 *  操作文件数据的工具类
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "User.h"

@interface FileDataHandle : NSObject


#pragma mark - 方法
+ (instancetype)shareInstance;


#pragma mark - 保存值
- (void)setLoginState:(BOOL)isLogin;
- (void)setUserId:(NSString *)userId;
- (void)setUsername:(NSString *)userName;
- (void)setPassword:(NSString *)password;
- (void)setAvatar:(NSString *)avatar;
- (void)setEmail:(NSString *)email;
- (void)setPhoneNumber:(NSString *)phone;
- (void)setFilesSize:(CGFloat)size;
#pragma mark - 取值
- (BOOL)loginState;
- (NSString *)userId;
- (NSString *)userName;
- (NSString *)password;
- (NSString *)avatar;
- (NSString *)emailAddress;
- (NSString *)phoneNumber;
- (CGFloat)filesSize;
#pragma mark - 更新数据
- (void)synchronize;



#pragma mark - 当前登录的用户信息
- (User *)user;





#pragma mark - 数据库
#pragma mark 缓存文件夹
- (NSString *)cachesPath;

#pragma mark 数据库路径
//数据库存储的路径
- (NSString *)databaseFilePath:(NSString *)databaseName;



#pragma mark - 归档、反归档
//将对象归档
- (NSData *)dataOfArchiverObject:(id)object forKey:(NSString *)key;

//反归档
- (id)unarchiverObject:(NSData *)data forKey:(NSString *)key;



#pragma mark - 缓存
#pragma mark 下载的图片的完整路径
//- (NSString *)imageFilePathWithURL:(NSString *)imageURL;
//#pragma mark 保存图片缓存
//- (void)saveDownloadImage:(UIImage *)image filePath:(NSString *)path;
//#pragma mark 清除缓存
//- (void)cleanDownloadImages;


@end
