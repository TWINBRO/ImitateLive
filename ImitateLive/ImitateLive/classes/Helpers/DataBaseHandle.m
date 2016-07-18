//
//  DataBaseHandle.m
//  DouBan-01
//
//  Created by 李泽 on 14-9-16.
//  Copyright (c) 2014年 蓝鸥科技. All rights reserved.
//

#import "DataBaseHandle.h"
#import <sqlite3.h>

#import "FileDataHandle.h"



// 归档
//#define kActivityArchiverKey  @"activity"
//#define kMovieArchiverKey     @"movie"
#define kLiveModelArchiverKey @"LiveModel"

#define kDatabaseName   @"Collect.sqlite"
//#define kDatabaseName   @"Douban.sqlite"

@implementation DataBaseHandle

#pragma mark 创建单例对象
static DataBaseHandle * handle = nil;
+ (DataBaseHandle *)shareInstance
{
    if (nil == handle) {
        handle = [[[self class] alloc] init];
        [handle openDB];
    }
    
    return handle;
}

#pragma mark 对数据库的增删改查要记清
static sqlite3 * db = nil;
//打开数据库
- (void)openDB
{
    if (db != nil) {
        return;
    }
    
    //数据库存储在沙盒中的caches文件夹下
    NSString * dbPath = [[FileDataHandle shareInstance] databaseFilePath:kDatabaseName];
    
    //打开数据库，第一个参数是数据库存储的完整路径
    //如果数据库文件已经存在，是打开操作。如果数据库文件不存在，是先创建，再打开
    int result = sqlite3_open([dbPath UTF8String], &db);
    if (result == SQLITE_OK) {
        
        NSLog(@"打开数据库成功");
        //创建表的sql语句
        NSString * createSql = @"CREATE TABLE IF NOT EXISTS 'CollectList' ('userName' TEXT, 'nickname' TEXT, 'title' TEXT, 'gender' TEXT, 'online' TEXT, 'spic' TEXT, 'ID' TEXT, data BLOB)";
        //执行sql语句
        sqlite3_exec(db, [createSql UTF8String], NULL, NULL, NULL);
        
    }
    
}

//关闭数据库
- (void)closeDB
{
    int result = sqlite3_close(db);
    if (result == SQLITE_OK) {
        
        NSLog(@"数据库关闭成功");
        db = nil;
    }
}




#pragma mark 添加新的活动
- (void)insertNewLiveModel:(LiveModel *)liveModel
{
    
    [self openDB];
    
    sqlite3_stmt * stmt = nil;
    
    NSString * sql = @"insert into CollectList (userName,nickname,title,gender,online,spic,ID,data) values (?,?,?,?,?,?,?,?)";
    
    int result = sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL);
    if (result == SQLITE_OK) {
        sqlite3_bind_text(stmt, 1, [[FileDataHandle shareInstance].userName UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 2, [liveModel.nickname UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 3, [liveModel.title UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 4, [liveModel.gender UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 5, [liveModel.online UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 6, [liveModel.spic UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 7, [liveModel.liveID UTF8String], -1, NULL);
        
        
        NSString * archiverKey = [NSString stringWithFormat:@"%@%@", kLiveModelArchiverKey, liveModel.liveID];
        NSData * data = [[FileDataHandle shareInstance] dataOfArchiverObject:liveModel forKey:archiverKey];
        
        sqlite3_bind_blob(stmt, 8, [data bytes], (int)[data length], NULL);
        
        sqlite3_step(stmt);
    }
    
    sqlite3_finalize(stmt);
}

#pragma mark 删除某个活动
- (void)deleteLiveModel:(LiveModel *)liveModel
{
    [self openDB];
    
    sqlite3_stmt * stmt = nil;
    
    NSString * sql = @"delete from CollectList where ID = ? and userName = ?";
    
    int result = sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL);
    if (result == SQLITE_OK) {
        
        sqlite3_bind_text(stmt, 1, [liveModel.liveID UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 2, [[FileDataHandle shareInstance].userName UTF8String], -1, NULL);
        
        sqlite3_step(stmt);
    }
    
    sqlite3_finalize(stmt);
    
}

#pragma mark 获取某个活动对象
- (LiveModel *)selectLiveModelWithID:(NSString *)ID
{
    
    [self openDB];
    
    sqlite3_stmt * stmt = nil;
    
    NSString * sql = @"select data from CollectList where ID = ? and userName = ?";
    
    int result = sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL);
    
    LiveModel * livemodel = nil;
    
    if (result == SQLITE_OK) {
        
        sqlite3_bind_text(stmt, 1, [ID UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 2, [[FileDataHandle shareInstance].userName UTF8String], -1, NULL);
        if (sqlite3_step(stmt) == SQLITE_ROW) {
            
            NSData * data = [NSData dataWithBytes:sqlite3_column_blob(stmt, 0) length:sqlite3_column_bytes(stmt, 0)];
            
            NSString * archiverKey = [NSString stringWithFormat:@"%@%@",kLiveModelArchiverKey,ID];
            livemodel = [[FileDataHandle shareInstance] unarchiverObject:data forKey:archiverKey];
        }
        
    }
    
    sqlite3_finalize(stmt);
    
    return livemodel;
}

#pragma mark 获取所有活动
- (NSMutableArray *)selectAllLiveModel
{
    
    [self openDB];
    
    sqlite3_stmt * stmt = nil;
    
    NSString * sql = @"select ID,data from CollectList where userName = ?";
    
    int result = sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL);
    
    NSMutableArray * LiveModelArray = [NSMutableArray array];
    
    if (result == SQLITE_OK) {
        
        sqlite3_bind_text(stmt, 1, [[FileDataHandle shareInstance].userName UTF8String], -1, NULL);
        
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            
            NSString * ID = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 0)];
            
            NSData * data = [NSData dataWithBytes:sqlite3_column_blob(stmt, 1) length:sqlite3_column_bytes(stmt, 1)];
            
            NSString * archiverKey = [NSString stringWithFormat:@"%@%@",kLiveModelArchiverKey,ID];
            
            LiveModel * live = [[FileDataHandle shareInstance] unarchiverObject:data forKey:archiverKey];
            [LiveModelArray addObject:live];
        }
        
    }
    
    sqlite3_finalize(stmt);
    
    return LiveModelArray;
}

#pragma mark 判断活动是否被收藏
- (BOOL)isFavoriteLiveModelWithID:(NSString *)ID
{
    LiveModel * live = [self selectLiveModelWithID:ID];
    if (live == nil) {
        return NO;
    }
    
    return YES;
}

@end
