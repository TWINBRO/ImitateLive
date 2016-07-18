//
//  VideoRelationModel.h
//  ImitateLive
//
//  Created by lanou3g on 16/7/12.
//  Copyright © 2016年 SJH. All rights reserved.
//

#import "BaseModel.h"

@interface VideoRelationModel : BaseModel

// 直播间相关历史视频
// data下的属性
@property (nonatomic,copy) NSString *cnt;// 数字48
@property (nonatomic,copy) NSArray *videos;// 视频数组
// videos的属性
@property (nonatomic,copy) NSString *videoRelationID;// (id)
@property (nonatomic,copy) NSString *title;// 历史视频标题
@property (nonatomic,copy) NSString *gameId;
@property (nonatomic,copy) NSString *albumId;
@property (nonatomic,copy) NSString *uid;
@property (nonatomic,copy) NSString *gender;
@property (nonatomic,copy) NSString *avatar;
@property (nonatomic,copy) NSString *nickname;
@property (nonatomic,copy) NSString *playUrl;
@property (nonatomic,copy) NSString *spic;// 截图图片
@property (nonatomic,copy) NSString *bpic;
@property (nonatomic,copy) NSString *playCnt;// 播放数
@property (nonatomic,copy) NSString *realOnline;
@property (nonatomic,copy) NSString *duration;// 视频总时长
@property (nonatomic,copy) NSString *tags;
@property (nonatomic,copy) NSString *docTag;
@property (nonatomic,copy) NSString *videoDesc;
@property (nonatomic,copy) NSString *fileMd5;
@property (nonatomic,copy) NSString *filePath;
@property (nonatomic,copy) NSString *fileSize;
@property (nonatomic,copy) NSString *fileSavePath;
@property (nonatomic,copy) NSString *weight;
@property (nonatomic,copy) NSString *transCodeStatus;
@property (nonatomic,copy) NSString *status;
@property (nonatomic,copy) NSString *isCreated;
@property (nonatomic,copy) NSString *reason;
@property (nonatomic,copy) NSString *source;
@property (nonatomic,copy) NSString *addTime;
@property (nonatomic,copy) NSString *gameName;
@property (nonatomic,copy) NSString *gameKey;
@property (nonatomic,copy) NSString *gameUrl;
@property (nonatomic,copy) NSString *url;
@property (nonatomic,copy) NSArray *flashvars;
// flashvars 的属性
@property (nonatomic,copy) NSString *Servers;
@property (nonatomic,copy) NSArray *ServerIp;
@property (nonatomic,copy) NSArray *ServerPort;
@property (nonatomic,copy) NSArray *CharRoomId;
@property (nonatomic,copy) NSString *VideoUrl;
@property (nonatomic,copy) NSString *VideoID;
@property (nonatomic,copy) NSString *videoLevels;
@property (nonatomic,copy) NSString *Status;// 可能是数字
@property (nonatomic,copy) NSString *RoomId;// 可能是数字
@property (nonatomic,assign) BOOL *ComLayer;// true
@property (nonatomic,copy) NSString *VideoTitle;
@property (nonatomic,copy) NSString *WebHost;
@property (nonatomic,copy) NSString *RecUrl;
@property (nonatomic,copy) NSString *VideoType;
@property (nonatomic,copy) NSString *logoPos;// 可能是数字
@property (nonatomic,copy) NSString *pv;
@property (nonatomic,copy) NSString *YfVod;// 可能是数字
// flashvars属性结束
@property (nonatomic,copy) NSString *order;// 可能是数字  和数组排序一样

@end
