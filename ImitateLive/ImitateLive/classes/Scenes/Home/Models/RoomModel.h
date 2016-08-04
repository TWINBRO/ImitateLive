//
//  RoomModel.h
//  ImitateLive
//
//  Created by ssx on 16/7/15.
//  Copyright © 2016年 SJH. All rights reserved.
//

#import "BaseModel.h"

@interface RoomModel : BaseModel
// room下的属性
@property (nonatomic,copy) NSString *roomID;// (id)
@property (nonatomic,copy) NSString *uid;//
@property (nonatomic,copy) NSString *nickname;
@property (nonatomic,copy) NSString *gender;
@property (nonatomic,copy) NSString *avatar;
@property (nonatomic,copy) NSString *code;
@property (nonatomic,copy) NSString *domain;
@property (nonatomic,copy) NSString *roomUrl;//(url)
@property (nonatomic,copy) NSString *roomTitle;// (title)
@property (nonatomic,copy) NSString *roomGameId;// (gameId)
@property (nonatomic,copy) NSString *roomSpic;// (spic)
@property (nonatomic,copy) NSString *roomBpic;//(bpic)
@property (nonatomic,copy) NSString *roomTemplate;// (template)
@property (nonatomic,copy) NSString *online;
@property (nonatomic,copy) NSString *roomWeight;//(weight)
@property (nonatomic,copy) NSString *status;
@property (nonatomic,copy) NSString *level;
@property (nonatomic,copy) NSString *hotsLevel;
@property (nonatomic,copy) NSString *type;
@property (nonatomic,copy) NSString *liveTime;
@property (nonatomic,copy) NSString *verscr;
@property (nonatomic,copy) NSString *allowRecord;
@property (nonatomic,copy) NSString *allowVideo;
@property (nonatomic,copy) NSString *publishUrl;
@property (nonatomic,copy) NSString *videoId;
@property (nonatomic,copy) NSString *chatStatus;
@property (nonatomic,copy) NSString *roomNotice;
@property (nonatomic,copy) NSString *anchorNotice;
@property (nonatomic,copy) NSString *roomCover;
@property (nonatomic,copy) NSString *roomCoverType;
@property (nonatomic,copy) NSString *editTime;
@property (nonatomic,copy) NSString *addTime;
@property (nonatomic,copy) NSString *videoIdKey;
@property (nonatomic,copy) NSString *gameUrl;
@property (nonatomic,copy) NSString *gameIcon;
@property (nonatomic,copy) NSString *gameBpic;
@property (nonatomic,copy) NSString *fansTitle;
@property (nonatomic,copy) NSString *translateLanguages;
@property (nonatomic,copy) NSString *follows;
@property (nonatomic,copy) NSString *fans;
@property (nonatomic,copy) NSDictionary *isStar;
@end
