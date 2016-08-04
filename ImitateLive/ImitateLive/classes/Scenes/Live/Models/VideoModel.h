//
//  VideoModel.h
//  ImitateLive
//
//  Created by ssx on 16/7/12.
//  Copyright © 2016年 SJH. All rights reserved.
//

#import "BaseModel.h"

@interface VideoModel : BaseModel

// 视频直播间
// data下的数据
@property (nonatomic,copy) NSString *videoID;//(id)
@property (nonatomic,copy) NSString *uid;
@property (nonatomic,copy) NSString *nickname;
@property (nonatomic,copy) NSString *gender;
@property (nonatomic,copy) NSString *avatar;
@property (nonatomic,copy) NSString *code;
@property (nonatomic,copy) NSString *domain;
@property (nonatomic,copy) NSString *url;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *gameId;
@property (nonatomic,copy) NSString *spic;
@property (nonatomic,copy) NSString *bpic;// 截图
@property (nonatomic,copy) NSString *videoTemplate;// (template)
@property (nonatomic,copy) NSString *online;
@property (nonatomic,copy) NSString *weight;
@property (nonatomic,copy) NSString *status;
@property (nonatomic,copy) NSString *level;
@property (nonatomic,copy) NSString *hotsLevel;
@property (nonatomic,copy) NSString *type;
@property (nonatomic,copy) NSString *liveTime;
@property (nonatomic,copy) NSString *verscr;
@property (nonatomic,copy) NSString *allowRecord;
@property (nonatomic,copy) NSString *allowVideo;
@property (nonatomic,copy) NSString *publishUrl;
@property (nonatomic,copy) NSString *videoId; /////////////
@property (nonatomic,copy) NSString *chatStatus;
@property (nonatomic,copy) NSString *roomNotice;
@property (nonatomic,copy) NSString *anchorNotice;
@property (nonatomic,copy) NSString *roomCover;
@property (nonatomic,copy) NSString *roomCoverType;
@property (nonatomic,copy) NSString *editTime;
@property (nonatomic,copy) NSString *addTime;
@property (nonatomic,copy) NSString *videoIdKey;
@property (nonatomic,copy) NSDictionary *flashvars;
// flashvar的属性
@property (nonatomic,copy) NSString *Servers;
@property (nonatomic,copy) NSArray *ServerIp;
@property (nonatomic,copy) NSArray *ServerPort;
@property (nonatomic,copy) NSArray *ChatRoomId;
@property (nonatomic,copy) NSString *VideoLevels;
@property (nonatomic,copy) NSString *cdns;
@property (nonatomic,copy) NSString *Status;// 可能数字
@property (nonatomic,copy) NSString *RoomId;// 可能是数字
@property (nonatomic,assign) BOOL ComLayer;// true
@property (nonatomic,copy) NSString *VideoTitle;
@property (nonatomic,copy) NSString *WebHost;
@property (nonatomic,copy) NSString *VideoType;
@property (nonatomic,copy) NSString *GameId;// 可能是数字
@property (nonatomic,copy) NSString *Online;// 可能是数字
@property (nonatomic,copy) NSString *pv;
@property (nonatomic,copy) NSString *turistRate;// 可能是数字
@property (nonatomic,copy) NSString *UseStIp;// 可能是数字
@property (nonatomic,copy) NSString *useLsIp;// 可能是数字
@property (nonatomic,copy) NSString *Oversee2;// 可能是数字
@property (nonatomic,copy) NSString *Zqad;// 可能是数字
@property (nonatomic,copy) NSString *DlLogo;// 可能是数字
// flashvar属性结束

@property (nonatomic,copy) NSString *gameName;
@property (nonatomic,copy) NSString *gameUrl;
@property (nonatomic,copy) NSString *gameIcon;
@property (nonatomic,copy) NSString *gameBpic;
@property (nonatomic,copy) NSDictionary *permission;
// permission属性
@property (nonatomic,assign) BOOL fans;
@property (nonatomic,assign) BOOL guess;
@property (nonatomic,assign) BOOL replay;
@property (nonatomic,assign) BOOL multi;
@property (nonatomic,assign) BOOL shift;
@property (nonatomic,assign) BOOL video;
// permission属性结束
@property (nonatomic,copy) NSString *fansTitle;
@property (nonatomic,copy) NSString *translateLanguages;
@property (nonatomic,copy) NSDictionary *anchorAttr;
// anchorAttr的属性
@property (nonatomic,copy) NSArray *hots;
//hots 的属性
@property (nonatomic,copy) NSString *hotslevel;// (level)
@property (nonatomic,copy) NSString *fight;
@property (nonatomic,copy) NSString *nowLevelStart;
@property (nonatomic,copy) NSString *nextLevelFight;
// hots 和anchorAttr属性结束

@property (nonatomic,copy) NSString *follows;// 可能是数字
@property (nonatomic,copy) NSString *fansNumber;// 可能是数字(fans)
@property (nonatomic,copy) NSDictionary *isStar;
// isStar的属性
@property (nonatomic,copy) NSString *isWeek;
@property (nonatomic,copy) NSString *isMonth;


@property (nonatomic,assign) BOOL *bonus;

@end
