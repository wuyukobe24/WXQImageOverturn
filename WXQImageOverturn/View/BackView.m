//
//  BackView.m
//  WXQImageOverturn
//
//  Created by WXQ on 2019/6/28.
//  Copyright © 2019 WXQ. All rights reserved.
//

#import "BackView.h"
#import "GuessView.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
@interface BackView()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) GuessView *guessView;
@end
@implementation BackView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.imageView];
        [self addSubview:self.guessView];
    }
    return self;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:self.bounds];
        _imageView.image = [UIImage imageNamed:@"back"];
    }
    return _imageView;
}
- (GuessView *)guessView {
    if (!_guessView) {
        _guessView = [[GuessView alloc]initWithFrame:CGRectMake(0, 0, 200, 70)];
        _guessView.center = CGPointMake(self.center.x, self.center.y+80);
    }
    return _guessView;
}
@end
