//
//  BigInteractiveView.h
//  ImitateLive
//
//  Created by lanou3g on 16/7/13.
//  Copyright © 2016年 SJH. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BigInteractiveViewDelegate <NSObject>
/**
 *  返回按钮代理方法
 *
 *  @param button 返回按钮
 */
- (void)backLastViewController:(UIButton *)button;
/**
 *  全屏按钮代理方法
 *
 *  @param button 全屏按钮
 */
- (void)fullScreenAction:(UIButton *)button;
/**
 *  锁屏按钮代理方法
 *
 *  @return 锁屏按钮
 */
- (void)lockScreenAction:(UIButton *)button;
/**
 *  播放按钮代理方法
 *
 *  @param buttton 播放按钮
 */
- (void)playOrPauseAction:(UIButton *)buttton;
/**
 *  分享按钮代理方法
 *
 *  @param button 分享按钮
 */
- (void)shareVideoAction:(UIButton *)button;
/**
 *  设置按钮代理方法
 *
 *  @param button 设置按钮
 */
- (void)settingAction:(UIButton *)button;
/**
 *  高清按钮代理方法
 *
 *  @param button 清晰度按钮
 */
- (void)definitionAction:(UIButton *)button;
/**
 *  是否打开弹幕
 *
 *  @param button 打开弹幕按钮
 */
- (void)isBarrageAction:(UIButton *)button;
/**
 *   进度条代理方法
 *
 *  @param progress 进度条
 */
- (void)progressSLiderValueChangedAction:(UISlider *)progress;
@end

@interface BigInteractiveView : UIView
// 一直有
@property (strong, nonatomic) UIView *topBackgroundView;// 顶部背景视图
@property (strong, nonatomic) UIView *bottomBackgroundView;// 底部背景视图
@property (strong, nonatomic) UIButton *backBtn;// 返回按钮
@property (strong, nonatomic) UIButton *fullScreenBtn;// 全屏按钮
@property (strong, nonatomic) UIButton *playOrPauseBtn;// 播放暂停按钮
@property (strong, nonatomic) UILabel *titleLabel;// 标题
@property (strong, nonatomic) UIButton *lockScreenBtn;// 锁屏按钮
@property (strong, nonatomic) UIImageView *onlineImage;// 在线图片
@property (strong, nonatomic) UILabel *onlineLabel;// 在线人数
// 直播
@property (strong, nonatomic) UIButton *shareBtn;// 分享按钮
@property (strong, nonatomic) UIButton *lineBtn;// 主线按钮
@property (strong, nonatomic) UIButton *definitionBtn;// 清晰度按钮
@property (strong, nonatomic) UIButton *settingBtn;// 设置按钮
@property (strong, nonatomic) UIButton *sendBtn;// 发送弹幕按钮
@property (strong, nonatomic) UIButton *isBarrage;// 是否打开弹幕按钮
@property (strong, nonatomic) UITextField *barrageTextField;// 写弹幕

// 历史视屏
@property (strong, nonatomic) UISlider *progressSlider;// 进度条
@property (strong, nonatomic) UILabel *nowTimeLabel;// 当前时间
@property (strong, nonatomic) UILabel *longTimeLabel;// 总时长


// 是否是历史视频
@property (assign, nonatomic) BOOL isHistory;

@property (weak, nonatomic) id<BigInteractiveViewDelegate> delegate;

@property (strong, nonatomic) NSTimer *timer;

@end
