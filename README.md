# WXQImageOverturn
点击图片无限翻转以及刮奖效果图：

![图片翻转.gif](https://upload-images.jianshu.io/upload_images/4037795-1d458913bed95e84.gif?imageMogr2/auto-orient/strip)

**整体思路**：
首先需要创建三个视图，即正面`FrontView`、背面`BackView`以及刮奖`GuessView`。然后在`FrontView`上添加点击手势`UITapGestureRecognizer`，在点击手势响应事件中利用`CAAnimation`的旋转动画对`FrontView`进行旋转操作。执行的旋转方法代码如下：
```
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
```
上述旋转方法中设置`FrontView`旋转一次时间为1s，且在旋转时间执行一半即0.5s时执行延迟添加背面`BackView`的方法，并根据记录当前的正反面来显示/隐藏`BackView`。最后通过不断的点击`FrontView`来达到无限翻转的动画效果。

**刮奖**的效果则是通过方法`- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent*)event`来不断改变刮奖图片的显示/隐藏区域。刮奖效果方法如下：
```
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
```
