//
//  DefinitionView.h
//  ImitateLive
//
//  Created by lanou3g on 16/7/15.
//  Copyright © 2016年 SJH. All rights reserved.
//

#import <UIKit/UIKit.h>

enum definition{
    superDefinition,
    highDefinition,
    standardDefinition
};

@protocol DefinitionViewDelegate <NSObject>

// 超清代理方法
- (void)superDefinitionAction:(UIButton *)buttton;
// 高清代理方法
- (void)highDefinitionAction:(UIButton *)buttton;
// 标清代理方法
- (void)standardDefinition:(UIButton *)buttton;

@end

@interface DefinitionView : UIView
// 超清按钮
@property (strong, nonatomic) UIButton *superDefinition;
// 高清按钮
@property (strong, nonatomic) UIButton *highDefinition;
// 标清按钮
@property (strong, nonatomic) UIButton *standardDefinition;

// 代理
@property (weak, nonatomic) id<DefinitionViewDelegate> delegate;

@end
