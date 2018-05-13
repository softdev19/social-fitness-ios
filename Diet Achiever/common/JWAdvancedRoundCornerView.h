//
//  JWAdvancedRoundCornerView.h
//  ArtExhibition
//
//  Copyright © 2016 Jack Dawson. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface JWAdvancedRoundCornerView : UIView
@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;
@property (nonatomic, assign) IBInspectable UIColor *borderColor;
@property (nonatomic, assign) IBInspectable UIColor *backColor;
@property (nonatomic, assign) IBInspectable BOOL topLeft;
@property (nonatomic, assign) IBInspectable BOOL topRight;
@property (nonatomic, assign) IBInspectable BOOL bottomLeft;
@property (nonatomic, assign) IBInspectable BOOL bottomRight;
@end
