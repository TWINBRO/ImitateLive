//
//  SettingView.m
//  ImitateLive
//
//  Created by lanou3g on 16/7/15.
//  Copyright © 2016年 SJH. All rights reserved.
//

#import "SettingView.h"

#define settingWidth self.frame.size.width * 2.0 / 5.0
#define settingHeight self.frame.size.height

@implementation SettingView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatViewControll];
        self.backgroundColor = YD_COLOR(115, 115, 115, 0.6);
        [self barrageSizeButton];
        [self barrageTransparency];
        [self barragePosition];
        [self timeSleep];
    }
    return self;
}

- (void)creatViewControll
{
//    NSLog(@"%lf",settingWidth);
//    NSLog(@"%lf",settingHeight);
    self.barrageSizeLabel = [self labelWithTitle:@"弹幕大小" color:[UIColor clearColor] textColot:[UIColor blackColor] frame:CGRectMake(0, 0, 100, 50) center:CGPointMake(60, settingWidth) superView:self];
    self.barrageTransparencyLabel = [self labelWithTitle:@"弹幕透明度" color:[UIColor clearColor] textColot:[UIColor blackColor] frame:CGRectMake(0, 0, 100, 50) center:CGPointMake(60, settingWidth * 2.0) superView:self];
    self.barragePositionLabel = [self labelWithTitle:@"弹幕位置" color:[UIColor clearColor] textColot:[UIColor blackColor] frame:CGRectMake(0, 0, 100, 50) center:CGPointMake(60, settingWidth * 3.0) superView:self];
    self.timeSleepLabel = [self labelWithTitle:@"定时休眠" color:[UIColor clearColor] textColot:[UIColor blackColor] frame:CGRectMake(0, 0, 100, 50) center:CGPointMake(60, settingWidth * 4.0) superView:self];
    
}
- (void)barrageSizeButton
{
    self.bigBarrageBtn = [self buttonWithImage:@"btn_setting_da_normal@2x" frame:CGRectMake(120, settingWidth -40, 80, 80) action:@selector(bigBarrageClick:) superView:self corner:NO];
    self.middleBarrageBtn = [self buttonWithImage:@"btn_setting_zhong_highlight@2x" frame:CGRectMake(210, settingWidth - 40, 80, 80) action:@selector(middleBarrageClick:) superView:self corner:NO];
    self.littleBarrageBtn = [self buttonWithImage:@"btn_setting_xiao_normal@2x" frame:CGRectMake(300, settingWidth - 40, 80, 80) action:@selector(littleBarrageClick:) superView:self corner:NO];
}
#pragma mark -- 弹幕大小按钮
- (void)bigBarrageClick:(UIButton *)btn
{
    if (_delegate) {
        [_delegate barrageSizeAction:btn size:bigBarrageSize];
        [self.bigBarrageBtn setImage:[UIImage imageNamed:@"btn_setting_da_highlight@2x"] forState:UIControlStateNormal];
        [self.middleBarrageBtn setImage:[UIImage imageNamed:@"btn_setting_zhong_normal@2x"] forState:UIControlStateNormal];
        [self.littleBarrageBtn setImage:[UIImage imageNamed:@"btn_setting_xiao_normal@2x"] forState:UIControlStateNormal];
    }
}
- (void)middleBarrageClick:(UIButton *)btn
{
    if (_delegate) {
        [_delegate barrageSizeAction:btn size:middleBarrageSize];
        [self.bigBarrageBtn setImage:[UIImage imageNamed:@"btn_setting_da_normal@2x"] forState:UIControlStateNormal];
        [self.middleBarrageBtn setImage:[UIImage imageNamed:@"btn_setting_zhong_highlight@2x"] forState:UIControlStateNormal];
        [self.littleBarrageBtn setImage:[UIImage imageNamed:@"btn_setting_xiao_normal@2x"] forState:UIControlStateNormal];
    }
}
- (void)littleBarrageClick:(UIButton *)btn
{
    if (_delegate) {
        [_delegate barrageSizeAction:btn size:littleBarrageSize];
        [self.bigBarrageBtn setImage:[UIImage imageNamed:@"btn_setting_da_normal@2x"] forState:UIControlStateNormal];
        [self.middleBarrageBtn setImage:[UIImage imageNamed:@"btn_setting_zhong_normal@2x"] forState:UIControlStateNormal];
        [self.littleBarrageBtn setImage:[UIImage imageNamed:@"btn_setting_xiao_highlight@2x"] forState:UIControlStateNormal];
    }
}
#pragma mark --弹幕透明度
- (void)barrageTransparency
{
    self.transparencySlider = [[UISlider alloc] initWithFrame:CGRectMake(120, settingWidth * 2.0 - 40, 260, 80)];
    self.transparencySlider.maximumValue = 1.0;
    [self.transparencySlider setMaximumTrackTintColor:[UIColor grayColor]];
    [self.transparencySlider setMinimumTrackTintColor:[UIColor greenColor]];
    [self.transparencySlider setThumbTintColor:[UIColor whiteColor]];
    [self.transparencySlider addTarget:self action:@selector(transparencySliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:self.transparencySlider];
}
- (void)transparencySliderValueChanged:(UISlider *)slider
{
    if (_delegate) {
        [_delegate barrageTransparencySliderValueChanged:slider];
        
    }
}
#pragma mark -- 弹幕位置按钮
- (void)barragePosition
{
    self.topScreenBtn = [self buttonWithImage:@"btn_setting_shangfgang_normal@2x" frame:CGRectMake(120, settingWidth * 3.0 - 40, 80, 80) action:@selector(topScreenClick:) superView:self corner:NO];
    self.fullScreenBtn = [self buttonWithImage:@"btn_setting_quanping_highlight@2x" frame:CGRectMake(210, settingWidth * 3.0 - 40, 80, 80) action:@selector(fullScreenClick:) superView:self corner:NO];
    self.bottomScreenBtn = [self buttonWithImage:@"btn_setting_xiafang_normal@2x" frame:CGRectMake(300, settingWidth * 3.0 - 40, 80, 80) action:@selector(bottomScreenClick:) superView:self corner:NO];
    
}
- (void)topScreenClick:(UIButton *)btn
{
    if (_delegate) {
        [_delegate barragePositionAction:btn position:topScreen];
        [self.topScreenBtn setImage:[UIImage imageNamed:@"btn_setting_shangfang_highlight@2x"] forState:UIControlStateNormal];
        [self.fullScreenBtn setImage:[UIImage imageNamed:@"btn_setting_quanping_normal@2x"] forState:UIControlStateNormal];
        [self.bottomScreenBtn setImage:[UIImage imageNamed:@"btn_setting_xiafang_normal@2x"] forState:UIControlStateNormal];
    }
}
- (void)fullScreenClick:(UIButton *)btn
{
    if (_delegate) {
        [_delegate barragePositionAction:btn position:fullScreen];
        [self.topScreenBtn setImage:[UIImage imageNamed:@"btn_setting_shangfgang_normal@2x"] forState:UIControlStateNormal];
        [self.fullScreenBtn setImage:[UIImage imageNamed:@"btn_setting_quanping_highlight@2x"] forState:UIControlStateNormal];
        [self.bottomScreenBtn setImage:[UIImage imageNamed:@"btn_setting_xiafang_normal@2x"] forState:UIControlStateNormal];
    }
}
- (void)bottomScreenClick:(UIButton *)btn
{
    if (_delegate) {
        [_delegate barragePositionAction:btn position:bottomScreen];
        [self.topScreenBtn setImage:[UIImage imageNamed:@"btn_setting_shangfgang_normal@2x"] forState:UIControlStateNormal];
        [self.fullScreenBtn setImage:[UIImage imageNamed:@"btn_setting_quanping_normal@2x"] forState:UIControlStateNormal];
        [self.bottomScreenBtn setImage:[UIImage imageNamed:@"btn_setting_xiafang_highlight@2x"] forState:UIControlStateNormal];
    }
}
#pragma mark -- 是否定时休眠
- (void)timeSleep
{
    self.timeSleepSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(120, settingWidth * 4.0 - 40, 150, 80)];
    self.timeSleepSwitch.center = CGPointMake(196, settingWidth * 4.0);
    self.timeSleepSwitch.tintColor = [UIColor magentaColor];
    self.timeSleepSwitch.onTintColor = [UIColor cyanColor];
    self.timeSleepSwitch.thumbTintColor = [UIColor redColor];
    [self.timeSleepSwitch setOn:NO];
    [self.timeSleepSwitch addTarget:self action:@selector(timeSleepSwitchAction:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:self.timeSleepSwitch];
}
- (void)timeSleepSwitchAction:(UISwitch *)timeSwitch
{
    if (_delegate) {
        [_delegate timeSleepSwitchAction:timeSwitch];
    }
}
// 创建按钮
- (UIButton *)buttonWithImage:(NSString *)image frame:(CGRect)frame  action:(SEL)action superView:(UIView *)view corner:(BOOL)corner
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
//    button.backgroundColor = [UIColor whiteColor];
    if (corner) {
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = frame.size.width / 2.0;
    }
    
    button.frame = frame;
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    return button;
}
// 创建label
- (UILabel *)labelWithTitle:(NSString *)title color:(UIColor *)color textColot:(UIColor *)textColor frame:(CGRect)frame center:(CGPoint)centerPoint superView:(UIView *)view
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.center = centerPoint;
    label.text = title;
    label.textColor = textColor;
    label.font = [UIFont systemFontOfSize:20.0];
    label.backgroundColor = color;
    [view addSubview:label];
    return label;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
