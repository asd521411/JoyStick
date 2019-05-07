//
//  YHHandShankView.h
//  重写摇杆
//
//  Created by 草帽~小子 on 2017/5/18.
//  Copyright © 2017年 HLJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@protocol YHHandShankViewDelegate <NSObject>

- (void)joyStickCoordinateChangeData;

@end



@interface YHHandShankView : UIView


@property (nonatomic, strong) UIImageView *stickBack;
@property (nonatomic, strong) UIImageView *stick;
//计算移动的距离相对于摇杆背景滑动的距离
@property (nonatomic, readonly) CGFloat radio;

@property (nonatomic, readonly) double straightSpeed;
@property (nonatomic, readonly) double turnSpeed;
@property (nonatomic, readonly) double M1;
@property (nonatomic, readonly) double M2;

@property (nonatomic, strong) id<YHHandShankViewDelegate>delegate;

@end
