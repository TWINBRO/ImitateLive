//
//  LiveModel.h
//  ImitateLive
//
//  Created by ssx on 16/7/12.
//  Copyright © 2016年 SJH. All rights reserved.
//

#import "BaseModel.h"
#import <UIKit/UIKit.h>
@interface LiveModel : BaseModel <NSCoding>

// 直播界面
// data下的属性
//@property (nonatomic,copy) NSString *cnt;// 可能是数字
//@property (nonatomic,copy) NSArray *rooms;
// rooms的属性
@property (nonatomic,copy) NSString *liveID;// (id)
@property (nonatomic,copy) NSString *uid;
@property (nonatomic,copy) NSString *nickname;// 下方的姓名
@property (nonatomic,copy) NSString *gender;// 性别使用1和2分别
@property (nonatomic,copy) NSString *avatar;
@property (nonatomic,copy) NSString *code;
@property (nonatomic,copy) NSString *domain;
@property (nonatomic,copy) NSString *url;
@property (nonatomic,copy) NSString *title;// 标题
@property (nonatomic,copy) NSString *gameId;
@property (nonatomic,copy) NSString *spic;// 截图
@property (nonatomic,copy) NSString *bpic;
@property (nonatomic,copy) NSString *online;// 在线人数
@property (nonatomic,copy) NSString *status;
@property (nonatomic,copy) NSString *level;
@property (nonatomic,copy) NSString *liveTime;
@property (nonatomic,copy) NSString *hotsLevel;
@property (nonatomic,copy) NSString *videoId;
@property (nonatomic,copy) NSString *verscr;
@property (nonatomic,copy) NSString *gameName;
@property (nonatomic,copy) NSString *gameUrl;
@property (nonatomic,copy) NSString *gameIcon;
@property (nonatomic,copy) NSString *highlight;// 可能是数字
@property (nonatomic,copy) NSString *fireworks;
@property (nonatomic,copy) NSString *fireworksHtml;

@end
