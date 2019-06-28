//
//  ViewController.m
//  WXQImageOverturn
//
//  Created by WXQ on 2019/6/28.
//  Copyright © 2019 WXQ. All rights reserved.
//

#import "ViewController.h"
#import "FrontView.h"
#import "BackView.h"

@interface ViewController ()<CAAnimationDelegate>
@property (nonatomic, strong) UITapGestureRecognizer *startTap;
@property (nonatomic, strong) FrontView *frontView;
@property (nonatomic, strong) BackView *backView;
@property (nonatomic, assign, getter=isCurrentBack) BOOL currentBack; ///< 当前是否是背面，默认NO
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.frontView];
}
// 旋转方法
- (void)startRevolveImageView {
    if (self.currentBack) {
        self.currentBack = NO;
    } else {
        self.currentBack = YES;
    }
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animation];
    // 旋转角度，其中的value表示图像旋转的最终位置
    keyAnimation.values = [NSArray arrayWithObjects:
                           [NSValue valueWithCATransform3D:CATransform3DMakeRotation(0, 0,1,0)],
                           [NSValue valueWithCATransform3D:CATransform3DMakeRotation((M_PI/2), 0,1,0)],
                           [NSValue valueWithCATransform3D:CATransform3DMakeRotation(0, 0,1,0)],
                           nil];
    keyAnimation.cumulative = NO;
    keyAnimation.duration = 1.0f;
    keyAnimation.repeatCount = 1;
    keyAnimation.removedOnCompletion = NO;
    keyAnimation.delegate = self;
    [self.frontView.layer addAnimation:keyAnimation forKey:@"transform"];
    if (self.currentBack) {
        [self performSelector:@selector(addBehindView) withObject:nil afterDelay:0.5f];
    } else {
        [self performSelector:@selector(addForentView) withObject:nil afterDelay:0.5f];
    }
}
// 恢复展示前面view
- (void)addForentView {
    self.backView.hidden = YES;
}
// 添加旋转后背面view
- (void)addBehindView {
    self.backView.hidden = NO;
    [self.frontView addSubview:self.backView];
}
// 点击图片
- (void)clickImage {
    [self startRevolveImageView];
}
- (FrontView *)frontView {
    if (!_frontView) {
        _frontView = [[FrontView alloc]initWithFrame:CGRectMake(0, 0, 250, 320)];
        _frontView.center = self.view.center;
        UITapGestureRecognizer *startTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImage)];
        [_frontView addGestureRecognizer:startTap];
    }
    return _frontView;
}
- (BackView *)backView {
    if (!_backView) {
        _backView = [[BackView alloc]initWithFrame:CGRectMake(0, 0, 250, 320)];
    }
    return _backView;
}
@end
