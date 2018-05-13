//
//  UIView+Starlet.h
//  Rize
//
//  Created by khs125 on 7/24/14.
//  Copyright (c) 2014 Powerhouse. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    Cover_FromLeft = 0,
    Cover_FromRight = 1,
    Cover_FromTop = 2,
    Cover_FromBottom
} CoverType;

@interface UIView (Starlet)

- (void)rubberAnimationWithDuration:(CGFloat)duration;
- (void)scaleAnimationWithDuration:(CGFloat)duration scale:(CGFloat)factor;
- (void)frameAnimationWithDuration:(CGFloat)duration frame:(CGRect)newFrame;
- (void)coverAnimationWithDuration:(CGFloat)duration type:(CoverType)fromType;
- (void)coverAnimationWithDuration:(CGFloat)duration type:(CoverType)fromType repeat:(BOOL)forever;
- (void)removeCoverAnimation;

- (void)startLayer;
- (void)stopLayer;
- (void)pauseLayer;
- (void)resumeLayer;

- (void)fadeAnimationWithDuration:(CGFloat)duration;
- (void)fadeAnimationWithDuration:(CGFloat)duration repeat:(BOOL)repeat;
- (void)changeColorAnimationWithColor:(UIColor*)newColor duration:(CGFloat)duration forever:(BOOL)isForever;
- (void)jumpAnimationWithDuration:(CGFloat)duration;
- (void)pathAnimationWithDuration:(CGFloat)duration toPosition:(CGPoint)destPosition;
- (void)runVibrateAnimationWithDuration:(CGFloat)duration repeat:(NSInteger)repeat;

- (void)setShadow;
- (NSLayoutConstraint*)widthConstraint;
- (NSLayoutConstraint*)heightConstraint;
- (NSLayoutConstraint*)bottomConstraint;
- (NSLayoutConstraint*)centerXConstraint;
- (NSLayoutConstraint*)trailingConstraint;

- (void)setupRound:(CGFloat) radius border:(CGFloat)width;
- (void)setBottomLineWithColor:(UIColor*)color;

- (UISwipeGestureRecognizer*)leftSwipeGesture;
- (UISwipeGestureRecognizer*)rightSwipeGesture;
- (UISwipeGestureRecognizer*)upSwipeGesture;

@end

@interface HMShadowView : UIView

@end
