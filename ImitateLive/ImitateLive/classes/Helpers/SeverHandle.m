//
//  SeverHandle.m
//  ImitateLive
//
//  Created by ssx on 16/7/20.
//  Copyright © 2016年 SJH. All rights reserved.
//

#import "SeverHandle.h"
#import "FileDataHandle.h"
@implementation SeverHandle

#define kLiveModelArchiverKey @"LiveModel"
#pragma mark 创建单例对象
static SeverHandle * handle = nil;
+ (SeverHandle *)shareInstance
{
    if (nil == handle) {
        handle = [[[self class] alloc] init];
//        [handle createObject];
    }
    
    return handle;
}

- (void)createObject {

    AVObject *todoFolder = [[AVObject alloc] initWithClassName:@"CollectList"];// 构建对象
    
}

#pragma mark 添加新的活动
- (void)insertNewLiveModel:(LiveModel *)liveModel
{

    NSString *currentUsername = [AVUser currentUser].username;// 当前用户名
    NSString * archiverKey = [NSString stringWithFormat:@"%@%@", kLiveModelArchiverKey, liveModel.liveID];
    NSData * data = [[FileDataHandle shareInstance] dataOfArchiverObject:liveModel forKey:archiverKey];
    AVObject *todoFolder = [[AVObject alloc] initWithClassName:@"CollectList"];// 构建对象

    [todoFolder setObject:currentUsername forKey:@"userName"];
    [todoFolder setObject:liveModel.nickname forKey:@"nickname"];
    [todoFolder setObject:liveModel.title forKey:@"title"];
    [todoFolder setObject:liveModel.gender forKey:@"gender"];
    [todoFolder setObject:liveModel.online forKey:@"online"];
    [todoFolder setObject:liveModel.spic forKey:@"spic"];
    [todoFolder setObject:liveModel.liveID forKey:@"ID"];
    [todoFolder setObject:data forKey:@"data"];
    [todoFolder saveInBackground];// 保存到云端
    [todoFolder saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            // 存储成功
            NSLog(@"%@",todoFolder.objectId);// 保存成功之后，objectId 会自动从云端加载到本地

        } else {
            // 失败的话，请检查网络环境以及 SDK 配置是否正确
        }
    }];

}

#pragma mark 删除某个活动
- (void)deleteLiveModel:(LiveModel *)liveModel
{
        NSString *currentUsername = [AVUser currentUser].username;// 当前用户名
    NSString *cql = [NSString stringWithFormat:@"select objectId from %@ where ID = '%@' and userName = '%@'", @"CollectList",liveModel.liveID,currentUsername];
    [AVQuery doCloudQueryInBackgroundWithCQL:cql callback:^(AVCloudQueryResult *result, NSError *error)
     {
         if (result.results) {
             NSLog(@"deleteLiveModel results = %@",result.results);
             NSLog(@"deleteLiveModel error = %@",error);
             
             NSString *objectId = [result.results[0] objectForKey:@"objectId"];
             
             NSLog(@"%@",objectId);
             //        AVObject *todoFolder = [[AVObject alloc] initWithClassName:@"CollectList"];// 构建对象
             
             // 执行 CQL 语句实现删除一个 Todo 对象
             NSString *deleteCql = [NSString stringWithFormat:@"delete from CollectList where objectId='%@'",objectId];
             [AVQuery doCloudQueryInBackgroundWithCQL:deleteCql callback:^(AVCloudQueryResult *result, NSError *error) {
                 // 如果 error 为空，说明保存成功
                 NSLog(@"delete error = %@",error);
                 
             }];
         }

     }];
  
    
}

#pragma mark 获取某个活动对象
- (LiveModel *)selectLiveModelWithID:(NSString *)ID
{
    NSString *currentUsername = [AVUser currentUser].username;// 当前用户名
    NSString *cql = [NSString stringWithFormat:@"select data from %@ where ID = '%@' and userName = '%@'", @"CollectList",ID,currentUsername];
    [AVQuery doCloudQueryInBackgroundWithCQL:cql callback:^(AVCloudQueryResult *result, NSError *error)
     {
         LiveModel *livemodel = nil;
         NSLog(@"seleteLiveModel result = %@",result.results);
         NSLog(@"selectLiveModel error = %@",error);
         if (result.results.count) {
             
                 NSDictionary *selectResult = [result.results[0] objectForKey:@"localData"];
                 NSData * data = [selectResult objectForKey:@"data"];
             NSLog(@"%@",data);
                 NSString * archiverKey = [NSString stringWithFormat:@"%@%@",kLiveModelArchiverKey,ID];
                 livemodel = [[FileDataHandle shareInstance] unarchiverObject:data forKey:archiverKey];
                 dispatch_async(dispatch_get_main_queue(), ^{
                     _liveModel = livemodel;
                 });
         }else {
         
             _liveModel = nil;
         }
   
     }];
    return _liveModel;
    
}

#pragma mark 获取所有活动
- (NSMutableArray *)selectAllLiveModel
{
    NSString *currentUsername = [AVUser currentUser].username;// 当前用户名
    _LiveModelArray = [NSMutableArray array];
    NSString *cql = [NSString stringWithFormat:@"select ID,data from %@ where userName = '%@'", @"CollectList",currentUsername];
    [AVQuery doCloudQueryInBackgroundWithCQL:cql callback:^(AVCloudQueryResult *result, NSError *error)
     {
         NSLog(@"seleteLiveAll result = %@",result.results);
         NSLog(@"selectLiveAll error = %@",error);
         
         if (result.results) {
             LiveModel *livemodel = nil;
             NSMutableArray *mutArray = [NSMutableArray array];
             for (int i = 0; i < result.results.count; i++) {
                 NSDictionary *selectResult = [result.results[i] objectForKey:@"localData"];
                 NSString *ID = [selectResult objectForKey:@"ID"];
                 NSLog(@"%@",ID);
                 NSData * data = [selectResult objectForKey:@"data"];
                 NSString * archiverKey = [NSString stringWithFormat:@"%@%@",kLiveModelArchiverKey,ID];
                 livemodel = [[FileDataHandle shareInstance] unarchiverObject:data forKey:archiverKey];
                 [mutArray addObject:livemodel];
             }
             
             dispatch_async(dispatch_get_main_queue(), ^{
                 _LiveModelArray = mutArray;
                 NSLog(@"%@",_LiveModelArray);
//                 [self allLives:mutArray];
             });
         }
         
         
         
     }];
    NSLog(@"_LiveModelArray%@",_LiveModelArray);
    return _LiveModelArray;
    
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
