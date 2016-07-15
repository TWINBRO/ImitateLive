//
//  RequestUrl.h
//  LessonDouBan
//
//  Created by lanou3g on 16/6/27.
//  Copyright © 2016年 yu. All rights reserved.
//

#ifndef RequestUrl_h
#define RequestUrl_h
// 首页请求url
#define HomeRequest_Url @"http://www.zhanqi.tv/api/static/live.index/recommend-new.json?os=1&ver=3.1.4"
// 轮播图请求url
#define CarouselRequest_Url @"http://www.zhanqi.tv/api/touch/apps.banner?os=1&ver=3.1.4"

// 直播间详情请求url
#define LiveDetailRequest_Url(ID) [NSString stringWithFormat:@"http://www.zhanqi.tv/api/static/live.roomid/%@.json?os=1&sid=&ver=3.1.4",ID]

// 直播间主播历史视频请求url
#define AuthorHistoryVideoRequest_Url(ID) [NSString stringWithFormat:@"http://www.zhanqi.tv/api/static/video.anchor_hots/%@-20-1.json?os=1&ver=3.1.4 ",ID]

// 所有栏目请求Url
#define AllColumnRequest_Url(ID) [NSString stringWithFormat:@"http://www.zhanqi.tv/api/static/game.lists/18-%@.json?ver=2.7.1&os=3&time1468331065160",ID]
//
// 栏目详情请求Url
#define ColumnDetailRequest_Url(ID) [NSString stringWithFormat:@"http://www.zhanqi.tv/api/static/game.lives/%@.json?ver=2.7.1&os=3&time1468306552272",ID]

// 直播页面请求Url
#define LiveRequest_Url(ID) [NSString stringWithFormat:@"http://www.zhanqi.tv/api/static/live.hots/20-%@.json?os=1&ver=3.1.4",ID]

// 登录接口
#define LoginRequest_Url @"http://162.211.125.85/douban/user.php/DLogin"
// 注册接口
#define RegisterRequest_Url @"http://162.211.125.85/douban/user.php/DRegister"

//头像根路径
#define USER_AVATAR_LOCAL_URL @"http://162.211.125.85"

#endif /* RequestUrl_h */
