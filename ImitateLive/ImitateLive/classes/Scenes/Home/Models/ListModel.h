//
//  ListModel.h
//  ImitateLive
//
//  Created by ssx on 16/7/12.
//  Copyright © 2016年 SJH. All rights reserved.
//

#import "BaseModel.h"

@interface ListModel : BaseModel
// list下的属性
//@property (nonatomic,copy) NSString *listsID;//(id)
@property (nonatomic,copy) NSString *liveID;
@property (nonatomic,copy) NSString *uid;
@property (nonatomic,copy) NSString *nickname;// 主播姓名
@property (nonatomic,copy) NSString *gender;// 性别
@property (nonatomic,copy) NSString *avatar;//
@property (nonatomic,copy) NSString *code;//
@property (nonatomic,copy) NSString *domain;
@property (nonatomic,copy) NSString *url;//
@property (nonatomic,copy) NSString *title;// 标题
@property (nonatomic,copy) NSString *gameId;//
@property (nonatomic,copy) NSString *spic;//
@property (nonatomic,copy) NSString *bpic;
@property (nonatomic,copy) NSString *online;// 在线人数
@property (nonatomic,copy) NSString *status;
@property (nonatomic,copy) NSString *level;
@property (nonatomic,copy) NSString *liceTime;
@property (nonatomic,copy) NSString *hotsLevel;
@property (nonatomic,copy) NSString *videoId;
@property (nonatomic,copy) NSString *verscr;
@property (nonatomic,copy) NSString *gameName;
@property (nonatomic,copy) NSString *gameUrl;
@property (nonatomic,copy) NSString *gameIcon;
@property (nonatomic,copy) NSString *highlight;
@property (nonatomic,copy) NSString *fireworks;
@property (nonatomic,copy) NSString *fireworksHtml;

@end
