//
//  GuessView.m
//  WXQImageOverturn
//
//  Created by WXQ on 2019/6/28.
//  Copyright © 2019 WXQ. All rights reserved.
//

#import "GuessView.h"

@interface GuessView()
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIImageView *imageView;
@end
@implementation GuessView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.label];
        [self addSubview:self.imageView];
    }
    return self;
}

#pragma mark - Event Response
// 刮奖图层
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent*)event {
    UITouch *touch = touches.anyObject;
    CGPoint point = [touch locationInView:self.imageView];
    //设置滑块区域大小
    CGRect rect = CGRectMake(point.x-20,point.y-20,40,40);
    //获取上下文，设置为透明
    UIGraphicsBeginImageContextWithOptions(self.imageView.bounds.size, NO, 0);
    CGContextRef ref = UIGraphicsGetCurrentContext();
    //把imageView的layer映射到上下文中
    [self.imageView.layer renderInContext:ref];
    //清除划过的区域
    CGContextClearRect(ref, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //返回图片并不断的传给UIImageView上去显示
    self.imageView.image = image;
}
- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc]initWithFrame:self.bounds];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.text = @"我是答案";
        _label.textColor = [UIColor redColor];
        _label.font = [UIFont systemFontOfSize:30];
    }
    return _label;
}
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:self.bounds];
        _imageView.image = [UIImage imageNamed:@"guess"];
    }
    return _imageView;
}
@end
