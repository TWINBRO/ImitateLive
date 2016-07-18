//
//  LittleInteractiveView.h
//  ImitateLive
//
//  Created by lanou3g on 16/7/13.
//  Copyright © 2016年 SJH. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol littleInteractiveViewDelegate <NSObject>
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
 *  分享按钮代理方法
 *
 *  @param button 分享按钮
 */
- (void)shareVideoAction:(UIButton *)button;
/**
 *  播放按钮代理方法
 *
 *  @param buttton 播放按钮
 */
- (void)playOrPauseAction:(UIButton *)buttton;
/**
 *   进度条代理方法
 *
 *  @param progress 进度条
 */
- (void)progressSLiderValueChanged:(UISlider *)progress;
@end

@interface LittleInteractiveView : UIView
// 一直有
@property (strong, nonatomic) UIButton *backBtn;// 返回按钮
@property (strong, nonatomic) UIButton *fullScreenBtn;// 全屏按钮
// 直播视频过有分享
@property (strong, nonatomic) UIButton *shareBtn;// 分享按钮
// 历史视屏
@property (strong, nonatomic) UIView *bottonView;
@property (strong, nonatomic) UIButton *playOrPauseBtn;// 播放暂停按钮
@property (strong, nonatomic) UILabel *nowTimeLabel;// 当前时间
@property (strong, nonatomic) UILabel *longTimeLabel;// 总时长
@property (strong, nonatomic) UISlider *progressSlider;// 进度条

@property (weak, nonatomic) id<littleInteractiveViewDelegate> delegate;

@property (strong, nonatomic) NSTimer *timer;
@end
