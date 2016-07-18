//
//  FileDataHandle.m
//  DouBanProject
//
//  Created by 李泽 on 14-9-16.
//  Copyright (c) 2016年 蓝鸥科技. All rights reserved.
//

#import "FileDataHandle.h"

// 用户信息
#define kUserId       @"userId"
#define kUserName     @"username"
#define kPassword     @"password"
#define kLoginState   @"isLogin"
#define kAvatar       @"avatar"
#define kEmailAddress @"emailAddress"
#define kPhoneNumber  @"phoneNumber"
#import <UIImageView+WebCache.h>

#define kFileSize @"size"


// 归档
//#define kActivityArchiverKey  @"activity"
//#define kMovieArchiverKey     @"movie"
#define kLiveModelArchiverKey @"LiveModel"



@implementation FileDataHandle


static FileDataHandle *fileDataHandle = nil;
+ (instancetype)shareInstance
{
    if (fileDataHandle == nil) {
        fileDataHandle = [[[self class] alloc] init];
    }
    return fileDataHandle;
}


#pragma mark - 保存值
- (void)setLoginState:(BOOL)isLogin
{
    [[NSUserDefaults standardUserDefaults] setBool:isLogin forKey:kLoginState];
}
- (void)setUserId:(NSString *)userId{
    [[NSUserDefaults standardUserDefaults] setObject:userId forKey:kUserId];
}
- (void)setUsername:(NSString *)userName
{
    [[NSUserDefaults standardUserDefaults] setObject:userName forKey:kUserName];
}
- (void)setPassword:(NSString *)password
{
    [[NSUserDefaults standardUserDefaults] setObject:password forKey:kPassword];
}
- (void)setAvatar:(NSString *)avatar{
    [[NSUserDefaults standardUserDefaults] setObject:avatar forKey:kAvatar];
}
- (void)setEmail:(NSString *)email
{
    [[NSUserDefaults standardUserDefaults] setObject:email forKey:kEmailAddress];
}
- (void)setPhoneNumber:(NSString *)phone
{
    [[NSUserDefaults standardUserDefaults] setObject:phone forKey:kPhoneNumber];
}
- (void)setFilesSize:(CGFloat)size
{
    [[NSUserDefaults standardUserDefaults] setFloat:size forKey:kFileSize];
}

#pragma mark - 取值
- (BOOL)loginState
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kLoginState];
}

- (NSString *)userId{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kUserId];
}
- (NSString *)userName
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kUserName];
}
- (NSString *)password
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kPassword];
}
- (NSString *)avatar{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kAvatar];
}
- (NSString *)emailAddress
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kEmailAddress];
}
- (NSString *)phoneNumber
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kPhoneNumber];
}

- (CGFloat)filesSize
{
    return [[NSUserDefaults standardUserDefaults] floatForKey:kFileSize];
}

#pragma mark - 更新数据
- (void)synchronize
{
    [[NSUserDefaults standardUserDefaults] synchronize];
}


#pragma mark - 当前登录的用户信息
- (User *)user
{
    User *user = [[User alloc] init];
    user.userId = [self userId];
    user.userName = [self userName];
    user.password = [self password ];
    user.emailAddress = [self emailAddress];
    user.phoneNumber = [self phoneNumber];
    user.avatar = [self avatar];
    user.login = [self loginState];
    return user;
}





#pragma mark - 数据库
#pragma mark 缓存文件夹
- (NSString *)cachesPath
{
    return  [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
}

//数据库存储的路径
- (NSString *)databaseFilePath:(NSString *)databaseName
{
    NSLog(@"%@",[[self cachesPath] stringByAppendingPathComponent:databaseName]);
    return [[self cachesPath] stringByAppendingPathComponent:databaseName];
}




#pragma mark - 归档、反归档
//将对象归档
- (NSData *)dataOfArchiverObject:(id)object forKey:(NSString *)key
{
    NSMutableData * data = [NSMutableData data];
    
    NSKeyedArchiver * archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    
    [archiver encodeObject:object forKey:key];
    [archiver finishEncoding];
    
    
    return data;
}

//反归档
- (id)unarchiverObject:(NSData *)data forKey:(NSString *)key
{
    NSKeyedUnarchiver * unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    
    id object = [unarchiver decodeObjectForKey:key];
    
    [unarchiver finishDecoding];
    
    
    return object;
}




#pragma mark - 缓存
#pragma mark 下载的图片的完整路径
#pragma mark----自定义存储图片。将下载下来的图片保存在本地沙盒中，每张图片的名字统一格式是，将imageURL中‘/’都替换成‘_’作为图片文件的名字。
//- (NSString *)imageFilePathWithURL:(NSString *)imageURL
//{
//    //根据图像的URL，创建图像在存储时的文件名
//    NSString * imageName = [imageURL stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
//    
//    
//    return [[self downloadImageManagerFilePath] stringByAppendingPathComponent:imageName];
//}
////通常用于删除缓存的时，计算缓存大小
////单个文件的大小
//- (long long) fileSizeAtPath:(NSString*) filePath{
//    NSFileManager* manager = [NSFileManager defaultManager];
//    if ([manager fileExistsAtPath:filePath]){
//        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
//    }
//    return 0;
//}
////
////遍历文件夹获得文件夹大小，返回多少M
//- (float ) folderSizeAtPath:(NSString*) folderPath{
//    NSFileManager* manager = [NSFileManager defaultManager];
//    if (![manager fileExistsAtPath:folderPath]) return 0;
//    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
//    NSString* fileName;
//    long long folderSize = 0;
//    while ((fileName = [childFilesEnumerator nextObject]) != nil){
//        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
//        folderSize += [self fileSizeAtPath:fileAbsolutePath];
//    }
//    return folderSize/(1024.0*1024.0);
//}
//
////将下载的图片存储到沙盒中
//- (void)saveDownloadImage:(UIImage *)image filePath:(NSString *)path
//{
//    NSData * data = UIImageJPEGRepresentation(image, 1.0);
//    [data writeToFile:path atomically:YES];
//   CGFloat size = [self folderSizeAtPath:[self downloadImageManagerFilePath]];
//    //获取SDWebImage下载图片时的缓存，并得到大小
//    size = size + [[SDImageCache sharedImageCache] getSize] / (1024.0*1024.0);
//    NSLog(@"%lu",(unsigned long)[[SDImageCache sharedImageCache] getSize]);
//    [self setFilesSize:size];
//}
//#pragma mark 存储下载图片的文件夹路径
//- (NSString *)downloadImageManagerFilePath
//{
//    NSFileManager * fileManager = [NSFileManager defaultManager];
//    
//    NSString * imageManagerPath = [[self cachesPath] stringByAppendingPathComponent:@"DownloadImages"];
//    if (NO == [fileManager fileExistsAtPath:imageManagerPath]) {
//        //如果沙盒中没有存储图像的文件夹，创建文件夹
//        [fileManager createDirectoryAtPath:imageManagerPath withIntermediateDirectories:YES attributes:nil error:nil];
//    }
//    
//    return imageManagerPath;
//}
//
//#pragma mark 清除缓存
//- (void)cleanDownloadImages
//{
//    //清除头像图片
//    [[SDImageCache sharedImageCache] clearDisk];
//
//    NSString * imageManagerPath = [self downloadImageManagerFilePath];
//    //清除活动列表和电影列表对应 的图片
//    NSFileManager * fileManager = [NSFileManager defaultManager];
//    [fileManager removeItemAtPath:imageManagerPath error:nil];
//    [self setFilesSize:0];
//    
//}



@end
