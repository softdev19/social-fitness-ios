//
//  JWRoundCornerView.h
//  ArtExhibition
//
//  Copyright © 2016 Jack Dawson. All rights reserved.
//

#import <UIKit/UIKit.h>


IB_DESIGNABLE
@interface JWRoundCornerView : UIView
@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;
@property (nonatomic, assign) IBInspectable UIColor *borderColor;
@end
