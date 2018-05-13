//
//  UIAlertView+Starlet.m
//  Starlet
//
//  Created by khs125 on 20/08/2013.
//  Copyright (c) 2013 Starlet. All rights reserved.
//

#import "UIAlertView+Starlet.h"
#import <objc/runtime.h>

@implementation UIAlertView (Starlet)

- (UILabel*)getBodyTextLabel {
    Ivar ivar = class_getInstanceVariable([self class], "_bodyTextLabel");
    void* labelptr = ((__bridge void*)self) + ivar_getOffset(ivar);
    UILabel* label = (__bridge_transfer UILabel*)(*(void**)labelptr);
    return label;
}

+ (void)showMessage:(NSString*)message {
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alert show];
}

+ (void)showMessage:(NSString*)message align:(NSTextAlignment)alignment {
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    UILabel* bodyLabel = [alert getBodyTextLabel];
    if (bodyLabel)
        bodyLabel.textAlignment = alignment;
    [alert show];
}

+ (UIAlertView*)showAlertMessage:(NSString*)message delegate:(id)delegate {
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil message:message delegate:delegate cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
    UILabel* bodyLabel = [alert getBodyTextLabel];
    if (bodyLabel) {
        bodyLabel.font = [UIFont systemFontOfSize:14];
    }
    [alert show];
    return alert;
}

@end

@interface UIDataAlertView()
@end

@implementation UIDataAlertView

@synthesize anyData;

+ (UIDataAlertView*)showAlertMessage:(NSString*)message delegate:(id)delegate data:(id)data  {
    UIDataAlertView* alert = [[UIDataAlertView alloc] initWithTitle:nil message:message delegate:delegate cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
    UILabel* bodyLabel = [alert getBodyTextLabel];
    if (bodyLabel) {
        bodyLabel.font = [UIFont systemFontOfSize:14];
    }
    
    alert.anyData = data;
    
    [alert show];
    return alert;
}


@end
