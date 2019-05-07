//
//  ViewController.m
//  JoyStick
//
//  Created by 草帽~小子 on 2019/5/7.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "ViewController.h"
#import "YHHandShankView.h"

@interface ViewController ()<YHHandShankViewDelegate>

@property (nonatomic, strong) UIImageView *manualBackV;
@property (nonatomic, strong) YHHandShankView *customView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self joyStick];
    // Do any additional setup after loading the view.
}

#pragma mark 摇杆
- (void)joyStick {
    //摇杆
    self.customView = [[YHHandShankView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width)];
    //[self.customView sizeToFit];
    self.customView.delegate = self;
    [self.view addSubview:self.customView];
    self.customView.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.width / 2);
}

- (void)joyStickCoordinateChangeData {
    
}

- (void)joyStickCoordinateChangeDataNotification:(NSNotification *)notice {
    
}

@end
