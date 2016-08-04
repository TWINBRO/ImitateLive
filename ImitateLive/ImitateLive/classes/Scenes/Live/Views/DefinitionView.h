//
//  DefinitionView.h
//  ImitateLive
//
//  Created by ssx on 16/7/15.
//  Copyright © 2016年 SJH. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,Definition) {
    superDefinition = 300,
    highDefinition,
    standardDefinition
};

@protocol DefinitionViewDelegate <NSObject>
// 代理方法
- (void)adjustDefinitionAction:(UIButton *)button definition:(Definition)definition;
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
