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



@end
