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
    self.topBackgroundView = [self viewWithFrame:CGRectMake(0, 0, kWidth, 50) backgroundColor:YD_COLOR(115, 115, 115, 0.5) superView:self];
    self.bottomBackgroundView = [self viewWithFrame:CGRectMake(0, kHeight - 50, kWidth, 50) backgroundColor:YD_COLOR(115, 115, 115, 0.5) superView:self];
    self.backBtn = [self buttonWithImage:@"Movie_back_s@2x" frame:CGRectMake(10, 10, 48, 48) action:@selector(backAction:) superView:self.topBackgroundView corner:YES];
    self.playOrPauseBtn = [self buttonWithImage:@"" frame:CGRectMake(10, 0, 48, 48) action:@selector(playOrPauseAction:) superView:self.bottomBackgroundView corner:YES];
    self.lockScreenBtn = [self buttonWithImage:@"" frame:CGRectMake(10, kHeight / 2.0 - 30, 40, 40) action:@selector(lockScreenAction:)  superView:self corner:YES];
    self.fullScreenBtn = [self buttonWithImage:@"" frame: CGRectMake(kWidth - 47, 0, 37, 37) action:@selector(fullScreenAction:)  superView:self.bottomBackgroundView corner:YES];
    self.titleLabel = [self labelWithTitle:@"" color:[UIColor whiteColor] frame:CGRectMake(60, 10, 300, 30) superView:self.topBackgroundView];
    self.onlineLabel = [self labelWithTitle:@"" color:[UIColor whiteColor] frame:CGRectMake(kWidth - 60, 100, 50, 40) superView:self];
    self.onlineImage = [[UIImageView alloc] initWithFrame:CGRectMake(kWidth - 100, 100, 36, 36)];
    self.onlineImage.image = [UIImage imageNamed:@"ic_account@2x"];
    [self addSubview:self.onlineImage];
}

- (void)addLiveControl
{
    self.shareBtn = [self buttonWithImage:@"" frame:CGRectMake(kWidth - 48, kHeight / 2.0, 40, 40) action:@selector(shareAction:) superView:self corner:YES];
    
    self.settingBtn = [self buttonWithImage:@"" frame:CGRectMake(kWidth - 55, 10, 48, 48) action:@selector(settingAction:) superView:self.topBackgroundView corner:YES];
    self.definitionBtn = [self buttonWithImage:@"btn_cq_pressed@2x" frame:CGRectMake(kWidth - 105, 10, 40, 40) action:@selector(definitionAction:) superView:self.topBackgroundView corner:NO];
    self.isBarrage = [self buttonWithImage:@"" frame:CGRectMake(kWidth - 100, 0, 37, 37) action:@selector(isBarrageAction:) superView:self.bottomBackgroundView corner:NO];
    self.sendBtn = [self buttonWithImage:@"" frame:CGRectMake(kWidth - 150, 0, 50, 37) action:@selector(sendBarrageAction:) superView:self.bottomBackgroundView corner:NO];
    self.barrageTextField = [[UITextField alloc] initWithFrame:CGRectMake(60, 0, kWidth - 60 - 150, 37)];
    self.barrageTextField.backgroundColor = [UIColor greenColor];
    self.barrageTextField.borderStyle = UITextBorderStyleRoundedRect;
    [self.bottomBackgroundView addSubview:self.barrageTextField];
    
}
- (void)addHistoryControl
{
    self.nowTimeLabel = [self labelWithTitle:@"00:00:00" color:[UIColor whiteColor] frame:CGRectMake(50, 35, 100, 15) superView:self.bottomBackgroundView];
    self.longTimeLabel = [self labelWithTitle:@"" color:[UIColor whiteColor] frame:CGRectMake(self.frame.size.width - 150, 35, 100, 15) superView:self.bottomBackgroundView];
    self.progressSlider = [[UISlider alloc] initWithFrame:CGRectMake(50, 6, self.frame.size.width - 97, 20)];
    self.progressSlider.maximumValue = 1.0;
    [self.progressSlider setMaximumTrackTintColor:[UIColor grayColor]];
    [self.progressSlider setMinimumTrackTintColor:[UIColor greenColor]];
    [self.progressSlider setThumbTintColor:[UIColor whiteColor]];
    [self.progressSlider addTarget:self action:@selector(progressSliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.bottomBackgroundView addSubview:self.progressSlider];
}
// 创建按钮
- (UIButton *)buttonWithImage:(NSString *)image frame:(CGRect)frame action:(SEL)action superView:(UIView *)view corner:(BOOL)corner
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor whiteColor];
    if (corner) {
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = frame.size.width / 2.0;
    }
    
    button.frame = frame;
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
- (UILabel *)labelWithTitle:(NSString *)title color:(UIColor *)color frame:(CGRect)frame superView:(UIView *)view
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = title;
    label.font = [UIFont systemFontOfSize:15.0];
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
