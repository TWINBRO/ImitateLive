//
//  DefinitionView.m
//  ImitateLive
//
//  Created by lanou3g on 16/7/15.
//  Copyright © 2016年 SJH. All rights reserved.
//

#import "DefinitionView.h"

#define Width self.frame.size.width / 2.0
#define Height self.frame.size.height

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
    self.superDefinition = [self buttonWithImage:@"btn_cq_pressed@2x" frame:CGRectMake(0, 0, 120, 90) action:@selector(superDefinitionClick:) superView:self corner:NO];
    self.superDefinition.center = CGPointMake(110, Width);
    self.highDefinition = [self buttonWithImage:@"btn_gq_normal@2x" frame:CGRectMake(Height / 2.0, Width,  120, 90) action:@selector(highDefinitionClick:) superView:self corner:NO];
    self.highDefinition.center = CGPointMake(Height / 2.0, Width);
    self.standardDefinition = [self buttonWithImage:@"btn_bq_normal@2x" frame:CGRectMake(350, Width,  120, 90) action:@selector(standardDefinitionClick:) superView:self corner:NO];
    self.standardDefinition.center = CGPointMake(Height - 110, Width);
}
- (void)superDefinitionClick:(UIButton *)btn
{
    if (_delegate) {
        [self.superDefinition setImage:[UIImage imageNamed:@"btn_cq_pressed@2x"] forState:UIControlStateNormal];
        [self.highDefinition setImage:[UIImage imageNamed:@"btn_gq_normal@2x"] forState:UIControlStateNormal];
        [self.standardDefinition setImage:[UIImage imageNamed:@"btn_bq_normal@2x"] forState:UIControlStateNormal];
        [_delegate adjustDefinitionAction:btn definition:superDefinition];
    }
}
- (void)highDefinitionClick:(UIButton *)btn
{
    if (_delegate) {
        [self.superDefinition setImage:[UIImage imageNamed:@"btn_cq_normal@2x"] forState:UIControlStateNormal];
        [self.highDefinition setImage:[UIImage imageNamed:@"btn_gq_pressed@2x"] forState:UIControlStateNormal];
        [self.standardDefinition setImage:[UIImage imageNamed:@"btn_bq_normal@2x"] forState:UIControlStateNormal];
        [_delegate adjustDefinitionAction:btn definition:highDefinition];
    }
}
- (void)standardDefinitionClick:(UIButton *)btn
{
    if (_delegate) {
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
