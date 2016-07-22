//
//  BigInteractiveView.m
//  ImitateLive
//
//  Created by lanou3g on 16/7/13.
//  Copyright © 2016年 SJH. All rights reserved.
//

#import "BigInteractiveView.h"

#define kWidth self.frame.size.width
#define kHeight self.frame.size.height
#define kTopBackViewWidth self.topBackgroundView.frame.size.width
#define kTopBackViewHeight self.topBackgroundView.frame.size.height
#define kBottomBackViewWidth self.bottomBackgroundView.frame.size.width
#define kBottomBackViewHeight self.bottomBackgroundView.frame.size.height

@interface BigInteractiveView ()



@end

@implementation BigInteractiveView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addAlwaysControl];
        if (self.isHistory) {
            [self addHistoryControl];
        }else{
            [self addLiveControl];
        }
    }
    return self;
}

- (void)addAlwaysControl
{
    self.topBackgroundView = [self viewWithFrame:CGRectMake(0, 0, kWidth, 50) backgroundColor:YD_COLOR(0, 0, 0, 0.5) superView:self];
    self.bottomBackgroundView = [self viewWithFrame:CGRectMake(0, kHeight - 50, kWidth, 50) backgroundColor:YD_COLOR(0, 0, 0, 0.5) superView:self];
    self.backBtn = [self buttonWithImage:@"Movie_back@2x" frame:CGRectMake(6, 6, 40, 40) center:CGPointMake(26, kTopBackViewHeight / 2.0) backgroundColor:[UIColor clearColor] action:@selector(backAction:) superView:self.topBackgroundView corner:YES];
    self.playOrPauseBtn = [self buttonWithImage:@"movie_pausesmall@2x" frame:CGRectMake(4, 0, 40, 40) center:CGPointMake(26, kBottomBackViewHeight / 2.0) backgroundColor:[UIColor clearColor] action:@selector(playOrPauseAction:) superView:self.bottomBackgroundView corner:YES];
    self.lockScreenBtn = [self buttonWithImage:@"movie_unlock@2x" frame:CGRectMake(10, kHeight / 2.0 - 30, 40, 40) center:CGPointMake(26, kHeight / 2.0) backgroundColor:YD_COLOR(0, 0, 0, 0.5) action:@selector(lockScreenAction:)  superView:self corner:YES];
    self.fullScreenBtn = [self buttonWithImage:@"movie_mini@2x" frame: CGRectMake(kWidth - 47, 0, 40, 40) center:CGPointMake(kWidth - 24, kBottomBackViewHeight / 2.0) backgroundColor:[UIColor clearColor] action:@selector(fullScreenAction:)  superView:self.bottomBackgroundView corner:YES];
    self.titleLabel = [self labelWithTitle:@"" color:[UIColor clearColor] textColor:[UIColor whiteColor] fontSize:15.0 frame:CGRectMake(40, 10, 300, 30) superView:self.topBackgroundView];
    self.onlineLabel = [self labelWithTitle:@"" color:YD_COLOR(0, 0, 0, 0.75) textColor:[UIColor whiteColor] fontSize:15.0 frame:CGRectMake(kWidth - 84, 100, 70, 36) superView:self];
    self.onlineImage = [[UIImageView alloc] initWithFrame:CGRectMake(kWidth - 120, 100, 36, 36)];
    self.onlineImage.backgroundColor = YD_COLOR(0, 0, 0, 0.75);
    self.onlineImage.image = [UIImage imageNamed:@"ic_account@2x"];
    [self addSubview:self.onlineImage];
    
    self.volumnImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    self.volumnImage.center = CGPointMake(kWidth / 2.0, kHeight / 2.0);
    [self addSubview:self.volumnImage];
    
}

