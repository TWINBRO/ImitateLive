//
//  SendBarrageView.m
//  ImitateLive
//
//  Created by lanou3g on 16/7/21.
//  Copyright © 2016年 SJH. All rights reserved.
//

#import "SendBarrageView.h"
#define kWidth self.frame.size.width
#define kHeight self.frame.size.height

@implementation SendBarrageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatBarrage];
        self.backgroundColor = YD_COLOR(115, 115, 115, 0.6);
    }
    return self;
}
- (void)creatBarrage
{
    self.sendBtn = [self buttonWithImage:@"发送弹幕" frame:CGRectMake(0, 0, 60, 40) center:CGPointMake(kWidth - 40,  30) backgroundColor:[UIColor clearColor] action:@selector(sendBarrageClick:) superView:self corner:NO];
    
    self.barrageTextView = [[UITextView alloc] initWithFrame:CGRectMake(30, 10, kWidth - 140, 40)];
    self.barrageTextView.backgroundColor = [UIColor greenColor];
    
    [self addSubview:self.barrageTextView];
}
- (void)sendBarrageClick:(UIButton *)btn
{
    if (_delegate) {
        [_delegate sendBarrageClickAction:btn];
    }
    [self.barrageTextView resignFirstResponder];
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
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.hidden = YES;
    [self.barrageTextView resignFirstResponder];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
