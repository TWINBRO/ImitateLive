//
//  HeaderView.h
//  ImitateLive
//
//  Created by ssx on 16/7/13.
//  Copyright © 2016年 SJH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"
@interface HeaderView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UILabel *headerTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (strong, nonatomic) HomeModel *homeModel;
@end
