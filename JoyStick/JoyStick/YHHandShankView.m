//
//  YHHandShankView.m
//  重写摇杆
//
//  Created by 草帽~小子 on 2017/5/18.
//  Copyright © 2017年 HLJ. All rights reserved.
//

#import "YHHandShankView.h"
#define PI 3.14159265358979323846 
@implementation YHHandShankView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1];
        
        self.stickBack = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.stickBack.image = [UIImage imageNamed:@"pic_plate"];
        //self.stickBack.backgroundColor = [UIColor cyanColor];
        //self.stickBack.layer.cornerRadius = self.frame.size.width / 2;
        //self.stickBack.layer.masksToBounds = YES;
        //self.stickBack.userInteractionEnabled = YES;
        [self addSubview:self.stickBack];
        self.stickBack.contentMode = UIViewContentModeScaleToFill;
        //[self.stickBack sizeToFit];
        
        self.stick = [[UIImageView alloc] initWithFrame:CGRectMake(40, 40, 40, 40)];
        self.stick.image = [UIImage imageNamed:@"btn_centeryellow_h"];
        //self.stick.backgroundColor = [UIColor orangeColor];
        self.stick.layer.cornerRadius = self.stick.frame.size.width / 2;
        self.stick.layer.masksToBounds = YES;
        [self addSubview:self.stick];
        self.stick.contentMode = UIViewContentModeScaleToFill;
        [self.stick sizeToFit];
        self.stick.center = self.stickBack.center;
        
    }
    return self;
}

//- (void)drawRect:(CGRect)rect  {
//    CGContextRef context = UIGraphicsGetCurrentContext();
//   
//    /*画圆*/
//    //边框圆
//    CGContextSetRGBStrokeColor(context, 234.0/255.0, 144.0/255.0, 78.0/255.0, 1);//画笔线的颜色
//    CGContextSetLineWidth(context, 1.0);//线的宽度
//    //void CGContextAddArc(CGContextRef c,CGFloat x, CGFloat y,CGFloat radius,CGFloat startAngle,CGFloat endAngle, int clockwise)1弧度＝180°/π （≈57.3°） 度＝弧度×180°/π 360°＝360×π/180 ＝2π 弧度
//    // x,y为圆点坐标，radius半径，startAngle为开始的弧度，endAngle为 结束的弧度，clockwise 0为顺时针，1为逆时针。
//    CGContextAddArc(context, 100, 100, 100, 0, 2*PI, 0); //添加一个圆
//    CGContextDrawPath(context, kCGPathStroke); //绘制路径
//    
//    
//}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //NSLog(@"begin%f %f", self.center.x, self.center.y);
    UITouch *touch = [touches anyObject];
    CGPoint tapPoint = [ touch locationInView:self.stickBack];
    
    self.stick.center = tapPoint;
   
    CGPoint backCenter = self.stickBack.center;
    CGPoint move = [touch locationInView:self.stickBack];
    CGFloat r = self.stickBack.frame.size.width / 2 - self.stick.frame.size.width / 2;
    
    CGFloat d = (move.x - backCenter.x)*(move.x - backCenter.x) + (move.y - backCenter.y)*(move.y - backCenter.y);
    CGFloat R = sqrt(d);
    CGFloat x = backCenter.x -  r / R * (backCenter.x - move.x);
    CGFloat y = backCenter.y +  r / R * (move.y - backCenter.y);
    
    if (R > r) {
        
        self.stick.center = CGPointMake(x , y);
    
    }else {
        self.stick.center = CGPointMake(move.x, move.y);
      
        }

    CGFloat dis = sqrt((self.stick.center.x - self.stickBack.center.x)*(self.stick.center.x - self.stickBack.center.x) + (self.stick.center.y - self.stickBack.center.y)*(self.stick.center.y - self.stickBack.center.y));
    _radio = dis / (self.stickBack.frame.size.width / 2 - self.stick.frame.size.width / 2);
    
    if ([self.delegate respondsToSelector:@selector(joyStickCoordinateChangeData)]) {
        [self.delegate joyStickCoordinateChangeData];
    }
    
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint backCenter = self.stickBack.center;
    CGPoint move = [touch locationInView:self.stickBack];
