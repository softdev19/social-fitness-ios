//
//  JWRoundCornerView.m
//  ArtExhibition
//
//  Copyright © 2016 Jack Dawson. All rights reserved.
//

#import "JWRoundCornerView.h"


@implementation JWRoundCornerView
@dynamic borderColor, borderWidth, cornerRadius;

- (void)setBorderColor:(UIColor *)borderColor {
    [self.layer setBorderColor:borderColor.CGColor];
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    [self.layer setBorderWidth:borderWidth];
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    if(cornerRadius == -1) {
        [self.layer setCornerRadius:self.frame.size.height/2];
    } else {
        [self.layer setCornerRadius:cornerRadius];
    }
    [self.layer setMasksToBounds:YES];
}

- (void) layoutSubviews{    
    [self setCornerRadius: -1];
}
@end
