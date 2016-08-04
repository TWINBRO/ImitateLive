//
//  SendBarrageView.h
//  ImitateLive
//
//  Created by ssx on 16/7/21.
//  Copyright © 2016年 SJH. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol sendBarrageViewDelegate <NSObject>
/**
 *  发送弹幕按钮
 *
 *  @param button 按钮
 */
- (void)sendBarrageClickAction:(UIButton *)button;

@end

@interface SendBarrageView : UIView
@property (strong, nonatomic) UIButton *sendBtn;// 发送弹幕按钮
@property (strong, nonatomic) UITextView *barrageTextView;// 写弹幕
@property (weak,   nonatomic) id<sendBarrageViewDelegate> delegate;
@end
