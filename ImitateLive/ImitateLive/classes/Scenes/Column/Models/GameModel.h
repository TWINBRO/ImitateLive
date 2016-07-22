//
//  GameModel.h
//  ImitateLive
//
//  Created by lanou3g on 16/7/12.
//  Copyright © 2016年 SJH. All rights reserved.
//

#import "BaseModel.h"

@interface GameModel : BaseModel

// game的属性
@property (nonatomic,copy) NSString *gameID;//(id)
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *gameKey;
@property (nonatomic,copy) NSString *spic;// (spic)长图片
@property (nonatomic,copy) NSString *bpic;// (bpic)宽图片
@property (nonatomic,copy) NSString *icon;// L图标
@property (nonatomic,copy) NSString *watchs;
@property (nonatomic,copy) NSDictionary *desc;

// desc的属性
//@property (nonatomic,copy) NSString *系统;
//@property (nonatomic,copy) NSString *平台;
//@property (nonatomic,copy) NSString *简介;
// desc属性结束

@property (nonatomic,copy) NSString *weight;// 
@property (nonatomic,copy) NSString *status;
@property (nonatomic,copy) NSString *fid;
@property (nonatomic,copy) NSString *url;//

@end
