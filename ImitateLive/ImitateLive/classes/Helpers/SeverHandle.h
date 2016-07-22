//
//  SeverHandle.h
//  ImitateLive
//
//  Created by lanou3g on 16/7/20.
//  Copyright © 2016年 SJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LiveModel.h"
@interface SeverHandle : NSObject
@property (strong, nonatomic) LiveModel *liveModel;
@property (strong, nonatomic) NSMutableArray * LiveModelArray;
+ (SeverHandle *)shareInstance;
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
