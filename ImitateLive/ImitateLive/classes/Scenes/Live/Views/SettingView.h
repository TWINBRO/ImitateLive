//
//  SettingView.h
//  ImitateLive
//
//  Created by lanou3g on 16/7/15.
//  Copyright © 2016年 SJH. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,barrageSize) {
    bigBarrageSize = 100,
    middleBarrageSize,
    littleBarrageSize
};
typedef NS_ENUM(NSInteger,barragePosition) {
    topScreen = 200,
    fullScreen,
    bottomScreen
};
@protocol settingViewDelegate <NSObject>

// 弹幕大小代理方法
- (void)barrageSizeAction:(UIButton *)button size:(barrageSize)size;
// 弹幕透明度
- (void)barrageTransparencySliderValueChanged:(UISlider *)slider;
// 弹幕位置代理方法
- (void)barragePositionAction:(UIButton *)button position:(barragePosition)position;
// 定时休眠
- (void)timeSleepSwitchAction:(UISwitch *)timeSwitch;
@end
@interface SettingView : UIView
// 五个label
// 弹幕大小
@property (strong,nonatomic) UILabel *barrageSizeLabel;
// 三个button
// 大
@property (strong,nonatomic) UIButton *bigBarrageBtn;
// 中
@property (strong,nonatomic) UIButton *middleBarrageBtn;
// 小
@property (strong,nonatomic) UIButton *littleBarrageBtn;
// 弹幕透明度
@property (strong,nonatomic) UILabel *barrageTransparencyLabel;
// 一个slider
@property (strong,nonatomic) UISlider *transparencySlider;
// 弹幕位置
@property (strong,nonatomic) UILabel *barragePositionLabel;
// 上方
@property (strong,nonatomic) UIButton *topScreenBtn;
// 全屏
@property (strong,nonatomic) UIButton *fullScreenBtn;
// 下方
@property (strong,nonatomic) UIButton *bottomScreenBtn;
// 解码方式
@property (strong,nonatomic) UILabel *decodingProcessLabel;
// 两个click
// 软解

// 硬解

// 定时休眠
@property (strong,nonatomic) UILabel *timeSleepLabel;
// 一个UIswitch
@property (strong,nonatomic) UISwitch *timeSleepSwitch;

@property (weak, nonatomic) id<settingViewDelegate> delegate;
@end
