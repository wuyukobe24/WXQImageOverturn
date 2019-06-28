//
//  FrontView.m
//  WXQImageOverturn
//
//  Created by WXQ on 2019/6/28.
//  Copyright © 2019 WXQ. All rights reserved.
//

#import "FrontView.h"

@interface FrontView()
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIImageView *imageView;
@end
@implementation FrontView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.imageView];
        [self addSubview:self.label];
    }
    return self;
}

- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 250, 100)];
        _label.center = CGPointMake(self.center.x, self.center.y-80);
        _label.textAlignment = NSTextAlignmentCenter;
        _label.text = @"点击图片翻转";
        _label.textColor = [UIColor redColor];
        _label.font = [UIFont systemFontOfSize:30];
    }
    return _label;
}
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:self.bounds];
        _imageView.image = [UIImage imageNamed:@"front"];
    }
    return _imageView;
}
@end
