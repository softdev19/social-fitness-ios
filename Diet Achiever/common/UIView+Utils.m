//
//  UIView+Utils.m
//  UberforXOwner
//
//  Created by khs125 on 26/12/14.
//  Copyright (c) 2014 Jigs. All rights reserved.
//

#import "UIView+Utils.h"

@implementation UIView (Utils)

- (void)applyRoundedCorners {
    self.layer.cornerRadius = 5.0;
    self.layer.masksToBounds = YES;
}

- (void)applyRoundedCornersLess {
    self.layer.cornerRadius = 3.0;
    self.layer.masksToBounds = YES;
}

- (void)applyRoundedCornersFull {
    self.layer.cornerRadius = (self.frame.size.width / 2);
    self.layer.masksToBounds = YES;
}

- (void)applyRoundedCornersFullWithColor:(UIColor *)color {
    self.layer.cornerRadius = (self.frame.size.width / 2);
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = 3.0f;
    self.layer.masksToBounds = YES;
}

@end
