//
//  UIView+Starlet.m
//  Rize
//
//  Created by khs125 on 7/24/14.
//  Copyright (c) 2014 Powerhouse. All rights reserved.
//

#import "UIView+Starlet.h"

@implementation UIView (Starlet)

- (void)rubberAnimationWithDuration:(CGFloat)duration {
    [self.layer removeAnimationForKey:@"rubberAnimation"];
    
    self.layer.anchorPoint = CGPointMake(0.5, 0.5);
    self.layer.contentsGravity = kCAGravityResizeAspect;

    CABasicAnimation *theAnimation;
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_7_1) {
        theAnimation=[CABasicAnimation animationWithKeyPath:@"transform"];
        theAnimation.duration = duration;
        theAnimation.repeatCount = 1;
        theAnimation.autoreverses = YES;
        theAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)];
    } else {
        theAnimation=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
        theAnimation.duration = duration;
        theAnimation.repeatCount = 1;
        theAnimation.autoreverses = YES;
        theAnimation.fromValue = @(1.f);
        theAnimation.toValue = @(1.2); //[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)];
    }
    theAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.34 :0.01 :0.69 :1.37];
    theAnimation.removedOnCompletion = YES;
    [self.layer addAnimation:theAnimation forKey:@"rubberAnimation"];
}

- (void)scaleAnimationWithDuration:(CGFloat)duration scale:(CGFloat)factor {
    [self.layer removeAnimationForKey:@"scaleAnimation"];
    
    self.layer.anchorPoint = CGPointMake(0.5, 0.5);
    self.layer.contentsGravity = @"center";
    
    CABasicAnimation *theAnimation;
    theAnimation=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
    theAnimation.duration = duration;
    theAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    theAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(factor, factor, 1.0)];
    [self.layer addAnimation:theAnimation forKey:@"scaleAnimation"];
}

- (void)frameAnimationWithDuration:(CGFloat)duration frame:(CGRect)newFrame {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:duration];
    [self setFrame:newFrame];
    [UIView commitAnimations];
}

- (NSString*)getCATransitionTypeFromCoverType:(CoverType)nType {
    NSString* tttype = kCATransitionFromLeft;
    switch (nType) {
        case Cover_FromRight:
            tttype = kCATransitionFromRight;
            break;
        case Cover_FromTop:
            tttype = kCATransitionFromTop;
            break;
        case Cover_FromBottom:
            tttype = kCATransitionFromBottom;
            break;
        case Cover_FromLeft:
        default:
            break;
    }
    return tttype;
}

- (void)coverAnimationWithDuration:(CGFloat)duration type:(CoverType)fromType {
    [self coverAnimationWithDuration:duration type:fromType repeat:NO];
}

- (void)coverAnimationWithDuration:(CGFloat)duration type:(CoverType)fromType repeat:(BOOL)forever {
    [self.layer removeAnimationForKey:kCATransition];
    CATransition* transition = [CATransition animation];
    transition.duration = duration;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.repeatCount = (forever ? HUGE_VALF : 1);
    transition.subtype = [self getCATransitionTypeFromCoverType:fromType];
    if (forever)
        transition.autoreverses = YES;
    [self.layer addAnimation:transition forKey:kCATransition];
}

- (void)removeCoverAnimation {
//    [self.layer removeAllAnimations];
    [self.layer removeAnimationForKey:kCATransition];
}
- (void)startLayer {
    self.layer.speed = 1.0;
    self.layer.timeOffset = 0.0;
    self.layer.beginTime = 0.0;
}
- (void)stopLayer {
    self.layer.speed = 0.0;
    self.layer.timeOffset = 0.0;
    self.layer.beginTime = 0.0;
}
- (void)pauseLayer {
    CFTimeInterval pausedTime = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    self.layer.speed = 0.0;
    self.layer.timeOffset = pausedTime;
}
- (void)resumeLayer {
    CFTimeInterval pausedTime = [self.layer timeOffset];
    self.layer.speed = 1.0;
    self.layer.timeOffset = 0.0;
    self.layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    self.layer.beginTime = timeSincePause;
}

