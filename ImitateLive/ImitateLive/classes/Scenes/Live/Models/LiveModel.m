//
//  LiveModel.m
//  ImitateLive
//
//  Created by ssx on 16/7/12.
//  Copyright © 2016年 SJH. All rights reserved.
//

#import "LiveModel.h"

#define kLiveID @"liveID"// (id)
#define kUid @"uid"
#define kNickname @"nickname"// 下方的姓名
#define kGender @"gender"// 性别使用1和2分别
#define kAvatar @"avatar"
#define kCode @"code"
#define kDomain @"domain"
#define kUrl @"url"
#define kTitle @"title"// 标题
#define kGameId @"gameId"
#define kSpic @"spic"// 截图
#define kBpic @"bpic"
#define kOnline @"online"// 在线人数
#define kStatus @"status"
#define kLevel @"level"
#define kLiveTime @"liveTime"
#define kHostLevel @"hotsLevel"
#define kVideoId @"videoId"
#define kVerscr @"verscr"
#define kGameName @"gameName"
#define kGameUrl @"gameUrl"
#define kGameIcon @"gameIcon"
#define kHighlight @"highlight"// 可能是数字
#define kFireworks @"fireworks"
#define kFireworksHtml @"fireworksHtml"


@implementation LiveModel

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:_liveID forKey:kLiveID];
    [aCoder encodeObject:_uid forKey:kUid];
    [aCoder encodeObject:_nickname forKey:kNickname];
    [aCoder encodeObject:_gender forKey:kGender];
    [aCoder encodeObject:_avatar forKey:kAvatar];
    [aCoder encodeObject:_code forKey:kCode];
    [aCoder encodeObject:_domain forKey:kDomain];
    [aCoder encodeObject:_url forKey:kUrl];
    [aCoder encodeObject:_title forKey:kTitle];
    [aCoder encodeObject:_gameId forKey:kGameId];
    [aCoder encodeObject:_spic forKey:kSpic];
    [aCoder encodeObject:_bpic forKey:kBpic];
    [aCoder encodeObject:_online forKey:kOnline];
    [aCoder encodeObject:_status forKey:kStatus];
    [aCoder encodeObject:_level forKey:kLevel];
    [aCoder encodeObject:_liveTime forKey:kLiveTime];
    [aCoder encodeObject:_hotsLevel forKey:kHostLevel];
    [aCoder encodeObject:_videoId forKey:kVideoId];
    [aCoder encodeObject:_verscr forKey:kVerscr];
    [aCoder encodeObject:_gameName forKey:kGameName];
    [aCoder encodeObject:_gameUrl forKey:kGameUrl];
    [aCoder encodeObject:_gameIcon forKey:kGameIcon];
    [aCoder encodeObject:_highlight forKey:kHighlight];
    [aCoder encodeObject:_fireworks forKey:kFireworks];
    [aCoder encodeObject:_fireworksHtml forKey:kFireworksHtml];
    
}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.liveID = [aDecoder decodeObjectForKey:kLiveID];
        self.uid = [aDecoder decodeObjectForKey:kUid];
        self.nickname = [aDecoder decodeObjectForKey:kNickname];
        self.gender = [aDecoder decodeObjectForKey:kGender];
        self.avatar = [aDecoder decodeObjectForKey:kAvatar];
        self.code = [aDecoder decodeObjectForKey:kCode];
        self.domain = [aDecoder decodeObjectForKey:kDomain];
        self.url = [aDecoder decodeObjectForKey:kUrl];
        self.title = [aDecoder decodeObjectForKey:kTitle];
        self.gameId = [aDecoder decodeObjectForKey:kGameId];
        self.spic  = [aDecoder decodeObjectForKey:kSpic];
        self.bpic = [aDecoder decodeObjectForKey:kBpic];
        self.online = [aDecoder decodeObjectForKey:kOnline];
        self.status = [aDecoder decodeObjectForKey:kStatus];
        self.level = [aDecoder decodeObjectForKey:kLevel];
        self.liveTime = [aDecoder decodeObjectForKey:kLiveTime];
        self.hotsLevel = [aDecoder decodeObjectForKey:kHostLevel];
        self.videoId = [aDecoder decodeObjectForKey:kVideoId];
        self.verscr = [aDecoder decodeObjectForKey:kVerscr];
        self.gameName = [aDecoder decodeObjectForKey:kGameName];
        self.gameUrl = [aDecoder decodeObjectForKey:kGameUrl];
        self.gameIcon = [aDecoder decodeObjectForKey:kGameIcon];
        self.highlight = [aDecoder decodeObjectForKey:kHighlight];
        self.fireworks = [aDecoder decodeObjectForKey:kFireworks];
        self.fireworksHtml = [aDecoder decodeObjectForKey:kFireworksHtml];
        
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        _liveID = value;
    }
    
}

@end
