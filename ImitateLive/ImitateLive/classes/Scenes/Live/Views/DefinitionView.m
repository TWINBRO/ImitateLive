//
//  DefinitionView.m
//  ImitateLive
//
//  Created by ssx on 16/7/15.
//  Copyright © 2016年 SJH. All rights reserved.
//

#import "DefinitionView.h"

#define KWidth self.frame.size.width
#define KHeight self.frame.size.height

@implementation DefinitionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatButton];
        self.backgroundColor = YD_COLOR(115, 115, 115, 0.7);
    }
    return self;
}
- (void)creatButton
{
    self.superDefinition = [self buttonWithImage:@"btn_cq_normal@2x" frame:CGRectMake(0, 0, 120, 90) action:@selector(superDefinitionClick:) superView:self corner:NO];
    self.superDefinition.center = CGPointMake(110, KHeight / 2.0);
    self.highDefinition = [self buttonWithImage:@"btn_gq_pressed@2x" frame:CGRectMake(0, 0, 120, 90) action:@selector(highDefinitionClick:) superView:self corner:NO];
    self.highDefinition.center = CGPointMake(KWidth / 2.0, KHeight / 2.0);
    self.standardDefinition = [self buttonWithImage:@"btn_bq_normal@2x" frame:CGRectMake(350, 0,  120, 90) action:@selector(standardDefinitionClick:) superView:self corner:NO];
    self.standardDefinition.center = CGPointMake(KWidth - 110, KHeight / 2.0);
}
- (void)superDefinitionClick:(UIButton *)btn
{
    if (_delegate) {
        btn.tag = 201;
        [self.superDefinition setImage:[UIImage imageNamed:@"btn_cq_pressed@2x"] forState:UIControlStateNormal];
        [self.highDefinition setImage:[UIImage imageNamed:@"btn_gq_normal@2x"] forState:UIControlStateNormal];
        [self.standardDefinition setImage:[UIImage imageNamed:@"btn_bq_normal@2x"] forState:UIControlStateNormal];
        [_delegate adjustDefinitionAction:btn definition:superDefinition];
    }
}
- (void)highDefinitionClick:(UIButton *)btn
{
    if (_delegate) {
        btn.tag = 202;
        [self.superDefinition setImage:[UIImage imageNamed:@"btn_cq_normal@2x"] forState:UIControlStateNormal];
        [self.highDefinition setImage:[UIImage imageNamed:@"btn_gq_pressed@2x"] forState:UIControlStateNormal];
        [self.standardDefinition setImage:[UIImage imageNamed:@"btn_bq_normal@2x"] forState:UIControlStateNormal];
        [_delegate adjustDefinitionAction:btn definition:highDefinition];
    }
}
- (void)standardDefinitionClick:(UIButton *)btn
{
    if (_delegate) {
        btn.tag = 203;
        [self.superDefinition setImage:[UIImage imageNamed:@"btn_cq_normal@2x"] forState:UIControlStateNormal];
        [self.highDefinition setImage:[UIImage imageNamed:@"btn_gq_normal@2x"] forState:UIControlStateNormal];
        [self.standardDefinition setImage:[UIImage imageNamed:@"btn_bq_pressed@2x"] forState:UIControlStateNormal];
        [_delegate adjustDefinitionAction:btn definition:standardDefinition];
    }
}

// 创建按钮
- (UIButton *)buttonWithImage:(NSString *)image frame:(CGRect)frame action:(SEL)action superView:(UIView *)view corner:(BOOL)corner
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
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