- (void)fadeAnimationWithDuration:(CGFloat)duration {
    [self fadeAnimationWithDuration:duration repeat:NO];
}
- (void)fadeAnimationWithDuration:(CGFloat)duration repeat:(BOOL)repeat {
    [self.layer removeAnimationForKey:@"fadeAnimation"];
    
    CATransition* transition = [CATransition animation];
    transition.duration = duration;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    transition.repeatCount = (repeat ? HUGE_VALF : 1);
    [self.layer addAnimation:transition forKey:@"fadeAnimation"];
}

- (void)changeColorAnimationWithColor:(UIColor*)newColor duration:(CGFloat)duration forever:(BOOL)isForever {
    [self.layer removeAnimationForKey:@"changeColorAnimation"];
    
    UIColor* orgColor = self.backgroundColor;
    
    CABasicAnimation *theAnimation;
    theAnimation=[CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    theAnimation.duration = duration;
    theAnimation.repeatCount = (isForever ? HUGE_VALF : 1);
    theAnimation.autoreverses = (isForever ? YES : NO);
    theAnimation.fromValue = (__bridge id)(orgColor.CGColor);
    theAnimation.toValue = (__bridge id)(newColor.CGColor);
    [self.layer addAnimation:theAnimation forKey:@"changeColorAnimation"];

}

- (void)jumpAnimationWithDuration:(CGFloat)duration {
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform"];
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    anim.duration = 0.125;
    anim.repeatCount = 1;
    anim.autoreverses = YES;
    anim.removedOnCompletion = YES;
    anim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)];
    [self.layer addAnimation:anim forKey:nil];
/*
    [UIView animateWithDuration:.5 delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         CGRect f = imageView.frame;
                         f.origin.y -= 40;
                         imView.frame = f;
                     }
                     completion:^{
                         [UIView animateWithDuration:.7 delay:0.0
                                             options:UIViewAnimationOptionCurveEaseOut
                                          animations:^{
                                              CGRect f = imageView.frame;
                                              f.origin.y += 40;
                                              imView.frame = f;
                                          }
                                          completion:nil];
                     }];
 */
}

- (void)pathAnimationWithDuration:(CGFloat)duration toPosition:(CGPoint)destPosition {
    // Set up path movement
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.calculationMode = kCAAnimationPaced;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.repeatCount = 1;
    //pathAnimation.rotationMode = @"auto";
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    pathAnimation.duration = duration;
    
    CGRect frame = self.frame;
    
    // Create a circle path
    CGMutablePathRef curvedPath = CGPathCreateMutable();
    CGPathMoveToPoint(curvedPath, NULL, frame.origin.x, frame.origin.y);
    CGPathAddArcToPoint(curvedPath, NULL, frame.origin.x, frame.origin.y, destPosition.x, destPosition.y, 20);
    
    pathAnimation.path = curvedPath;
    CGPathRelease(curvedPath);
    
    [self.layer addAnimation:pathAnimation forKey:@"myCircleAnimation"];
}

- (void) runVibrateAnimationWithDuration:(CGFloat)duration repeat:(NSInteger)repeat
{
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.fromValue = [NSNumber numberWithFloat: -M_PI / 2.0];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI / 2.0];
    rotationAnimation.duration = duration;
    //rotationAnimation.cumulative = YES;
    rotationAnimation.autoreverses = YES;
    rotationAnimation.repeatCount = repeat;
    
    [self.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

- (void)setShadow {
    CGRect frame = self.frame;
    frame.origin = CGPointZero;
    self.layer.shadowPath = [UIBezierPath bezierPathWithRect:frame].CGPath;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(2.5, 2.5);
    self.layer.shadowOpacity = .75f;
    self.layer.shadowRadius = 4;
}

- (NSLayoutConstraint*)widthConstraint {
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"firstAttribute = %d AND secondAttribute = %d", NSLayoutAttributeWidth, NSLayoutAttributeNotAnAttribute];
    NSArray* filteredWidths = [self.constraints filteredArrayUsingPredicate:predicate];
    if (filteredWidths.count <= 0)
        return nil;
    return [filteredWidths objectAtIndex:0];
}