//    NSString *str = NSStringFromCGPoint(move);
//    NSString *back = NSStringFromCGPoint(backCenter);
    //NSLog(@"back  %f %f  %f str%f",  self.stickBack.center.x,self.stickBack.center.y, move.x, move.y);
    
    
    CGFloat r = self.stickBack.frame.size.width / 2 - self.stick.frame.size.width / 2;
    CGFloat d = (move.x - backCenter.x)*(move.x - backCenter.x) + (move.y - backCenter.y)*(move.y - backCenter.y);
    CGFloat R = sqrt(d);
    CGFloat x = backCenter.x -  r / R * (backCenter.x - move.x);
    CGFloat y = backCenter.y +  r / R * (move.y - backCenter.y);
    
    if (R > r) {
       
        self.stick.center = CGPointMake(x , y);
        _straightSpeed = (backCenter.y - y) * 255 / r;
        _turnSpeed = (x - backCenter.x) * 255 / r;
        
        //NSLog(@"111111    %f %f", _straightSpeed, _turnSpeed);
        
        
        if (_turnSpeed >= 0) {
            _turnSpeed = _turnSpeed - fabs(_straightSpeed) / 2 ;
            
            if (_turnSpeed < 0) {
                _turnSpeed = 0;
            }else if (_turnSpeed > 255) {
                _turnSpeed = 255;
            }
            
            
        } else {
            _turnSpeed = _turnSpeed + fabs(_straightSpeed) / 2;
            
            if (_turnSpeed < -255) {
                _turnSpeed = -255;
            }else if (_turnSpeed > 0) {
                _turnSpeed = 0;
            }
            
        }
        
    }else {
        self.stick.center = CGPointMake(move.x, move.y);
        _straightSpeed = (backCenter.y - move.y) * 255 / r;
        _turnSpeed = (move.x - backCenter.x) * 255 / r;
        
        //NSLog(@"111111    %f %f", _straightSpeed, _turnSpeed);
        
        if (_turnSpeed >= 0) {
            _turnSpeed = _turnSpeed - fabs(_straightSpeed) / 2;
            
            if (_turnSpeed < 0) {
                _turnSpeed = 0;
            }else if (_turnSpeed > 255) {
                _turnSpeed = 255;
            }
            
        }else {
            _turnSpeed = _turnSpeed + fabs(_straightSpeed) / 2;
            
            if (_turnSpeed < -255) {
                _turnSpeed = -255;
            }else if (_turnSpeed > 0) {
                _turnSpeed = 0;
            }
            
            
        }
        
        
    }
    _M1 = _straightSpeed + _turnSpeed;
    _M2 = _straightSpeed - _turnSpeed;
    
    NSLog(@"qqqqqqqqssss%f     %f  %f   %f", _M1, _M2, _straightSpeed, _turnSpeed);
    

    CGFloat dis = sqrt((self.stick.center.x - self.stickBack.center.x)*(self.stick.center.x - self.stickBack.center.x) + (self.stick.center.y - self.stickBack.center.y)*(self.stick.center.y - self.stickBack.center.y));
    _radio = dis / (self.stickBack.frame.size.width / 2 - self.stick.frame.size.width / 2);
    
    if ([self.delegate respondsToSelector:@selector(joyStickCoordinateChangeData)]) {
        [self.delegate joyStickCoordinateChangeData];
    }
    
}


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.stick.center = self.stickBack.center;
    
    CGFloat dis = sqrt((self.stick.center.x - self.stickBack.center.x)*(self.stick.center.x - self.stickBack.center.x) + (self.stick.center.y - self.stickBack.center.y)*(self.stick.center.y - self.stickBack.center.y));
    _radio = dis / (self.stickBack.frame.size.width / 2 - self.stick.frame.size.width / 2);
    
    
    if ([self.delegate respondsToSelector:@selector(joyStickCoordinateChangeData)]) {
        [self.delegate joyStickCoordinateChangeData];
    }
    //创建通知对象
    NSNotification *notification = [NSNotification notificationWithName:@"joyStickMoveState" object:nil];
    //Name是通知的名称 object是通知的发布者(是谁要发布通知,也就是对象) userInfo是一些额外的信息(通知发布者传递给通知接收者的信息内容，字典格式)
    //    [NSNotification notificationWithName:@"tongzhi" object:nil userInfo:nil];
    //发送通知
    [[NSNotificationCenter defaultCenter] postNotification:notification];
   
    
}




//- (void)layoutSubviews {
//    [super layoutSubviews];
//    self.stickBack.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
//    self.stick.frame = CGRectMake(40, 40, 40, 40);
//}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
