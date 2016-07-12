//
//  ColumnModel.h
//  ImitateLive
//
//  Created by lanou3g on 16/7/12.
//  Copyright © 2016年 SJH. All rights reserved.
//

#import "BaseModel.h"

@interface ColumnModel : BaseModel

// 分类界面
// data下的数据
@property (nonatomic,copy) NSString *columnID;//(id)
@property (nonatomic,copy) NSString *position;//
@property (nonatomic,copy) NSString *chnId;
@property (nonatomic,copy) NSString *roomId;
@property (nonatomic,copy) NSString *matchId;
@property (nonatomic,copy) NSString *gameId;// 进入下一界面所有id
@property (nonatomic,copy) NSString *spic;// 圆形的图片
@property (nonatomic,copy) NSString *bpic;
@property (nonatomic,copy) NSString *title;// 标题
@property (nonatomic,copy) NSString *url;
@property (nonatomic,copy) NSString *contents;
@property (nonatomic,copy) NSString *startTime;
@property (nonatomic,copy) NSString *endTime;
@property (nonatomic,copy) NSString *weight;
@property (nonatomic,copy) NSString *positionType;
@property (nonatomic,copy) NSDictionary *game;
// game的属性
@property (nonatomic,copy) NSString *gameID;//(id)
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *gameKey;
@property (nonatomic,copy) NSString *gameSpic;// (spic)长图片
@property (nonatomic,copy) NSString *gameBpic;// (bpic)宽图片
@property (nonatomic,copy) NSString *icon;// L图标
@property (nonatomic,copy) NSString *watchs;
@property (nonatomic,copy) NSDictionary *desc;
// desc的属性
@property (nonatomic,copy) NSString *系统;
@property (nonatomic,copy) NSString *平台;
@property (nonatomic,copy) NSString *简介;
// desc属性结束

@property (nonatomic,copy) NSString *gameWeight;// (weight)
@property (nonatomic,copy) NSString *status;
@property (nonatomic,copy) NSString *fid;
@property (nonatomic,copy) NSString *gameUrl;// (url)

@end
