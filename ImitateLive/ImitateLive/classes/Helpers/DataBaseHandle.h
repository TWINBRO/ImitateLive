//
//  DataBaseHandle.h
//  DouBan-01
//
//  Created by 李泽 on 14-9-16.
//  Copyright (c) 2014年 蓝鸥科技. All rights reserved.
//
/**
 *  数据操作文件
 */


#import <Foundation/Foundation.h>
#import <sqlite3.h>

#import "LiveModel.h"

@interface DataBaseHandle : NSObject



+ (DataBaseHandle *)shareInstance;

#pragma mark 打开数据库
- (void)openDB;
#pragma mark 关闭数据库
- (void)closeDB;

#pragma mark -----Activity活动  数据库操作-------
#pragma mark 添加新的活动
- (void)insertNewLiveModel:(LiveModel *)liveModel;
#pragma mark 删除某个活动
- (void)deleteLiveModel:(LiveModel *)liveModel;
#pragma mark 获取某个活动对象
- (LiveModel *)selectLiveModelWithID:(NSString *)ID;
#pragma mark 获取所有活动
- (NSMutableArray *)selectAllLiveModel;

#pragma mark 判断活动是否被收藏
- (BOOL)isFavoriteLiveModelWithID:(NSString *)ID;

@end
