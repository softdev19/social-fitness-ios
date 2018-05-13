//
//  JWDynamicLabel.m
//  Diet Achiever
//
//  Created by khs125 on 2/23/17.
//  Copyright © 2017 summit. All rights reserved.
//

#import "JWDynamicLabel.h"
#import "PrefixHeader.pch"

@implementation JWDynamicLabel

- (void) setFont:(UIFont *)font{
    [super setFont:font];
}

- (void) layoutSubviews{
    float basesize = self.font.pointSize;
    
    if(_setFlag)
        return;
    
    _setFlag = true;
    if(isPhoneWidth320){
        [self setFont:[UIFont fontWithName:self.font.fontName size:basesize * 320/375]];
    }
    else if(isPhoneWidth375){
        [self setFont:[UIFont fontWithName:self.font.fontName size:basesize]];
    }
    else{
        [self setFont:[UIFont fontWithName:self.font.fontName size:basesize * 414/375]];
    }
    
}
@end