- (void)addLiveControl
{
    self.shareBtn = [self buttonWithImage:@"分享" frame:CGRectMake(kWidth - 48, kHeight / 2.0, 38, 38) center:CGPointMake(kWidth - 26, kHeight / 2.0) backgroundColor:YD_COLOR(0, 0, 0, 0.5) action:@selector(shareAction:) superView:self corner:NO];
    self.shareBtn.layer.masksToBounds = YES;
    self.shareBtn.layer.cornerRadius = 4;
    self.settingBtn = [self buttonWithImage:@"movie_setting@2x" frame:CGRectMake(kWidth - 55, 5, 40, 40) center:CGPointMake(kWidth - 22, kTopBackViewHeight / 2.0) backgroundColor:[UIColor clearColor] action:@selector(settingAction:) superView:self.topBackgroundView corner:YES];
    self.definitionBtn = [self buttonWithImage:@"btn_cq_pressed@2x" frame:CGRectMake(kWidth - 105, 10, 50, 40) center:CGPointMake(kWidth - 70, kTopBackViewHeight / 2.0) backgroundColor:[UIColor clearColor] action:@selector(definitionAction:) superView:self.topBackgroundView corner:NO];
    self.isBarrage = [self buttonWithImage:@"movie_subtitle_on@2x" frame:CGRectMake(kWidth - 100, 0, 40, 40) center:CGPointMake(kWidth - 70, kBottomBackViewHeight / 2.0) backgroundColor:[UIColor clearColor] action:@selector(isBarrageAction:)  superView:self.bottomBackgroundView corner:NO];
    
    self.sendBtn = [self buttonWithImage:@"" frame:CGRectMake(70, 0, kWidth - 180, 40) center:CGPointMake(kWidth / 2.0 - 30, kBottomBackViewHeight / 2.0) backgroundColor:[UIColor whiteColor] action:@selector(sendBarrageAction:) superView:self.bottomBackgroundView corner:NO];
    [self.sendBtn setTitle:@"发送弹幕呗😃" forState:UIControlStateNormal];
    self.sendBtn.titleLabel.textColor = [UIColor blackColor];
    
}
- (void)addHistoryControl
{
    self.nowTimeLabel = [self labelWithTitle:@"00:00:00" color:[UIColor whiteColor] textColor:[UIColor whiteColor] fontSize:15.0 frame:CGRectMake(50, 35, 100, 15) superView:self.bottomBackgroundView];
    self.longTimeLabel = [self labelWithTitle:@"" color:[UIColor whiteColor] textColor:[UIColor whiteColor] fontSize:15.0 frame:CGRectMake(self.frame.size.width - 150, 35, 100, 15) superView:self.bottomBackgroundView];
    self.progressSlider = [[UISlider alloc] initWithFrame:CGRectMake(50, 6, self.frame.size.width - 97, 20)];
    self.progressSlider.maximumValue = 1.0;
    [self.progressSlider setMaximumTrackTintColor:[UIColor grayColor]];
    [self.progressSlider setMinimumTrackTintColor:[UIColor greenColor]];
    [self.progressSlider setThumbTintColor:[UIColor whiteColor]];
    [self.progressSlider addTarget:self action:@selector(progressSliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.bottomBackgroundView addSubview:self.progressSlider];
    
    // 快进快退label
    self.horizontalLabel = [self labelWithTitle:@"" color:YD_COLOR(115, 115, 115, 0.5) textColor:[UIColor whiteColor] fontSize:15.0 frame:CGRectMake(kWidth / 2, kHeight / 2, 100, 50) superView:self];
    self.horizontalLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ZFPlayer_management_mask"]];
    
}

// 创建按钮
- (UIButton *)buttonWithImage:(NSString *)image frame:(CGRect)frame center:(CGPoint)center backgroundColor:(UIColor *)backColor action:(SEL)action superView:(UIView *)view corner:(BOOL)corner
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    button.backgroundColor = backColor;
    if (corner) {
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = frame.size.width / 2.0;
    }
    button.frame = frame;
    button.center = center;
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    return button;
}
// 创建视图
- (UIView *)viewWithFrame:(CGRect)frame backgroundColor:(UIColor *)color superView:(UIView *)superView
{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = color;
    [superView addSubview:view];
    return view;
}
// 创建label
- (UILabel *)labelWithTitle:(NSString *)title color:(UIColor *)color textColor:(UIColor *)textColor fontSize:(CGFloat)fontSize frame:(CGRect)frame superView:(UIView *)view
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = title;
    label.font = [UIFont systemFontOfSize:fontSize];
    label.textColor = textColor;
    label.textAlignment = NSTextAlignmentLeft;
    label.backgroundColor = color;
    [view addSubview:label];
    return label;
}
// 按钮点击方法
// 点击锁屏按钮
- (void)lockScreenAction:(UIButton *)btn
{
    if (_delegate) {
        [_delegate lockScreenAction:btn];
    }
}
// 点击返回按钮
- (void)backAction:(UIButton *)btn
{
    if (_delegate) {
        [_delegate backLastViewController:btn];
    }
}
// 点击播放按钮
- (void)playOrPauseAction:(UIButton *)btn
{
    if (_delegate) {
        [_delegate playOrPauseAction:btn];
    }
}
// 点击设置按钮
- (void)settingAction:(UIButton *)btn
{
    if (_delegate) {
        [_delegate settingAction:btn];
    }
}
#pragma mark --点击全屏按钮
- (void)fullScreenAction:(UIButton *)btn
{
    if (_delegate) {
        [_delegate fullScreenAction:btn];
    }
}
// 点击分享按钮
- (void)shareAction:(UIButton *)btn
{
    if (_delegate) {
        [_delegate shareVideoAction:btn];
    }
}
// 点击发送按钮
- (void)sendBarrageAction:(UIButton *)btn
{
    if (_delegate) {
        [_delegate sendBarrageAction:btn];
    }
}
// 点击高清按钮
- (void)definitionAction:(UIButton *)btn
{
    if (_delegate) {
        [_delegate definitionAction:btn];
    }
}
// 点击打开弹幕按钮
- (void)isBarrageAction:(UIButton *)btn
{
    if (_delegate) {
        [_delegate isBarrageAction:btn];
    }
}

// 进度条代理
- (void)progressSliderValueChanged:(UISlider *)progress
{
    if (_delegate) {
        [_delegate progressSLiderValueChangedAction:progress];
    }
}

- (UIActivityIndicatorView *)activity
{
    if (!_activity) {
        _activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    }
    return _activity;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
