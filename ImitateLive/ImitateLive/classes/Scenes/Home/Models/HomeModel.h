//
//  HomeModel.h
//  ImitateLive
//
//  Created by lanou3g on 16/7/12.
//  Copyright © 2016年 SJH. All rights reserved.
//

#import "BaseModel.h"

@interface HomeModel : BaseModel

// 首页面
// data下的字典
@property (nonatomic,copy) NSString *homeID;// 首页第一个ID(id)
@property (nonatomic,copy) NSString *keyword;//
@property (nonatomic,copy) NSString *title;// 分块的主题
@property (nonatomic,copy) NSString *icon;//  分区图标
@property (nonatomic,copy) NSString *rtype;//
@property (nonatomic,copy) NSString *channelIds;//
@property (nonatomic,copy) NSString *roomIds;//
@property (nonatomic,copy) NSString *gameIds;//
@property (nonatomic,copy) NSString *customLink;//
@property (nonatomic,copy) NSString *moreUrl;//
@property (nonatomic,copy) NSString *nums;//
@property (nonatomic,copy) NSString *weight;//
@property (nonatomic,copy) NSArray *anchors;//
@property (nonatomic,copy) NSString *token;//
@property (nonatomic,copy) NSArray *lists;//


@end
