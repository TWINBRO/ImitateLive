//
//  LittleInteractiveView.m
//  ImitateLive
//
//  Created by ssx on 16/7/13.
//  Copyright © 2016年 SJH. All rights reserved.
//

#import "LittleInteractiveView.h"

@implementation LittleInteractiveView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addButton];
        [self timeBegin];
    }
    return self;
}

- (void)timeBegin
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeAction:) userInfo:nil repeats:YES];
}
- (void)timeAction:(NSTimer *)timer
{
    
}
- (void)addButton
{
    self.backBtn = [self buttonWithImage:@"movie_back@2x" frame:CGRectMake(10, 20, 25, 25) backGroundColor:YD_COLOR(0, 0, 0, 0.5) action:@selector(backAction:) superView:self corner:YES];
    self.fullScreenBtn = [self buttonWithImage:@"movie_fullscreen@2x" frame:CGRectMake(self.frame.size.width - 36, self.frame.size.height - 47, 25, 25) backGroundColor:YD_COLOR(0, 0, 0, 0.5) action:@selector(fullScreenAction:) superView:self corner:YES];
    self.shareBtn = [self buttonWithImage:@"分享" frame:CGRectMake(self.frame.size.width - 36, self.frame.size.height / 2.0, 25, 25) backGroundColor:YD_COLOR(0, 0, 0, 0.5) action:@selector(shareAction:) superView:self corner:NO];
    self.shareBtn.layer.masksToBounds = YES;
    self.shareBtn.layer.cornerRadius = 5;
    self.bottonView = [self viewWithFrame:CGRectMake(0, self.frame.size.height - 50, self.frame.size.width, 50) backgroundColor:[UIColor whiteColor] superView:self];
    self.playOrPauseBtn = [self buttonWithImage:@"movie_pausesmall@2x" frame:CGRectMake(10, 3, 37, 37) backGroundColor:YD_COLOR(115, 115, 115, 0.5) action:@selector(playOrPauseAction:) superView:self.bottonView corner:NO];
    self.nowTimeLabel = [self labelWithTitle:@"00:00:00" color:[UIColor whiteColor] frame:CGRectMake(50, 35, 100, 15) superView:self.bottonView];
    self.longTimeLabel = [self labelWithTitle:@"" color:[UIColor whiteColor] frame:CGRectMake(self.frame.size.width - 150, 35, 100, 15) superView:self.bottonView];
    self.progressSlider = [[UISlider alloc] initWithFrame:CGRectMake(50, 6, self.frame.size.width - 97, 20)];
    self.progressSlider.maximumValue = 1.0;
    [self.progressSlider setMaximumTrackTintColor:[UIColor grayColor]];
    [self.progressSlider setMinimumTrackTintColor:[UIColor greenColor]];
    [self.progressSlider setThumbTintColor:[UIColor whiteColor]];
    [self.progressSlider addTarget:self action:@selector(progresssliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.bottonView addSubview:self.progressSlider];
}
// 创建按钮
- (UIButton *)buttonWithImage:(NSString *)image frame:(CGRect)frame backGroundColor:(UIColor *)backColor action:(SEL)action superView:(UIView *)view corner:(BOOL)corner
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    button.backgroundColor = backColor;
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
    label.backgroundColor = color;
    label.font = [UIFont systemFontOfSize:15.0];
//    label.textAlignment = NSTextAlignmentLeft;// 对齐方式
    [view addSubview:label];
    return label;
}
// 按钮点击方法
- (void)backAction:(UIButton *)btn
{
    if (_delegate) {
        [_delegate backLastViewController:btn];
    }
}
- (void)fullScreenAction:(UIButton *)btn
{
    if (_delegate) {
        [_delegate fullScreenAction:btn];
    }
}
- (void)shareAction:(UIButton *)btn
{
    if (_delegate) {
        [_delegate shareVideoAction:btn];
    }
}
- (void)playOrPauseAction:(UIButton *)btn
{
    if (_delegate) {
        [_delegate playOrPauseAction:btn];
    }
}
// 进度条代理
- (void)progresssliderValueChanged:(UISlider *)progress
{
    if (_delegate) {
        [_delegate progressSLiderValueChanged:progress];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.hidden = NO;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
