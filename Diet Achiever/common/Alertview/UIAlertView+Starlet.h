//
//  UIAlertView+Starlet.h
//  Starlet
//
//  Created by khs125 on 20/08/2013.
//  Copyright (c) 2013 Starlet. All rights reserved.
//

#import <UIKit/UIKit.h>

#define OKButton        1
#define CancelButton    0

@interface UIAlertView (Starlet)

+ (void)showMessage:(NSString*)message;
+ (void)showMessage:(NSString*)message align:(NSTextAlignment)alignment;
+ (UIAlertView*)showAlertMessage:(NSString*)message delegate:(id)delegate;

@end

@interface UIDataAlertView : UIAlertView
@property (strong, nonatomic) id anyData;

+ (UIDataAlertView*)showAlertMessage:(NSString*)message delegate:(id)delegate data:(id)data;

@end