- (NSLayoutConstraint*)heightConstraint {
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"firstAttribute = %d AND secondAttribute = %d", NSLayoutAttributeHeight, NSLayoutAttributeNotAnAttribute];
    NSArray* filteredHeights = [self.constraints filteredArrayUsingPredicate:predicate];
    if (filteredHeights.count <= 0)
        return nil;
    return [filteredHeights objectAtIndex:0];
}

- (NSLayoutConstraint*)bottomConstraint {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"secondItem = %@ AND secondAttribute = %d", self, NSLayoutAttributeBottom];
    NSArray* filteredBottoms = [self.superview.constraints filteredArrayUsingPredicate:predicate];
    if (filteredBottoms.count < 1) {
        predicate = [NSPredicate predicateWithFormat:@"firstItem = %@ AND firstAttribute = %d", self, NSLayoutAttributeBottom];
        filteredBottoms = [self.superview.constraints filteredArrayUsingPredicate:predicate];
    }
    return filteredBottoms.firstObject;
}

- (NSLayoutConstraint*)centerXConstraint {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"secondItem = %@ AND secondAttribute = %d", self, NSLayoutAttributeCenterX];
    NSArray* filteredCenterX = [self.superview.constraints filteredArrayUsingPredicate:predicate];
    if (filteredCenterX.count < 1) {
        predicate = [NSPredicate predicateWithFormat:@"firstItem = %@ AND firstAttribute = %d", self, NSLayoutAttributeCenterX];
        filteredCenterX = [self.superview.constraints filteredArrayUsingPredicate:predicate];
    }
    return filteredCenterX.firstObject;
}

- (NSLayoutConstraint*)trailingConstraint {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"secondItem = %@ AND secondAttribute = %d", self, NSLayoutAttributeTrailing];
    NSArray* filteredTrailing = [self.superview.constraints filteredArrayUsingPredicate:predicate];
    if (filteredTrailing.count < 1) {
        predicate = [NSPredicate predicateWithFormat:@"firstItem = %@ AND firstAttribute = %d", self, NSLayoutAttributeTrailing];
        filteredTrailing = [self.superview.constraints filteredArrayUsingPredicate:predicate];
    }
    return filteredTrailing.firstObject;
}

#pragma mark -

- (void)setupRound:(CGFloat) radius border:(CGFloat)width {
    self.layer.cornerRadius = radius;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.layer.borderWidth = width;
}

- (void)setBottomLineWithColor:(UIColor*)color {
    CGFloat scale = fmax(1, [UIScreen mainScreen].scale);
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    lineLayer.backgroundColor = color.CGColor;
    lineLayer.frame = CGRectMake(0, self.frame.size.height - 1, self.frame.size.width, 1 / scale);
    //lineLayer.anchorPoint = CGPointMake(0, 0);
    [self.layer addSublayer:lineLayer];
    self.layer.masksToBounds = YES;
}

#pragma mark - Gesture

- (UISwipeGestureRecognizer*)leftSwipeGesture {
    for (UIGestureRecognizer* gesture in self.gestureRecognizers) {
        if ([gesture isKindOfClass:UISwipeGestureRecognizer.class]) {
            if (((UISwipeGestureRecognizer*)gesture).direction == UISwipeGestureRecognizerDirectionLeft)
                return (UISwipeGestureRecognizer*)gesture;
        }
    }
    return nil;
}
- (UISwipeGestureRecognizer*)rightSwipeGesture {
    for (UIGestureRecognizer* gesture in self.gestureRecognizers) {
        if ([gesture isKindOfClass:UISwipeGestureRecognizer.class]) {
            if (((UISwipeGestureRecognizer*)gesture).direction == UISwipeGestureRecognizerDirectionRight)
                return (UISwipeGestureRecognizer*)gesture;
        }
    }
    return nil;
}
- (UISwipeGestureRecognizer*)upSwipeGesture {
    for (UIGestureRecognizer* gesture in self.gestureRecognizers) {
        if ([gesture isKindOfClass:UISwipeGestureRecognizer.class]) {
            if (((UISwipeGestureRecognizer*)gesture).direction == UISwipeGestureRecognizerDirectionDown)
                return (UISwipeGestureRecognizer*)gesture;
        }
    }
    return nil;
}


@end

@implementation HMShadowView

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self setShadow];
}

@end
