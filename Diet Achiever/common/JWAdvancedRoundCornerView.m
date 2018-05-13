//
//  JWAdvancedRoundCornerView.m
//  ArtExhibition
//
//  Copyright © 2016 Jack Dawson. All rights reserved.
//

#import "JWAdvancedRoundCornerView.h"

@interface JWAdvancedRoundCornerView()
@property (strong, nonatomic) NSMutableDictionary *data;
@end

@implementation JWAdvancedRoundCornerView
@dynamic borderColor, backColor, borderWidth, cornerRadius, topLeft, topRight, bottomLeft, bottomRight;

- (id) initWithCoder:(NSCoder *)aDecoder {
    if(self = [super initWithCoder:aDecoder]) {
        _data = [[NSMutableDictionary alloc] init];
        [_data setObject:[UIColor clearColor] forKey:@"borderColor"];
        [_data setObject:[UIColor clearColor] forKey:@"backColor"];
        [_data setObject:@(0) forKey:@"borderWidth"];
        [_data setObject:@(0) forKey:@"cornerRadius"];
        [_data setObject:@(NO) forKey:@"topLeft"];
        [_data setObject:@(NO) forKey:@"topRight"];
        [_data setObject:@(NO) forKey:@"bottomLeft"];
        [_data setObject:@(NO) forKey:@"bottomRight"];
    }
    
    return self;
}

- (void)setBorderColor:(UIColor *)borderColor {
    [_data setObject:borderColor forKey:@"borderColor"];
    [self updateUI];
}

- (void)setBackColor:(UIColor *)backColor {
    [_data setObject:backColor forKey:@"backColor"];
    [self updateUI];
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    [_data setObject:@(borderWidth) forKey:@"borderWidth"];
    [self updateUI];
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    [_data setObject:@(cornerRadius) forKey:@"cornerRadius"];
    [self updateUI];
}

- (void)setTopLeft:(BOOL)topLeft {
    [_data setObject:@(topLeft) forKey:@"topLeft"];
    [self updateUI];
}

- (void)setTopRight:(BOOL)topRight {
    [_data setObject:@(topRight) forKey:@"topRight"];
    [self updateUI];
}

- (void)setBottomLeft:(BOOL)bottomLeft {
    [_data setObject:@(bottomLeft) forKey:@"bottomLeft"];
    [self updateUI];
}

- (void)setBottomRight:(BOOL)bottomRight {
    [_data setObject:@(bottomRight) forKey:@"bottomRight"];
    [self updateUI];
}

- (void)updateUI {
    UIBezierPath *maskPath;
    CGRect rect = self.bounds;
    
    UIRectCorner corners = 0;
    if([[_data objectForKey:@"topLeft"] boolValue]) {
        corners |= UIRectCornerTopLeft;
    }
    if([[_data objectForKey:@"topRight"] boolValue]) {
        corners |= UIRectCornerTopRight;
    }
    if([[_data objectForKey:@"bottomLeft"] boolValue]) {
        corners |= UIRectCornerBottomLeft;
    }
    if([[_data objectForKey:@"bottomRight"] boolValue]) {
        corners |= UIRectCornerBottomRight;
    }
    
    CGFloat cornerR = [[_data objectForKey:@"cornerRadius"] floatValue];
    
    if(cornerR == -1) {
        cornerR = self.bounds.size.height / 2;
    }
    maskPath = [UIBezierPath bezierPathWithRoundedRect:rect
                                     byRoundingCorners:corners
                                           cornerRadii:CGSizeMake(cornerR, cornerR)];
    
    NSArray *sublayers = [[self layer] sublayers];
    BOOL alreadyAdded = NO;
    
    CAShapeLayer *maskLayer = nil;
    
    for(id layer in sublayers) {
        if([layer isKindOfClass:[CAShapeLayer class]]) {
            maskLayer = layer;
            alreadyAdded = YES;
        }
    }
    
    if(!alreadyAdded) {
        maskLayer = [[CAShapeLayer alloc] init];
        [self.layer addSublayer:maskLayer];
    }
    
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    maskLayer.lineWidth = [[_data objectForKey:@"borderWidth"] floatValue];
    maskLayer.strokeColor = ((UIColor *)[_data objectForKey:@"borderColor"]).CGColor;
    maskLayer.fillColor = ((UIColor*)[_data objectForKey:@"backColor"]).CGColor;
    
}
@end
